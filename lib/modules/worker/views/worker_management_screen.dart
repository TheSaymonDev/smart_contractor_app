import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/worker/controllers/worker_controller.dart';

class WorkerManagementScreen extends StatelessWidget {
  const WorkerManagementScreen({super.key});

  Future<void> _selectDate(
      BuildContext context, WorkerController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.startDate,
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
      controller.setStartDate(picked);
    }
  }

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

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<WorkerController>()
        ? Get.find<WorkerController>()
        : Get.put(WorkerController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'নতুন কর্মী',
        subtitle: controller.isDailyWage ? 'দৈনিক মজুরি' : 'মাসিক মজুরি',
      ),
      body: GetBuilder<WorkerController>(
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Worker Name
                AppTextField(
                  label: 'কর্মীর নাম',
                  controller: controller.nameController,
                  icon: Icons.person_outline_rounded,
                  hint: 'রহিম মিয়া',
                ),

                SizedBox(height: 12.h),

                // 2. Mobile Number (Optional)
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'মোবাইল নম্বর ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  controller: controller.phoneController,
                  icon: Icons.phone_outlined,
                  hint: '01XXXXXXXXX',
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 14.h),

                // 3. Wage Type Toggle (দৈনিক / মাসিক)
                Text('মজুরির ধরন', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildWageTypeToggle(controller),

                SizedBox(height: 14.h),

                // 4. Dynamic Wage Fields (Daily vs Monthly)
                if (controller.isDailyWage) ...[
                  // Full Day & Half Day Wages Row
                  Row(
                    children: [
                      Expanded(
                        child: AppTextField(
                          label: 'পূর্ণ দিনের মজুরি',
                          controller: controller.fullDayWageController,
                          hint: '৮০০',
                          suffixText: 'টাকা',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: AppTextField(
                          label: 'অর্ধেক দিনের মজুরি',
                          controller: controller.halfDayWageController,
                          hint: '৪০০',
                          suffixText: 'টাকা',
                          keyboardType: TextInputType.number,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 12.h),

                  // Role / Profession (Optional)
                  AppTextField(
                    labelWidget: RichText(
                      text: TextSpan(
                        text: 'পেশা ',
                        style: AppTextStyles.mediumBlackBold,
                        children: [
                          TextSpan(
                            text: '(ইচ্ছা হলে)',
                            style: AppTextStyles.smallGrey,
                          ),
                        ],
                      ),
                    ),
                    controller: controller.roleController,
                    hint: 'পাইপ মিস্ত্রি',
                  ),
                ] else ...[
                  // Monthly Salary Field
                  AppTextField(
                    label: 'মাসিক বেতন',
                    controller: controller.monthlySalaryController,
                    icon: Icons.payments_outlined,
                    hint: '১৫,০০০',
                    suffixText: 'টাকা',
                    keyboardType: TextInputType.number,
                  ),

                  SizedBox(height: 12.h),

                  // Start Date Field (Optional)
                  RichText(
                    text: TextSpan(
                      text: 'কাজ শুরুর তারিখ ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 6.h),
                  _buildDateSelector(context, controller),
                ],

                SizedBox(height: 14.h),

                // 5. Previous Balance Field (Optional)
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'আগের হিসাব ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  controller: controller.previousBalanceController,
                  icon: Icons.payments_outlined,
                  hint: '২,০০০',
                  suffixText: 'টাকা',
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 8.h),

                // Balance Type Toggle (কর্মীকে দিতে হবে / আগে অগ্রিম দেওয়া)
                _buildBalanceTypeToggle(controller),

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
                          controller.isDailyWage
                              ? 'অর্ধেক দিনের টাকা প্রয়োজনে বদলাতে পারবেন।'
                              : 'অনুপস্থিতির জন্য নিজে থেকে বেতন কাটবে না। মাস শেষে আপনি হিসাব ঠিক করবেন।',
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
                      'কর্মী সংরক্ষিত',
                      'নতুন কর্মী সফলভাবে সেভ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'কর্মী সেভ করুন',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Wage Type Toggle (দৈনিক / মাসিক)
  Widget _buildWageTypeToggle(WorkerController controller) {
    return Container(
      height: 46.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          // Option 1: দৈনিক
          Expanded(
            child: InkWell(
              onTap: () {
                controller.setDailyWage(true);
                if (controller.nameController.text == 'সোহেল মিয়া') {
                  controller.nameController.text = 'রহিম মিয়া';
                }
              },
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.isDailyWage
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'দৈনিক',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: controller.isDailyWage
                        ? Colors.white
                        : AppColors.textSecondary,
                    weight:
                        controller.isDailyWage ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Option 2: মাসিক
          Expanded(
            child: InkWell(
              onTap: () {
                controller.setDailyWage(false);
                if (controller.nameController.text == 'রহিম মিয়া') {
                  controller.nameController.text = 'সোহেল মিয়া';
                }
              },
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !controller.isDailyWage
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'মাসিক',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: !controller.isDailyWage
                        ? Colors.white
                        : AppColors.textSecondary,
                    weight:
                        !controller.isDailyWage ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Balance Type Toggle (কর্মীকে দিতে হবে / আগে অগ্রিম দেওয়া)
  Widget _buildBalanceTypeToggle(WorkerController controller) {
    return Container(
      height: 44.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          // Option 1: কর্মীকে দিতে হবে
          Expanded(
            child: InkWell(
              onTap: () => controller.setDueToWorker(true),
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.isDueToWorker
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'কর্মীকে দিতে হবে',
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: controller.isDueToWorker
                        ? Colors.white
                        : AppColors.textSecondary,
                    weight:
                        controller.isDueToWorker ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Option 2: আগে অগ্রিম দেওয়া
          Expanded(
            child: InkWell(
              onTap: () => controller.setDueToWorker(false),
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !controller.isDueToWorker
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'আগে অগ্রিম দেওয়া',
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: !controller.isDueToWorker
                        ? Colors.white
                        : AppColors.textSecondary,
                    weight:
                        !controller.isDueToWorker ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Date Selector Box
  Widget _buildDateSelector(
      BuildContext context, WorkerController controller) {
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
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                _formatDate(controller.startDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
