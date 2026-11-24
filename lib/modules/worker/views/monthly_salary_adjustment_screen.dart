import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/worker/controllers/worker_controller.dart';

class MonthlySalaryAdjustmentScreen extends StatelessWidget {
  const MonthlySalaryAdjustmentScreen({super.key});

  final String workerName = 'সোহেল মিয়া';
  final String monthText = 'অক্টোবর ২০২৬';

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<WorkerController>()) {
      Get.put(WorkerController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'মাসিক বেতন ঠিক করুন',
        subtitle: '$workerName • $monthText',
      ),
      body: GetBuilder<WorkerController>(
        builder: (controller) {
          final double baseSalary =
              double.tryParse(controller.monthlySalaryController.text.trim()) ?? 0;
          final double extraAmount =
              double.tryParse(controller.extraController.text.trim()) ?? 0;
          final double cutAmount =
              double.tryParse(controller.cutController.text.trim()) ?? 0;
          final double advanceAmount =
              double.tryParse(controller.advanceController.text.trim()) ?? 0;

          final double earnedThisMonth = baseSalary + extraAmount - cutAmount;
          final double nowDue = (earnedThisMonth - advanceAmount).clamp(0, 9999999);

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Worker Brief Card
                _buildWorkerBriefCard(controller),

                SizedBox(height: 14.h),

                // 2. Base Monthly Salary Field
                AppTextField(
                  label: 'এই মাসের বেতন',
                  controller: controller.monthlySalaryController,
                  icon: Icons.payments_outlined,
                  hint: '১৫,০০০',
                  suffixText: 'টাকা',
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 14.h),

                // 3. Side-by-Side Extra Amount & Cut Amount Fields
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'বাড়তি টাকা',
                        controller: controller.extraController,
                        hint: '১,০০০',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: AppTextField(
                        label: 'কাটার টাকা',
                        controller: controller.cutController,
                        hint: '৫০০',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // 4. Reason / Note Field
                AppTextField(
                  label: 'কারণ / নোট',
                  controller: controller.adjustNoteController,
                  hint: 'বাড়তি কাজ ও ছুটির সমন্বয়',
                ),

                SizedBox(height: 14.h),

                // 5. Calculated Salary Summary Card
                AppCard(
                  child: Column(
                    children: [
                      _buildSummaryRow(
                          'এই মাসে জমা হবে',
                          '৳${earnedThisMonth.toStringAsFixed(0)}',
                          AppColors.primary),
                      Divider(height: 16.h, color: AppColors.border),
                      _buildSummaryRow(
                          'আগে দেওয়া অগ্রিম',
                          '৳${advanceAmount.toStringAsFixed(0)}',
                          AppColors.textPrimary),
                      Divider(height: 16.h, color: AppColors.border),
                      _buildSummaryRow('এখন দিতে হবে',
                          '৳${nowDue.toStringAsFixed(0)}', Colors.red),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // 6. Info Notice Box
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
                          'একই মাসের হিসাব এডিট করলে আগের এন্ট্রি আপডেট হবে; আবার যোগ হবে না।',
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

                // 7. Bottom Action Save Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'বেতন হিসাব সংরক্ষিত',
                      'মাসের বেতন হিসাব সফলভাবে সেভ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'মাসের বেতন সেভ',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Worker Brief Card
  Widget _buildWorkerBriefCard(WorkerController controller) {
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.primaryLight,
            child: Icon(
              Icons.person_outline_rounded,
              size: 26.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  workerName,
                  style: AppTextStyles.custom(
                    size: 17.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'মাসিক কর্মী • বেতন ৳${controller.monthlySalaryController.text}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Summary Row Helper
  Widget _buildSummaryRow(String label, String value, Color valueColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.mediumGrey),
        Text(
          value,
          style: AppTextStyles.custom(
            size: 15.sp,
            color: valueColor,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
