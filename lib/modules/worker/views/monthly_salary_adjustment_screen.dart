import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';

class MonthlySalaryAdjustmentScreen extends StatefulWidget {
  const MonthlySalaryAdjustmentScreen({super.key});

  @override
  State<MonthlySalaryAdjustmentScreen> createState() =>
      _MonthlySalaryAdjustmentScreenState();
}

class _MonthlySalaryAdjustmentScreenState
    extends State<MonthlySalaryAdjustmentScreen> {
  final TextEditingController baseSalaryController =
      TextEditingController(text: '15000');
  final TextEditingController extraAmountController =
      TextEditingController(text: '1000');
  final TextEditingController cutAmountController =
      TextEditingController(text: '500');
  final TextEditingController noteController =
      TextEditingController(text: 'বাড়তি কাজ ও ছুটির সমন্বয়');

  String workerName = 'সোহেল মিয়া';
  String monthText = 'অক্টোবর ২০২৬';
  double advanceAmount = 2000;

  DateTime selectedDate = DateTime(2026, 10, 1);

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('name')) {
      workerName = args['name'].toString();
    }

    baseSalaryController.addListener(() => setState(() {}));
    extraAmountController.addListener(() => setState(() {}));
    cutAmountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    baseSalaryController.dispose();
    extraAmountController.dispose();
    cutAmountController.dispose();
    noteController.dispose();
    super.dispose();
  }

  // Date/Month Picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
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
        selectedDate = picked;
      });
    }
  }

  String _formatMonth(DateTime date) {
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
    return '${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    final double baseSalary =
        double.tryParse(baseSalaryController.text.trim()) ?? 0;
    final double extraAmount =
        double.tryParse(extraAmountController.text.trim()) ?? 0;
    final double cutAmount =
        double.tryParse(cutAmountController.text.trim()) ?? 0;

    final double earnedThisMonth = baseSalary + extraAmount - cutAmount;
    final double nowDue = (earnedThisMonth - advanceAmount).clamp(0, 9999999);

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
              'মাসিক বেতন ঠিক করুন',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '$workerName • $monthText',
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
            // 1. Worker Brief Card
            _buildWorkerBriefCard(),

            SizedBox(height: 14.h),

            // 2. Month Selector Box
            Text('মাস', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildMonthSelectorBox(),

            SizedBox(height: 14.h),

            // 3. Base Monthly Salary Field
            Text('এই মাসের বেতন', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildInputField(
              controller: baseSalaryController,
              hint: '১৫,০০০',
              suffixText: 'টাকা',
              icon: Icons.payments_outlined,
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 14.h),

            // 4. Side-by-Side Extra Amount & Cut Amount Fields
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('বাড়তি টাকা', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      _buildSimpleInput(
                        controller: extraAmountController,
                        hint: '১,০০০',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('কাটার টাকা', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      _buildSimpleInput(
                        controller: cutAmountController,
                        hint: '৫০০',
                        keyboardType: TextInputType.number,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // 5. Reason / Note Field
            Text('কারণ / নোট', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildSimpleInput(
              controller: noteController,
              hint: 'বাড়তি কাজ ও ছুটির সমন্বয়',
            ),

            SizedBox(height: 14.h),

            // 6. Calculated Salary Summary Card
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

            // 7. Info Notice Box
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

            // 8. Bottom Action Save Button
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
      ),
    );
  }

  // Worker Brief Card
  Widget _buildWorkerBriefCard() {
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
                  'মাসিক কর্মী • বেতন ৳${baseSalaryController.text}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Month Selector Box
  Widget _buildMonthSelectorBox() {
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
                _formatMonth(selectedDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Input Field Helper
  Widget _buildInputField({
    required TextEditingController controller,
    IconData? icon,
    required String hint,
    String? suffixText,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppTextStyles.mediumBlackBold,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.mediumGrey,
        prefixIcon: icon != null
            ? Icon(
                icon,
                color: AppColors.textSecondary,
                size: 20.sp,
              )
            : null,
        suffixText: suffixText,
        suffixStyle: AppTextStyles.mediumBlackBold,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }

  // Simple Input Field Helper
  Widget _buildSimpleInput({
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      style: AppTextStyles.mediumBlackBold,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.mediumGrey,
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border, width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
        ),
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
