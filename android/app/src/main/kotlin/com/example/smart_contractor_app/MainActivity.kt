package com.example.smart_contractor_app

import android.app.Activity
import android.content.ContentValues
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.os.Environment
import android.provider.MediaStore
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.io.IOException

class MainActivity : FlutterActivity() {
    private companion object {
        const val PDF_CHANNEL = "smart_contractor/pdf_export"
        const val CREATE_PDF_REQUEST = 701
        const val PDF_MIME_TYPE = "application/pdf"
        const val DOWNLOAD_FOLDER = "Smart Contractor"
    }

    private var pendingSave: PendingSave? = null

    private data class PendingSave(
        val bytes: ByteArray,
        val result: MethodChannel.Result,
    )

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, PDF_CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method != "savePdf") {
                    result.notImplemented()
                    return@setMethodCallHandler
                }

                val name = call.argument<String>("name")
                val bytes = call.argument<ByteArray>("bytes")
                if (name.isNullOrBlank() || bytes == null || bytes.isEmpty()) {
                    result.error("invalid_pdf", "A filename and PDF bytes are required.", null)
                    return@setMethodCallHandler
                }
                if (pendingSave != null) {
                    result.error("save_in_progress", "A PDF is already being saved.", null)
                    return@setMethodCallHandler
                }

                val save = PendingSave(bytes, result)
                pendingSave = save
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.Q) {
                    val folder = "${Environment.DIRECTORY_DOWNLOADS}/$DOWNLOAD_FOLDER"
                    writePdf(save, "Downloads/$DOWNLOAD_FOLDER") {
                        val values = ContentValues().apply {
                            put(MediaStore.MediaColumns.DISPLAY_NAME, name)
                            put(MediaStore.MediaColumns.MIME_TYPE, PDF_MIME_TYPE)
                            put(MediaStore.MediaColumns.RELATIVE_PATH, folder)
                            put(MediaStore.MediaColumns.IS_PENDING, 1)
                        }
                        contentResolver.insert(MediaStore.Downloads.EXTERNAL_CONTENT_URI, values)
                            ?: throw IOException("Could not create the Downloads entry.")
                    }
                } else {
                    val intent = Intent(Intent.ACTION_CREATE_DOCUMENT).apply {
                        addCategory(Intent.CATEGORY_OPENABLE)
                        type = PDF_MIME_TYPE
                        putExtra(Intent.EXTRA_TITLE, name)
                    }
                    try {
                        @Suppress("DEPRECATION")
                        startActivityForResult(intent, CREATE_PDF_REQUEST)
                    } catch (error: Exception) {
                        pendingSave = null
                        result.error("save_failed", error.message, null)
                    }
                }
            }
    }

    @Deprecated("Uses FlutterActivity's activity result callback for the system save picker.")
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        @Suppress("DEPRECATION")
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode != CREATE_PDF_REQUEST) return

        val save = pendingSave ?: return
        if (resultCode != Activity.RESULT_OK) {
            pendingSave = null
            save.result.success(null)
            return
        }

        val uri = data?.data
        if (uri == null) {
            pendingSave = null
            save.result.error("save_failed", "The save picker returned no file.", null)
            return
        }
        writePdf(save, null, uri)
    }

    private fun writePdf(
        save: PendingSave,
        downloadLocation: String?,
        documentUri: Uri? = null,
        createDownload: (() -> Uri)? = null,
    ) {
        Thread {
            var uri: Uri? = documentUri
            try {
                val destination = documentUri ?: requireNotNull(createDownload).invoke()
                uri = destination
                val output = contentResolver.openOutputStream(destination, "w")
                    ?: throw IOException("Could not open the PDF for writing.")
                output.use { it.write(save.bytes) }

                if (downloadLocation != null) {
                    val published = ContentValues().apply {
                        put(MediaStore.MediaColumns.IS_PENDING, 0)
                    }
                    if (contentResolver.update(destination, published, null, null) == 0) {
                        throw IOException("Could not publish the PDF in Downloads.")
                    }
                }

                runOnUiThread {
                    pendingSave = null
                    save.result.success(downloadLocation ?: "")
                }
            } catch (error: Exception) {
                uri?.let { failedUri ->
                    runCatching { contentResolver.delete(failedUri, null, null) }
                }
                runOnUiThread {
                    pendingSave = null
                    save.result.error("save_failed", error.message, null)
                }
            }
        }.start()
    }
}
