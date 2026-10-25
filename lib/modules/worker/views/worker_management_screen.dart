import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class WorkerManagementScreen extends StatefulWidget {
  const WorkerManagementScreen({super.key});

  @override
  State<WorkerManagementScreen> createState() =>
      _WorkerManagementScreenState();
}

class _WorkerManagementScreenState extends State<WorkerManagementScreen> {
  // Common Form Controllers
  final TextEditingController nameController =
      TextEditingController(text: 'রহিম মিয়া');
  final TextEditingController phoneController =
      TextEditingController(text: '01912-345678');
  final TextEditingController previousBalanceController =
      TextEditingController(text: '২,০০০');

  // Daily Wage Specific Controllers
  final TextEditingController fullDayWageController =
      TextEditingController(text: '৮০০');
  final TextEditingController halfDayWageController =
      TextEditingController(text: '৪০০');
  final TextEditingController roleController =
      TextEditingController(text: 'পাইপ মিস্ত্রি');

  // Monthly Wage Specific Controllers
  final TextEditingController monthlySalaryController =
      TextEditingController(text: '১৫,০০০');

  // State Variables
  bool isDailyWage = true; // true = দৈনিক, false = মাসিক
  bool isDueToWorker = true; // true = কর্মীকে দিতে হবে, false = আগে অগ্রিম দেওয়া
  DateTime startDate = DateTime(2026, 10, 1);

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    previousBalanceController.dispose();
    fullDayWageController.dispose();
    halfDayWageController.dispose();
    roleController.dispose();
    monthlySalaryController.dispose();
    super.dispose();
  }

  // Date Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate,
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
      setState(() {
        startDate = picked;
      });
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
              'নতুন কর্মী',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              isDailyWage ? 'দৈনিক মজুরি' : 'মাসিক মজুরি',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Worker Name
            AppTextField(
              label: 'কর্মীর নাম',
              controller: nameController,
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
              controller: phoneController,
              icon: Icons.phone_outlined,
              hint: '01XXXXXXXXX',
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: 14.h),

            // 3. Wage Type Toggle (দৈনিক / মাসিক)
            Text('মজুরির ধরন', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildWageTypeToggle(),

            SizedBox(height: 14.h),

            // 4. Dynamic Wage Fields (Daily vs Monthly)
            if (isDailyWage) ...[
              // Full Day & Half Day Wages Row
              Row(
                children: [
                  Expanded(
                    child: AppTextField(
                      label: 'পূর্ণ দিনের মজুরি',
                      controller: fullDayWageController,
                      hint: '৮০০',
                      suffixText: 'টাকা',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: AppTextField(
                      label: 'অর্ধেক দিনের মজুরি',
                      controller: halfDayWageController,
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
                controller: roleController,
                hint: 'পাইপ মিস্ত্রি',
              ),
            ] else ...[
              // Monthly Salary Field
              AppTextField(
                label: 'মাসিক বেতন',
                controller: monthlySalaryController,
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
              _buildDateSelector(),
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
              controller: previousBalanceController,
              icon: Icons.payments_outlined,
              hint: '২,০০০',
              suffixText: 'টাকা',
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 8.h),

            // Balance Type Toggle (কর্মীকে দিতে হবে / আগে অগ্রিম দেওয়া)
            _buildBalanceTypeToggle(),

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
                      isDailyWage
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
      ),
    );
  }

  // Wage Type Toggle (দৈনিক / মাসিক)
  Widget _buildWageTypeToggle() {
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
                setState(() {
                  isDailyWage = true;
                  if (nameController.text == 'সোহেল মিয়া') {
                    nameController.text = 'রহিম মিয়া';
                  }
                });
              },
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDailyWage ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'দৈনিক',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: isDailyWage ? Colors.white : AppColors.textSecondary,
                    weight: isDailyWage ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Option 2: মাসিক
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  isDailyWage = false;
                  if (nameController.text == 'রহিম মিয়া') {
                    nameController.text = 'সোহেল মিয়া';
                  }
                });
              },
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isDailyWage ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'মাসিক',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: !isDailyWage ? Colors.white : AppColors.textSecondary,
                    weight: !isDailyWage ? FontWeight.w700 : FontWeight.w500,
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
  Widget _buildBalanceTypeToggle() {
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
              onTap: () {
                setState(() {
                  isDueToWorker = true;
                });
              },
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isDueToWorker ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'কর্মীকে দিতে হবে',
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: isDueToWorker ? Colors.white : AppColors.textSecondary,
                    weight: isDueToWorker ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Option 2: আগে অগ্রিম দেওয়া
          Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  isDueToWorker = false;
                });
              },
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !isDueToWorker ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'আগে অগ্রিম দেওয়া',
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: !isDueToWorker ? Colors.white : AppColors.textSecondary,
                    weight: !isDueToWorker ? FontWeight.w700 : FontWeight.w500,
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
  Widget _buildDateSelector() {
    return InkWell(
      onTap: () => _selectDate(context),
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
                _formatDate(startDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
