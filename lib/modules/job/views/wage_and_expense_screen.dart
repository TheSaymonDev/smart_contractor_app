import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class WageAndExpenseScreen extends StatefulWidget {
  const WageAndExpenseScreen({super.key});

  @override
  State<WageAndExpenseScreen> createState() => _WageAndExpenseScreenState();
}

class _WageAndExpenseScreenState extends State<WageAndExpenseScreen> {
  int selectedTabIndex = 0;

  final List<String> tabLabels = ['কাজের মজুরি', 'বাড়তি বিল', 'অন্য খরচ'];

  // Form Controllers
  final TextEditingController wageController =
      TextEditingController(text: '26000');
  final TextEditingController wageNoteController =
      TextEditingController(text: 'ক্লায়েন্টের সাথে ঠিক করা মজুরি');

  final TextEditingController extraBillTitleController =
      TextEditingController();
  final TextEditingController extraBillAmountController =
      TextEditingController();

  final TextEditingController otherExpenseTitleController =
      TextEditingController();
  final TextEditingController otherExpenseAmountController =
      TextEditingController();

  DateTime selectedDate = DateTime(2026, 10, 22);

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is int && args >= 0 && args < tabLabels.length) {
      selectedTabIndex = args;
    }
  }

  @override
  void dispose() {
    wageController.dispose();
    wageNoteController.dispose();
    extraBillTitleController.dispose();
    extraBillAmountController.dispose();
    otherExpenseTitleController.dispose();
    otherExpenseAmountController.dispose();
    super.dispose();
  }

  // Date Picker
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
              'মজুরি ও খরচ',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'করিমের বাসা',
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
            // 1. Segmented Header Tabs
            _buildHeaderTabs(),

            SizedBox(height: 16.h),

            // 2. Dynamic Content View by Tab
            if (selectedTabIndex == 0) _buildWageTabContent(),
            if (selectedTabIndex == 1) _buildExtraBillTabContent(),
            if (selectedTabIndex == 2) _buildOtherExpenseTabContent(),

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
      ),
    );
  }

  // Segmented Header Tabs Control
  Widget _buildHeaderTabs() {
    return Container(
      height: 48.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: List.generate(tabLabels.length, (index) {
          final isSelected = selectedTabIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
                });
              },
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

  // ==========================================
  // TAB 0: কাজের মজুরি (Wage Tab)
  // ==========================================
  Widget _buildWageTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Total Wage Field
        AppTextField(
          label: 'ঠিক করা মোট মজুরি',
          controller: wageController,
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
          controller: wageNoteController,
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

  // ==========================================
  // TAB 1: বাড়তি বিল (Extra Bill Tab)
  // ==========================================
  Widget _buildExtraBillTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('বাড়তি কাজের বিবরণ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        TextFormField(
          controller: extraBillTitleController,
          style: AppTextStyles.mediumBlackBold,
          decoration: InputDecoration(
            hintText: 'যেমন: পুরোনো লাইন খুলে ফেলা',
            hintStyle: AppTextStyles.mediumGrey,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),

        SizedBox(height: 14.h),

        Text('বিল পরিমাণ (৳)', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        TextFormField(
          controller: extraBillAmountController,
          keyboardType: TextInputType.number,
          style: AppTextStyles.mediumBlackBold,
          decoration: InputDecoration(
            hintText: 'যেমন: ২০০০',
            hintStyle: AppTextStyles.mediumGrey,
            prefixIcon: Icon(
              Icons.payments_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            suffixText: 'টাকা',
            suffixStyle: AppTextStyles.mediumBlackBold,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),

        SizedBox(height: 14.h),

        Text('তারিখ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        _buildDateSelector(),

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

  // ==========================================
  // TAB 2: অন্য খরচ (Other Expense Tab)
  // ==========================================
  Widget _buildOtherExpenseTabContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('খরচের বিবরণ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        TextFormField(
          controller: otherExpenseTitleController,
          style: AppTextStyles.mediumBlackBold,
          decoration: InputDecoration(
            hintText: 'যেমন: যাতায়াত ও ছোটখাটো খরচ',
            hintStyle: AppTextStyles.mediumGrey,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),

        SizedBox(height: 14.h),

        Text('খরচের পরিমাণ (৳)', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        TextFormField(
          controller: otherExpenseAmountController,
          keyboardType: TextInputType.number,
          style: AppTextStyles.mediumBlackBold,
          decoration: InputDecoration(
            hintText: 'যেমন: ১৫০০',
            hintStyle: AppTextStyles.mediumGrey,
            prefixIcon: Icon(
              Icons.payments_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            suffixText: 'টাকা',
            suffixStyle: AppTextStyles.mediumBlackBold,
            filled: true,
            fillColor: Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: AppColors.primary, width: 1.5),
            ),
          ),
        ),

        SizedBox(height: 14.h),

        Text('তারিখ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 6.h),
        _buildDateSelector(),

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
                _formatDate(selectedDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
