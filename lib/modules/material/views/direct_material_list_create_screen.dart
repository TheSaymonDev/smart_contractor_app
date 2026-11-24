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

class DirectMaterialListCreateScreen extends StatelessWidget {
  const DirectMaterialListCreateScreen({super.key});

  final List<String> clients = const [
    'আব্দুল করিম',
    'সেলিম মিয়া',
    'হানিফ স্টোর',
    'রহিমা বেগম',
  ];

  final List<String> workTypes = const [
    'প্লাম্বিং',
    'ইলেক্ট্রিক্যাল',
    'পাইপ ফিটিংস',
    'স্যানিটারি',
    'কনস্ট্রাকশন',
  ];

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MaterialWizardController>()) {
      Get.put(MaterialWizardController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'সরাসরি তালিকা তৈরি',
        subtitle: 'টেমপ্লেট ছাড়াও শুরু করুন',
      ),
      body: GetBuilder<MaterialWizardController>(
        builder: (controller) {
          return Column(
            children: [
              // Step 2 Stepper
              const MaterialWizardStepper(currentStep: 2),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. Client Selection
                      Text('ক্লায়েন্ট', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      _buildClientSelector(context, controller),

                      SizedBox(height: 6.h),
                      InkWell(
                        onTap: () {
                          Get.snackbar('নতুন ক্লায়েন্ট', 'ক্লায়েন্ট ফর্ম');
                        },
                        child: Text(
                          '+ নতুন ক্লায়েন্ট যোগ করুন',
                          style: AppTextStyles.custom(
                            size: 13.sp,
                            color: AppColors.primary,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // 2. Work / List Name
                      AppTextField(
                        label: 'কাজ / তালিকার নাম',
                        controller: controller.directWorkNameController,
                        icon: Icons.work_outline_rounded,
                        hint: 'ট্যাংকের নতুন লাইন',
                      ),

                      SizedBox(height: 12.h),

                      // 3. Work Type Dropdown
                      Text('কাজের ধরন', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      _buildWorkTypeDropdown(context, controller),

                      SizedBox(height: 12.h),

                      // 4. Address Field
                      AppTextField(
                        label: 'কাজের ঠিকানা',
                        controller: controller.directAddressController,
                        icon: Icons.location_on_outlined,
                        hint: 'মিরপুর-১০, ঢাকা',
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
                                'সেভ করলে এই নামে একটি কাজ তৈরি হবে। কাজ, মালামাল ও PDF পরে সেখানেই পাবেন।',
                                style: AppTextStyles.custom(
                                  size: 12.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 16.h),

                      // Add Material Placeholder Box
                      AppCard(
                        padding: EdgeInsets.symmetric(
                            vertical: 24.h, horizontal: 16.w),
                        child: Column(
                          children: [
                            Container(
                              width: 50.w,
                              height: 50.w,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.layers_outlined,
                                color: AppColors.primary,
                                size: 28.sp,
                              ),
                            ),
                            SizedBox(height: 12.h),
                            Text('এখন মালামাল যোগ করুন',
                                style: AppTextStyles.mediumBlackBold),
                            SizedBox(height: 4.h),
                            Text('যা যা লাগবে, একটি করে লিখুন',
                                style: AppTextStyles.smallGrey),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Bottom Action Button
                      AppPrimaryButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.materialItemAddEditScreen);
                        },
                        text: 'মালামাল যোগ করুন',
                        icon: Icons.add,
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

  Widget _buildClientSelector(
      BuildContext context, MaterialWizardController controller) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.person_outline_rounded,
              color: AppColors.textSecondary, size: 20.sp),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              controller.directClientName,
              style: AppTextStyles.mediumBlackBold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkTypeDropdown(
      BuildContext context, MaterialWizardController controller) {
    return Container(
      height: 52.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
      child: Row(
        children: [
          Icon(Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary, size: 22.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              controller.directWorkType,
              style: AppTextStyles.mediumBlackBold,
            ),
          ),
        ],
      ),
    );
  }
}
