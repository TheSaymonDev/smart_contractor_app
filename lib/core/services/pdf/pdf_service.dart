
import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';

import 'package:flutter/foundation.dart'
    show debugPrint, kDebugMode;

import 'package:flutter_native_html_to_pdf/flutter_native_html_to_pdf.dart';

import 'package:path_provider/path_provider.dart';

import 'package:printing/printing.dart';

import 'pdf_pagination_service.dart';

class PdfService {
  PdfService._();

  // ignore: deprecated_member_use, deprecated_member_use_from_same_package
  static final HtmlToPdfConverter _htmlToPdfConverter =
  HtmlToPdfConverter();

  static String? _cachedRegularFontBase64;

  static String? _cachedBoldFontBase64;

  /// Load and cache local Bengali fonts.

  static Future<Map<String, String>>
  loadBase64Fonts() async {

    if (_cachedRegularFontBase64 != null &&
        _cachedBoldFontBase64 != null) {
      return {
        'regular': _cachedRegularFontBase64!,
        'bold': _cachedBoldFontBase64!,
      };
    }

    final regularBytes = await rootBundle.load(
      'assets/fonts/NotoSansBengali-Regular.ttf',
    );

    final boldBytes = await rootBundle.load(
      'assets/fonts/NotoSansBengali-Bold.ttf',
    );

    if (regularBytes.lengthInBytes == 0 ||
        boldBytes.lengthInBytes == 0) {
      throw StateError(
        'Bundled PDF fonts are empty.',
      );
    }

    _cachedRegularFontBase64 = base64Encode(
      regularBytes.buffer.asUint8List(
        regularBytes.offsetInBytes,
        regularBytes.lengthInBytes,
      ),
    );

    _cachedBoldFontBase64 = base64Encode(
      boldBytes.buffer.asUint8List(
        boldBytes.offsetInBytes,
        boldBytes.lengthInBytes,
      ),
    );

    return {
      'regular': _cachedRegularFontBase64!,
      'bold': _cachedBoldFontBase64!,
    };
  }

  /// Generic PDF generator.
  /// Retained for other document types.

  static Future<Uint8List> generatePdfFromHtml(
      String htmlContent, {
        String filename = 'document',
      }) async {

    final Directory targetDir =
    await getTemporaryDirectory();

    final File generatedPdfFile =
    await _htmlToPdfConverter.convertHtmlToPdf(
      html: htmlContent,
      targetDirectory: targetDir.path,
      targetName: filename,
    );

    if (await generatedPdfFile.exists()) {
      return generatedPdfFile.readAsBytes();
    }

    throw StateError(
      'PDF generation failed on native platform engine.',
    );
  }

  /// Material PDF generator.
  ///
  /// Uses native table pagination and actual
  /// last-page footer measurements.

  static Future<Uint8List>
  generateMaterialPdfFromHtml(
      String htmlContent,
      ) async {

    if (kDebugMode) {
      debugPrint(
        '[SC_PDF_FIX_V2] material PDF generator active',
      );
    }

    final bytes =
    await PdfPaginationService.anchorLastPageFooter(
      html: htmlContent,

      render: (html) async {

        return await _htmlToPdfConverter
            .convertHtmlToPdfBytes(
          html: html,
          pageSize: PdfPageSize.a4,
        );

      },
    );

    if (kDebugMode) {
      debugPrint(
        '[SC_PDF_FIX_V2] final PDF generated: '
            '${bytes.length} bytes',
      );
    }

    return bytes;
  }

  /// Exports the PDF to a location accessible from the device's Files app.
  /// Returns null when the system save picker is cancelled.
  static Future<String?> downloadPdf(
    Uint8List pdfBytes,
    String filename,
  ) async {
    if (pdfBytes.isEmpty) {
      throw ArgumentError('Cannot save an empty PDF.');
    }

    final name = filename.replaceAll(RegExp(r'[\\/\x00-\x1f]'), '_').trim();
    final baseName = name.isEmpty ? 'document' : name;

    if (Platform.isAndroid) {
      const channel = MethodChannel('smart_contractor/pdf_export');
      return channel.invokeMethod<String>('savePdf', {
        'name': '$baseName.pdf',
        'bytes': pdfBytes,
      });
    }

    if (Platform.isIOS) {
      final documents = await getApplicationDocumentsDirectory();
      var file = File('${documents.path}/$baseName.pdf');
      var suffix = 1;
      while (await file.exists()) {
        file = File('${documents.path}/$baseName (${suffix++}).pdf');
      }
      await file.writeAsBytes(pdfBytes, flush: true);
      return 'Files → On My iPhone/iPad → Smart Contractor App';
    }

    throw UnsupportedError('PDF export is supported on Android and iOS.');
  }

  /// Share the exact PDF bytes through
  /// the native operating system share sheet.

  static Future<void> sharePdf(
      Uint8List pdfBytes,
      String filename,
      ) async {

    final String sanitizedFilename =
    filename.replaceAll(
      RegExp(r'[^\w\s\-]'),
      '_',
    );

    await Printing.sharePdf(
      bytes: pdfBytes,
      filename: '$sanitizedFilename.pdf',
    );
  }
}
