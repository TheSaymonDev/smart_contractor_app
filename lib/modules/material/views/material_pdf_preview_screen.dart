import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pdfrx/pdfrx.dart';
import 'package:smart_contractor_app/core/services/pdf/pdf_service.dart';
import 'package:smart_contractor_app/core/services/pdf/templates/material_requisition_template.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_outlined_button.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';
import 'package:smart_contractor_app/modules/material/data/default_material_templates.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialPdfPreviewScreen extends StatefulWidget {
  const MaterialPdfPreviewScreen({super.key});

  @override
  State<MaterialPdfPreviewScreen> createState() =>
      _MaterialPdfPreviewScreenState();
}

class _MaterialPdfPreviewScreenState extends State<MaterialPdfPreviewScreen> {
  Uint8List? _cachedPdfBytes;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _generatePdf();
  }

  Future<void> _generatePdf() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _cachedPdfBytes = null;
    });

    try {
      final controller = Get.isRegistered<MaterialWizardController>()
          ? Get.find<MaterialWizardController>()
          : Get.put(MaterialWizardController());

      // Fallback template items if opened directly
      if (controller.selectedItems.isEmpty &&
          defaultCategoryTemplates['প্লাম্বিং ও পাইপ ফিটিংস'] != null) {
        final fallbackTpl =
            defaultCategoryTemplates['প্লাম্বিং ও পাইপ ফিটিংস']!.first;
        controller.selectedTemplate = fallbackTpl;
        controller.selectedItems = List.from(fallbackTpl.items);
      }

      bool showPrice = controller.showPricesInPdf;
      final args = Get.arguments;
      if (args is bool) {
        showPrice = args;
      }

      final fonts = await PdfService.loadBase64Fonts();

      final String htmlContent = MaterialRequisitionPdfTemplate.generateHtml(
        contractorName: controller.contractorName,
        contractorPhone: controller.contractorPhone,
        contractorAddress: controller.contractorAddress,
        clientName: controller.clientName,
        clientPhone: controller.clientPhone,
        clientAddress: controller.clientAddress,
        jobName: controller.jobName,
        items: controller.selectedItems,
        showPrice: showPrice,
        grandTotal: controller.grandTotal,
        clientNote: controller.clientNoteController.text.trim(),
        regularFontBase64: fonts['regular'],
        boldFontBase64: fonts['bold'],
      );

      final Uint8List pdfBytes = await PdfService.generateMaterialPdfFromHtml(
        htmlContent,
      );

      if (mounted) {
        setState(() {
          _cachedPdfBytes = pdfBytes;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<MaterialWizardController>()
        ? Get.find<MaterialWizardController>()
        : Get.put(MaterialWizardController());

    bool showPrice = controller.showPricesInPdf;
    final args = Get.arguments;
    if (args is bool) {
      showPrice = args;
    }

    final String clientName = controller.clientName;
    final String filename = 'Material_List_${clientName}_2026';

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'PDF প্রিভিউ',
        subtitle: showPrice
            ? 'মালামালের তালিকা • দামসহ'
            : 'মালামালের তালিকা • দাম ছাড়া',
      ),
      body: Column(
        children: [
          // Step 4 Stepper
          const MaterialWizardStepper(currentStep: 4),

          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
              child: Column(
                children: [
                  // Pdf Preview Section
                  Expanded(
                    child: _isLoading
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const CircularProgressIndicator(
                                  color: AppColors.primary,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  'A4 PDF ডকুমেন্ট তৈরি হচ্ছে...',
                                  style: AppTextStyles.custom(
                                    size: 13.sp,
                                    color: AppColors.primary,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : _errorMessage != null
                        ? Center(
                            child: Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.red,
                                    size: 32.sp,
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    'PDF জেনারেট করতে সমস্যা হয়েছে',
                                    style: AppTextStyles.mediumBlackBold,
                                  ),
                                  SizedBox(height: 8.h),
                                  AppOutlinedButton(
                                    onPressed: _generatePdf,
                                    text: 'আবার চেষ্টা করুন',
                                    icon: Icons.refresh_rounded,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),

                            child: PdfViewer.data(
                              _cachedPdfBytes!,

                              sourceName: 'material_list.pdf',

                              params: PdfViewerParams(
                                backgroundColor: Colors.transparent,
                                pageDropShadow: null,
                              ),
                            ),
                          ),
                  ),

                  SizedBox(height: 14.h),

                  // Bottom Info Notice Box
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline_rounded,
                          color: AppColors.primary,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            'সব তথ্য দেখে তারপর শেয়ার বা ডাউনলোড করুন।',
                            style: AppTextStyles.custom(
                              size: 12.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Bottom Action Buttons Row
                  Row(
                    children: [
                      // Download Button (User-accessible storage export)
                      Expanded(
                        child: AppOutlinedButton(
                          onPressed: _cachedPdfBytes == null
                              ? () {}
                              : () async {
                                  try {
                                    final String savedPath =
                                        await PdfService.downloadPdf(
                                          _cachedPdfBytes!,
                                          filename,
                                        );

                                    Get.snackbar(
                                      'PDF ডাউনলোড সম্পন্ন',
                                      'ফাইলটি ডিভাইসের স্টোরেজে সেভ হয়েছে: $savedPath',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: AppColors.primary,
                                      colorText: Colors.white,
                                    );
                                  } catch (e) {
                                    Get.snackbar(
                                      'ডাউনলোড ব্যর্থ',
                                      'ফাইল সেভ করতে সমস্যা হয়েছে: $e',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                          text: 'ডাউনলোড',
                          icon: Icons.download_rounded,
                        ),
                      ),

                      SizedBox(width: 10.w),

                      // Share Button (Native OS Share Sheet)
                      Expanded(
                        child: AppPrimaryButton(
                          onPressed: _cachedPdfBytes == null
                              ? () {}
                              : () async {
                                  try {
                                    await PdfService.sharePdf(
                                      _cachedPdfBytes!,
                                      filename,
                                    );
                                  } catch (e) {
                                    Get.snackbar(
                                      'শেয়ার ব্যর্থ',
                                      'PDF ফাইল শেয়ার করতে সমস্যা হয়েছে: $e',
                                      snackPosition: SnackPosition.BOTTOM,
                                      backgroundColor: Colors.red,
                                      colorText: Colors.white,
                                    );
                                  }
                                },
                          text: 'PDF শেয়ার করুন',
                          icon: Icons.share_rounded,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
