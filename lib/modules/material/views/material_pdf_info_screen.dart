import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialPdfInfoScreen extends StatelessWidget {
  const MaterialPdfInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MaterialWizardController>()) {
      Get.put(MaterialWizardController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'PDF-এর তথ্য',
        subtitle: 'পাঠানোর আগে একবার দেখে নিন',
      ),
      body: GetBuilder<MaterialWizardController>(
        builder: (controller) {
          return Column(
            children: [
              // Step 3 Stepper
              const MaterialWizardStepper(currentStep: 3),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Contractor Info Card
                      AppCard(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section Header Bar
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ঠিকাদারের তথ্য',
                                    style: AppTextStyles.custom(
                                      size: 14.sp,
                                      color: AppColors.primary,
                                      weight: FontWeight.w800,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.businessSetupScreen,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.primary,
                                          size: 14.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          'এডিট',
                                          style: AppTextStyles.custom(
                                            size: 12.sp,
                                            color: AppColors.primary,
                                            weight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.contractorName,
                                    style: AppTextStyles.custom(
                                      size: 15.sp,
                                      color: AppColors.textPrimary,
                                      weight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    'মোবাইল: ${controller.contractorPhone} • ঠিকানা: ${controller.contractorAddress}',
                                    style: AppTextStyles.smallGrey,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // 2. Client Info Card
                      AppCard(
                        padding: EdgeInsets.all(12.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Section Header Bar
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'ক্লায়েন্টের তথ্য',
                                    style: AppTextStyles.custom(
                                      size: 14.sp,
                                      color: AppColors.primary,
                                      weight: FontWeight.w800,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.toNamed(
                                        AppRoutes.clientManagementScreen,
                                      );
                                    },
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.edit_outlined,
                                          color: AppColors.primary,
                                          size: 14.sp,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          'এডিট',
                                          style: AppTextStyles.custom(
                                            size: 12.sp,
                                            color: AppColors.primary,
                                            weight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 4.w),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.clientName,
                                    style: AppTextStyles.custom(
                                      size: 15.sp,
                                      color: AppColors.textPrimary,
                                      weight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    'মোবাইল: ${controller.clientPhone} • ঠিকানা: ${controller.clientAddress}',
                                    style: AppTextStyles.smallGrey,
                                  ),
                                  SizedBox(height: 3.h),
                                  Text(
                                    'কাজের নাম: ${controller.jobName}',
                                    style: AppTextStyles.custom(
                                      size: 12.sp,
                                      color: AppColors.primary,
                                      weight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // 3. Section Title: PDF-এ কী দেখাবেন?
                      Text(
                        'PDF-এ কী দেখাবেন?',
                        style: AppTextStyles.custom(
                          size: 15.sp,
                          color: AppColors.textPrimary,
                          weight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 8.h),

                      // Toggle Checkbox 1: Show Prices
                      _buildToggleCheckboxRow(
                        title: 'মালামালের দাম দেখান',
                        subtitle: 'দাম না দিলেও PDF হবে',
                        value: controller.showPricesInPdf,
                        onChanged: (val) {
                          controller.setShowPricesInPdf(val ?? false);
                        },
                      ),

                      SizedBox(height: 8.h),

                      // Toggle Checkbox 2: Show Brand and Notes
                      _buildToggleCheckboxRow(
                        title: 'ব্র্যান্ড ও নোট দেখান',
                        subtitle: 'যেসব তথ্য লিখেছেন সেগুলো থাকবে',
                        value: controller.showBrandsAndNotesInPdf,
                        onChanged: (val) {
                          controller.setShowBrandsAndNotesInPdf(val ?? true);
                        },
                      ),

                      SizedBox(height: 14.h),

                      // Note for Client
                      AppTextField(
                        labelWidget: RichText(
                          text: TextSpan(
                            text: 'ক্লায়েন্টের জন্য নোট ',
                            style: AppTextStyles.mediumBlackBold,
                            children: [
                              TextSpan(
                                text: '(ইচ্ছা হলে)',
                                style: AppTextStyles.smallGrey,
                              ),
                            ],
                          ),
                        ),
                        controller: controller.clientNoteController,
                        hint: 'যেমন: কেনার আগে মাপ মিলিয়ে নিন',
                      ),

                      SizedBox(height: 14.h),

                      // Info Notice Box
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(12.w),
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
                                'এক বা একাধিক মালামালের দাম না থাকলে পূর্ণ মোট দেখাবে না।',
                                style: AppTextStyles.custom(
                                  size: 12.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Bottom Action Button -> Step 4
                      AppPrimaryButton(
                        onPressed: () {
                          controller.setStep(4);
                          Get.toNamed(
                            AppRoutes.materialPdfPreviewScreen,
                            arguments: controller.showPricesInPdf,
                          );
                        },
                        text: 'PDF প্রিভিউ দেখুন',
                        icon: Icons.description_outlined,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildToggleCheckboxRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: Checkbox(
              value: value,
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 2.h),
                Text(subtitle, style: AppTextStyles.smallGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
