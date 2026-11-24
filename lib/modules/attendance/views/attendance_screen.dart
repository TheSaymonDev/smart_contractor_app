import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_tab_header.dart';
import 'package:smart_contractor_app/modules/attendance/controllers/attendance_controller.dart';
import 'package:smart_contractor_app/modules/attendance/models/attendance_model.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  // Date Formatting Helper
  String _formatDate(DateTime date) {
    const months = [
      'জানুয়ারি',
      'ফেব্রুয়ারি',
      'মার্চ',
      'এপ্রিল',
      'মে',
      'জুন',
      'জুলাই',
      'আগস্ট',
      'সেপ্টেম্বর',
      'অক্টোবর',
      'নভেম্বর',
      'ডিসেম্বর'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // Date Picker
  Future<void> _selectDate(
      BuildContext context, AttendanceController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      controller.setSelectedDate(picked);
    }
  }

  // Change Job for Specific Worker
  void _showJobSelectionBottomSheet(
      BuildContext context, AttendanceController controller, int index) {
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
                    child:
                        const Icon(Icons.work_outline, color: AppColors.primary),
                  ),
                  title: Text(job, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    controller.updateWorkerJob(index, job);
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
    Get.put(AttendanceController());

    return SafeArea(
      bottom: false,
      child: GetBuilder<AttendanceController>(
        builder: (controller) {
          final int presentCount = controller.presentCount;
          final int absentCount = controller.absentCount;

          return Padding(
            padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Bar
                const AppTabHeader(
                  title: 'হাজিরা',
                  subtitle: 'তারিখ বেছে হাজিরা দিন',
                  icon: Icons.apartment,
                ),

                SizedBox(height: 12.h),

                // Date Field
                Text('তারিখ', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildDateSelectorBox(context, controller),

                SizedBox(height: 12.h),

                // Summary Board (2 Cards)
                _buildSummaryBoard(presentCount, absentCount),

                SizedBox(height: 12.h),

                // Worker Attendance Cards List
                Expanded(
                  child: Stack(
                    children: [
                      ListView(
                        padding: EdgeInsets.only(bottom: 80.h),
                        children: [
                          ...List.generate(controller.attendanceList.length,
                              (index) {
                            final item = controller.attendanceList[index];
                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: _buildWorkerAttendanceCard(
                                  context, controller, item, index),
                            );
                          }),

                          SizedBox(height: 4.h),

                          // Info Notice Box
                          _buildInfoNoticeBox(),
                        ],
                      ),

                      // Bottom Action Button
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 8.h,
                        child: AppPrimaryButton(
                          onPressed: () {
                            Get.snackbar(
                              'হাজিরা সংরক্ষিত',
                              '${_formatDate(controller.selectedDate)} তারিখের হাজিরা সফলভাবে সেভ করা হয়েছে',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.primary,
                              colorText: Colors.white,
                            );
                          },
                          text: 'হাজিরা সেভ করুন',
                          icon: Icons.check_rounded,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Date Selector Box
  Widget _buildDateSelectorBox(
      BuildContext context, AttendanceController controller) {
    return InkWell(
      onTap: () => _selectDate(context, controller),
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
              Icons.calendar_month_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                _formatDate(controller.selectedDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Summary Board (2 Cards)
  Widget _buildSummaryBoard(int presentCount, int absentCount) {
    return Row(
      children: [
        // Present Card
        Expanded(
          child: AppCard(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F8F0),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.groups_outlined,
                        color: const Color(0xFF079455),
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'হাজির',
                      style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '$presentCount জন',
                  style: AppTextStyles.custom(
                    size: 20.sp,
                    color: const Color(0xFF079455),
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 8.w),

        // Absent Card
        Expanded(
          child: AppCard(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFF4E5),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.groups_outlined,
                        color: const Color(0xFFE66A00),
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Text(
                      'আসেননি',
                      style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '$absentCount জন',
                  style: AppTextStyles.custom(
                    size: 20.sp,
                    color: const Color(0xFFE66A00),
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Individual Worker Attendance Card
  Widget _buildWorkerAttendanceCard(BuildContext context,
      AttendanceController controller, AttendanceModel item, int index) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Worker Name & Pencil Edit Icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(item.workerName, style: AppTextStyles.mediumBlackBold),
              InkWell(
                onTap: () {
                  Get.snackbar(
                    'রেট পরিবর্তন',
                    '${item.workerName} এর আজকের হাজিরা রেট পরিবর্তন করুন',
                    snackPosition: SnackPosition.BOTTOM,
                  );
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          Text(
            'দৈনিক ৳${item.dailyRate.toStringAsFixed(0)}',
            style: AppTextStyles.smallGrey,
          ),

          SizedBox(height: 10.h),

          // Attendance Status Segmented Toggle
          Container(
            height: 44.h,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF3F8),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                _buildStatusToggleOption(
                  label: 'পূর্ণ দিন',
                  isSelected: item.status == AttendanceStatus.fullDay,
                  onTap: () => controller.updateWorkerStatus(
                      index, AttendanceStatus.fullDay),
                ),
                _buildStatusToggleOption(
                  label: 'অর্ধেক দিন',
                  isSelected: item.status == AttendanceStatus.halfDay,
                  onTap: () => controller.updateWorkerStatus(
                      index, AttendanceStatus.halfDay),
                ),
                _buildStatusToggleOption(
                  label: 'আসেননি',
                  isSelected: item.status == AttendanceStatus.absent,
                  onTap: () => controller.updateWorkerStatus(
                      index, AttendanceStatus.absent),
                ),
              ],
            ),
          ),

          SizedBox(height: 10.h),

          // Assigned Job & Amount Box
          InkWell(
            onTap: () =>
                _showJobSelectionBottomSheet(context, controller, index),
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF3F8),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.work_outline_rounded,
                        color: AppColors.textSecondary,
                        size: 18.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        item.jobName,
                        style: AppTextStyles.mediumBlackBold,
                      ),
                    ],
                  ),
                  Text(
                    '৳${item.amount.toStringAsFixed(0)}',
                    style: AppTextStyles.custom(
                      size: 15.sp,
                      color: AppColors.textPrimary,
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Sub-action Link: আরেক কাজে ভাগ করুন
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.splitWageScreen, arguments: item);
            },
            child: Text(
              'আরেক কাজে ভাগ করুন',
              style: AppTextStyles.custom(
                size: 12.sp,
                color: AppColors.primary,
                weight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusToggleOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Text(
            label,
            style: AppTextStyles.custom(
              size: 12.sp,
              color: isSelected ? Colors.white : AppColors.textSecondary,
              weight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  // Info Notice Box
  Widget _buildInfoNoticeBox() {
    return Container(
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
              'দিনের টাকা বদলাতে কলমে চাপুন। পুরোনো তারিখও বাছতে পারবেন।',
              style: AppTextStyles.custom(
                size: 12.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
