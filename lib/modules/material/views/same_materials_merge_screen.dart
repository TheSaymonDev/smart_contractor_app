import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';

class SameMaterialsMergeScreen extends StatelessWidget {
  const SameMaterialsMergeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MaterialWizardController>()) {
      Get.put(MaterialWizardController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'একটাই মালামাল যোগ হচ্ছে',
        subtitle: 'পরিমাণ যোগ হবে',
      ),
      body: GetBuilder<MaterialWizardController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Info Box
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
                          'দুই টেমপ্লেটে একই মালামাল থাকলে তা একটি হয়ে যাবে এবং মোট পরিমাণ হিসাব হবে।',
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

                // Item 1 Card
                _buildMergeCard(
                  name: 'PPR পাইপ (২০ মিমি)',
                  template1: '১ বাথরুমের পানির লাইন (৮০ ফুট)',
                  template2: '২ বাথরুমের পানির লাইন (১৪০ ফুট)',
                  combined: 'মোট হবে: ২২০ ফুট',
                  value: controller.mergeItem1,
                  onChanged: (val) {
                    controller.setMergeItem1(val ?? true);
                  },
                ),

                SizedBox(height: 12.h),

                // Item 2 Card
                _buildMergeCard(
                  name: 'PPR এলবো (২০ মিমি)',
                  template1: '১ বাথরুমের পানির লাইন (১২টি)',
                  template2: '২ বাথরুমের পানির লাইন (২০টি)',
                  combined: 'মোট হবে: ৩২টি',
                  value: controller.mergeItem2,
                  onChanged: (val) {
                    controller.setMergeItem2(val ?? true);
                  },
                ),

                SizedBox(height: 24.h),

                // Bottom Action Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'একত্রে যোগ করা হয়েছে',
                      'মালামাল সফলভাবে মার্জ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'একত্রে যোগ করুন',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildMergeCard({
    required String name,
    required String template1,
    required String template2,
    required String combined,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
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
              SizedBox(width: 8.w),
              Text(name, style: AppTextStyles.mediumBlackBold),
            ],
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.only(left: 32.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• $template1', style: AppTextStyles.smallGrey),
                SizedBox(height: 2.h),
                Text('• $template2', style: AppTextStyles.smallGrey),
                SizedBox(height: 6.h),
                Text(
                  combined,
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: AppColors.primary,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
