import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/attendance/controllers/attendance_controller.dart';
import 'package:smart_contractor_app/modules/attendance/models/attendance_model.dart';

class SplitWageScreen extends StatelessWidget {
  const SplitWageScreen({super.key});

  void _showJobSelectionBottomSheet(
      BuildContext context, AttendanceController controller, bool isJob1) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('কাজ নির্বাচন করুন', style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              ...controller.availableJobs.map((job) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.work_outline,
                        color: AppColors.primary),
                  ),
                  title: Text(job, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    if (isJob1) {
                      controller.setJob1(job);
                    } else {
                      controller.setJob2(job);
                    }
                    Get.back();
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AttendanceController());

    final args = Get.arguments;
    if (args is AttendanceModel) {
      controller.workerName = args.workerName;
      controller.totalWageController.text = args.dailyRate.toStringAsFixed(0);
      controller.selectedJob1 = args.jobName;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'দুই কাজে মজুরি ভাগ',
        subtitle: '${controller.workerName} • ${controller.dateText}',
      ),
      body: GetBuilder<AttendanceController>(
        builder: (controller) {
          final double job1Val =
              double.tryParse(controller.job1AmountController.text.trim()) ?? 0;
          final double job2Val =
              double.tryParse(controller.job2AmountController.text.trim()) ?? 0;
          final double splitTotal = job1Val + job2Val;

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Worker Brief Card
                _buildWorkerBriefCard(controller),

                SizedBox(height: 14.h),

                // 2. Today's Total Wage Field
                AppTextField(
                  label: 'আজকের মোট মজুরি',
                  controller: controller.totalWageController,
                  icon: Icons.payments_outlined,
                  hint: '৮০০',
                  suffixText: 'টাকা',
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 14.h),

                // 3. Job 1 Card
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('১ম কাজ', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      _buildJobDropdown(controller.selectedJob1,
                          () => _showJobSelectionBottomSheet(context, controller, true)),
                      SizedBox(height: 10.h),
                      Text('এই কাজের মজুরি', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      AppTextField(
                        controller: controller.job1AmountController,
                        hint: '৫০০',
                        suffixText: 'টাকা',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 12.h),

                // 4. Job 2 Card
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('২য় কাজ', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      _buildJobDropdown(controller.selectedJob2,
                          () => _showJobSelectionBottomSheet(context, controller, false)),
                      SizedBox(height: 10.h),
                      Text('এই কাজের মজুরি', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      AppTextField(
                        controller: controller.job2AmountController,
                        hint: '৩০০',
                        suffixText: 'টাকা',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // 5. Calculated Split Total Card
                AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'দুই কাজে মোট',
                        style: AppTextStyles.mediumGrey,
                      ),
                      Text(
                        '৳${splitTotal.toStringAsFixed(0)}',
                        style: AppTextStyles.custom(
                          size: 16.sp,
                          color: const Color(0xFF079455),
                          weight: FontWeight.w700,
                        ),
                      ),
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
                          'দুই কাজে ভাগ করা টাকা আজকের মোট মজুরির সমান হতে হবে।',
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

                // 7. Bottom Save Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'হিসাব সংরক্ষিত',
                      'দুই কাজে মজুরি ভাগ করার হিসাব সফলভাবে সেভ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'ভাগ করা হিসাব সেভ',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Worker Brief Card Helper
  Widget _buildWorkerBriefCard(AttendanceController controller) {
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
                  controller.workerName,
                  style: AppTextStyles.custom(
                    size: 17.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'পূর্ণ দিন • আজকের মোট মজুরি ৳${controller.totalWageController.text}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Job Dropdown Helper
  Widget _buildJobDropdown(String selectedJob, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        height: 52.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: AppColors.border, width: 1.5),
        ),
        child: Row(
          children: [
            Icon(
              Icons.keyboard_arrow_down_rounded,
              color: AppColors.textSecondary,
              size: 22.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                selectedJob,
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
