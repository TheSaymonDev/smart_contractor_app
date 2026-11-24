import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/job/controllers/job_controller.dart';

class WageAndExpenseScreen extends StatelessWidget {
  const WageAndExpenseScreen({super.key});

  final List<String> tabLabels = const ['কাজের মজুরি', 'বাড়তি বিল', 'অন্য খরচ'];

  // Date Picker
  Future<void> _selectDate(BuildContext context, JobController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.expenseDate,
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
      controller.setExpenseDate(picked);
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
    final controller = Get.isRegistered<JobController>()
        ? Get.find<JobController>()
        : Get.put(JobController());

    final args = Get.arguments;
    if (args is int && args >= 0 && args < tabLabels.length) {
      controller.wageExpenseTabIndex = args;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'মজুরি ও খরচ',
        subtitle: 'করিমের বাসা',
      ),
      body: GetBuilder<JobController>(
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Segmented Header Tabs
                _buildHeaderTabs(controller),

                SizedBox(height: 16.h),

                // 2. Dynamic Content View by Tab
                if (controller.wageExpenseTabIndex == 0)
                  _buildWageTabContent(controller),
                if (controller.wageExpenseTabIndex == 1)
                  _buildExtraBillTabContent(context, controller),
                if (controller.wageExpenseTabIndex == 2)
                  _buildOtherExpenseTabContent(context, controller),

                SizedBox(height: 24.h),

                // 3. Bottom Save Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'সংরক্ষিত হয়েছে',
                      'মজুরি ও খরচের তথ্য সফলভাবে সেভ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'সেভ করুন',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Segmented Header Tabs Control
  Widget _buildHeaderTabs(JobController controller) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(tabLabels.length, (index) {
          final isSelected = controller.wageExpenseTabIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => controller.setWageExpenseTabIndex(index),
              borderRadius: BorderRadius.circular(9.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Text(
                  tabLabels[index],
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    weight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // TAB 0: কাজের মজুরি (Wage Tab)
  Widget _buildWageTabContent(JobController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Total Wage Field
        AppTextField(
          label: 'ঠিক করা মোট মজুরি',
          controller: controller.wageController,
          icon: Icons.payments_outlined,
          hint: 'পরিমাণ লিখুন',
          suffixText: 'টাকা',
          keyboardType: TextInputType.number,
        ),

        SizedBox(height: 14.h),

        // 2. Note Field
        AppTextField(
          labelWidget: RichText(
            text: TextSpan(
              text: 'নোট ',
              style: AppTextStyles.mediumBlackBold,
              children: [
                TextSpan(
                  text: '(ইচ্ছা হলে)',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          controller: controller.wageNoteController,
          hint: 'ক্লায়েন্টের সাথে ঠিক করা মজুরি',
        ),

        SizedBox(height: 14.h),

        // 3. Info Notice Box
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
                  'মজুরি ও বাড়তি বিল ক্লায়েন্টের বিলে যাবে। "অন্য খরচ" আপনার লাভের হিসাব থেকে বাদ যাবে।',
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

        // 4. Previously Recorded Extra Bills
        Text('আগে লেখা বাড়তি বিল', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 8.h),
        AppCard(
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.description_outlined,
                  color: AppColors.primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'পুরোনো লাইন খুলে ফেলা',
                      style: AppTextStyles.mediumBlackBold,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '২২ অক্টোবর ২০২৬',
                      style: AppTextStyles.smallGrey,
                    ),
                  ],
                ),
              ),
              Text(
                '৳২,০০০',
                style: AppTextStyles.custom(
                  size: 15.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 16.h),

        // 5. Previously Recorded Other Expenses
        Text('আগে লেখা অন্য খরচ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 8.h),
        AppCard(
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.payments_outlined,
                  color: AppColors.primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'যাতায়াত ও ছোটখাটো খরচ',
                      style: AppTextStyles.mediumBlackBold,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      '২২ অক্টোবর ২০২৬',
                      style: AppTextStyles.smallGrey,
                    ),
                  ],
                ),
              ),
              Text(
                '৳১,৫০০',
                style: AppTextStyles.custom(
                  size: 15.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TAB 1: বাড়তি বিল (Extra Bill Tab)
  Widget _buildExtraBillTabContent(
      BuildContext context, JobController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'বাড়তি কাজের বিবরণ',
          controller: controller.extraBillTitleController,
          hint: 'যেমন: পুরোনো লাইন খুলে ফেলা',
        ),

        SizedBox(height: 14.h),

        AppTextField(
          label: 'বিল পরিমাণ (৳)',
          controller: controller.extraBillAmountController,
          icon: Icons.payments_outlined,
          hint: 'যেমন: ২০০০',
          suffixText: 'টাকা',
          keyboardType: TextInputType.number,
        ),

        SizedBox(height: 14.h),

        Text('তারিখ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        _buildDateSelector(context, controller),

        SizedBox(height: 14.h),

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
                  'বাড়তি বিল ক্লায়েন্টের মোট বিলে যুক্ত হবে।',
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // TAB 2: অন্য খরচ (Other Expense Tab)
  Widget _buildOtherExpenseTabContent(
      BuildContext context, JobController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppTextField(
          label: 'খরচের বিবরণ',
          controller: controller.otherExpenseTitleController,
          hint: 'যেমন: যাতায়াত ও ছোটখাটো খরচ',
        ),

        SizedBox(height: 14.h),

        AppTextField(
          label: 'খরচের পরিমাণ (৳)',
          controller: controller.otherExpenseAmountController,
          icon: Icons.payments_outlined,
          hint: 'যেমন: ১৫০০',
          suffixText: 'টাকা',
          keyboardType: TextInputType.number,
        ),

        SizedBox(height: 14.h),

        Text('তারিখ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        _buildDateSelector(context, controller),

        SizedBox(height: 14.h),

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
                  'অন্য খরচ আপনার প্রজেক্টের নিট লাভ থেকে বাদ যাবে।',
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Date Selector Box
  Widget _buildDateSelector(BuildContext context, JobController controller) {
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
                _formatDate(controller.expenseDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
