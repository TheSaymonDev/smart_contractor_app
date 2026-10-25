import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime selectedDate = DateTime(2026, 10, 1);

  double totalBillAmount = 84000;
  double workerWagesAmount = 23000;
  double otherExpensesAmount = 7000;

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
    final double estimatedProfit =
        totalBillAmount - workerWagesAmount - otherExpensesAmount;

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
              'রিপোর্ট',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'মাসের কাজ ও হিসাব',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Month Field
            Text('মাস', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildMonthSelectorBox(),

            SizedBox(height: 14.h),

            // 2. Summary 2x2 Grid (4 Cards)
            _buildSummaryGrid(),

            SizedBox(height: 16.h),

            // 3. Section Title: "এই মাসের কাজের হিসাব"
            Text(
              'এই মাসের কাজের হিসাব',
              style: AppTextStyles.custom(
                size: 16.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),

            SizedBox(height: 10.h),

            // 4. Monthly Calculation Card
            AppCard(
              child: Column(
                children: [
                  _buildStatementRow('মোট বিল',
                      '৳${totalBillAmount.toStringAsFixed(0)}', AppColors.textPrimary),
                  Divider(height: 16.h, color: AppColors.border),
                  _buildStatementRow('কর্মীর মজুরি',
                      '৳${workerWagesAmount.toStringAsFixed(0)}', AppColors.textPrimary),
                  Divider(height: 16.h, color: AppColors.border),
                  _buildStatementRow('অন্য খরচ',
                      '৳${otherExpensesAmount.toStringAsFixed(0)}', AppColors.textPrimary),
                  Divider(height: 16.h, color: AppColors.border),
                  _buildStatementRow('আনুমানিক লাভ',
                      '৳${estimatedProfit.toStringAsFixed(0)}', const Color(0xFF079455)),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // 5. Info Notice Box
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
                      'লাভ মোট বিলের হিসাবে। হাতে পাওয়া টাকার সাথে এক নাও হতে পারে।',
                      style: AppTextStyles.custom(
                        size: 12.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // 6. Client Due Link Card ("কার কাছে কত পাওনা")
            AppCard(
              onTap: () {
                Get.toNamed(AppRoutes.clientsScreen);
              },
              child: Row(
                children: [
                  Container(
                    width: 42.w,
                    height: 42.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Icon(
                      Icons.groups_outlined,
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
                          'কার কাছে কত পাওনা',
                          style: AppTextStyles.custom(
                            size: 16.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'ক্লায়েন্ট অনুযায়ী দেখুন',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.textSecondary,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Month Selector Box Helper
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

  // Summary Grid (4 Cards) Helper
  Widget _buildSummaryGrid() {
    return Column(
      children: [
        // Row 1: Total Jobs & Total Bill
        Row(
          children: [
            Expanded(
              child: AppCard(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.work_outline_rounded,
                            color: AppColors.primary,
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'মোট কাজ',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '১২টি',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: AppCard(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: AppColors.primaryLight,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.description_outlined,
                            color: AppColors.primary,
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'মোট বিল',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳৮৪,০০০',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 8.h),

        // Row 2: Received Amount & Due Amount
        Row(
          children: [
            Expanded(
              child: AppCard(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
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
                            Icons.payments_outlined,
                            color: const Color(0xFF079455),
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'পাওয়া টাকা',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳৭৪,০০০',
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
            Expanded(
              child: AppCard(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 28.w,
                          height: 28.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFEBEB),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.payments_outlined,
                            color: Colors.red,
                            size: 16.sp,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Expanded(
                          child: Text(
                            'এই কাজগুলোর বাকি',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.smallGrey
                                .copyWith(fontSize: 11.sp),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Text(
                      '৳১০,০০০',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: Colors.red,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Statement Row Helper
  Widget _buildStatementRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.mediumGrey),
        Text(
          value,
          style: AppTextStyles.custom(
            size: 15.sp,
            color: color,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
