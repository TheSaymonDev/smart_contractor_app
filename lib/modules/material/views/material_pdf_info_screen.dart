import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialPdfInfoScreen extends StatefulWidget {
  const MaterialPdfInfoScreen({super.key});

  @override
  State<MaterialPdfInfoScreen> createState() => _MaterialPdfInfoScreenState();
}

class _MaterialPdfInfoScreenState extends State<MaterialPdfInfoScreen> {
  bool showPrices = false;
  bool showBrandAndNotes = true;

  final TextEditingController clientNoteController =
      TextEditingController(text: 'কেনার আগে মাপ মিলিয়ে নিন');

  @override
  void dispose() {
    clientNoteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 24.sp,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PDF-এর তথ্য',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'পাঠানোর আগে একবার দেখে নিন',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Step 3 Stepper
          const MaterialWizardStepper(currentStep: 3),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Contractor Info Card
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ঠিকাদারের তথ্য',
                                style: AppTextStyles.mediumBlackBold),
                            InkWell(
                              onTap: () {
                                Get.snackbar('এডিট', 'ঠিকাদারের তথ্য সম্পাদনা');
                              },
                              child: Text(
                                'এডিট',
                                style: AppTextStyles.custom(
                                  size: 13.sp,
                                  color: AppColors.primary,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'রহমান কন্ট্রাক্টর সার্ভিস',
                          style: AppTextStyles.custom(
                            size: 15.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text('রহমান আলী • 01712-345678',
                            style: AppTextStyles.smallGrey),
                        SizedBox(height: 2.h),
                        Text('মিরপুর-১০, ঢাকা',
                            style: AppTextStyles.smallGrey),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Client Info Card
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('ক্লায়েন্টের তথ্য',
                                style: AppTextStyles.mediumBlackBold),
                            InkWell(
                              onTap: () {
                                Get.snackbar('এডিট', 'ক্লায়েন্টের তথ্য সম্পাদনা');
                              },
                              child: Text(
                                'এডিট',
                                style: AppTextStyles.custom(
                                  size: 13.sp,
                                  color: AppColors.primary,
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          'আব্দুল করিম',
                          style: AppTextStyles.custom(
                            size: 15.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text('01812-345678 • মিরপুর-১০, ঢাকা',
                            style: AppTextStyles.smallGrey),
                        SizedBox(height: 2.h),
                        Text('কাজ: করিমের বাসা • ২য় তলা',
                            style: AppTextStyles.smallGrey),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Section Title: PDF-এ কী দেখাবেন?
                  Text('PDF-এ কী দেখাবেন?',
                      style: AppTextStyles.mediumBlackBold),
                  SizedBox(height: 8.h),

                  // Toggle Checkbox 1: Show Prices
                  _buildToggleCheckboxRow(
                    title: 'মালামালের দাম দেখান',
                    subtitle: 'দাম না দিলেও PDF হবে',
                    value: showPrices,
                    onChanged: (val) {
                      setState(() {
                        showPrices = val ?? false;
                      });
                    },
                  ),

                  SizedBox(height: 8.h),

                  // Toggle Checkbox 2: Show Brand and Notes
                  _buildToggleCheckboxRow(
                    title: 'ব্র্যান্ড ও নোট দেখান',
                    subtitle: 'যেসব তথ্য লিখেছেন সেগুলো থাকবে',
                    value: showBrandAndNotes,
                    onChanged: (val) {
                      setState(() {
                        showBrandAndNotes = val ?? true;
                      });
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
                              text: '(ইচ্ছা হলে)', style: AppTextStyles.smallGrey),
                        ],
                      ),
                    ),
                    controller: clientNoteController,
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
                      Get.toNamed(
                        AppRoutes.materialPdfPreviewScreen,
                        arguments: showPrices,
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
