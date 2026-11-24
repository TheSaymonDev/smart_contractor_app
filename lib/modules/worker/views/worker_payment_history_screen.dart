import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/worker/controllers/worker_controller.dart';

class PaymentHistoryRecord {
  final String id;
  final String name;
  final String dateText;
  final String purpose; // মজুরি, বেতন, অগ্রিম
  final String method; // ক্যাশ, bKash, Nagad
  final double amount;

  const PaymentHistoryRecord({
    required this.id,
    required this.name,
    required this.dateText,
    required this.purpose,
    required this.method,
    required this.amount,
  });
}

class WorkerPaymentHistoryScreen extends StatelessWidget {
  const WorkerPaymentHistoryScreen({super.key});

  final List<PaymentHistoryRecord> historyRecords = const [
    PaymentHistoryRecord(
      id: '1',
      name: 'রহিম মিয়া',
      dateText: '২২ অক্টোবর',
      purpose: 'মজুরি',
      method: 'ক্যাশ',
      amount: 1000,
    ),
    PaymentHistoryRecord(
      id: '2',
      name: 'করিম মিয়া',
      dateText: '২১ অক্টোবর',
      purpose: 'মজুরি',
      method: 'bKash',
      amount: 1200,
    ),
    PaymentHistoryRecord(
      id: '3',
      name: 'সোহেল মিয়া',
      dateText: '২০ অক্টোবর',
      purpose: 'অগ্রিম',
      method: 'ক্যাশ',
      amount: 2000,
    ),
  ];

  // Date/Month Picker
  Future<void> _selectDate(
      BuildContext context, WorkerController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.historySelectedDate,
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
      controller.setHistorySelectedDate(picked);
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
    return 'এই মাস • ${months[date.month - 1]} ${date.year}';
  }

  List<PaymentHistoryRecord> _getFilteredRecords(WorkerController controller) {
    if (controller.historyFilterIndex == 0) return historyRecords;

    final String selectedPurpose =
        controller.historyFilterLabels[controller.historyFilterIndex];
    return historyRecords.where((r) => r.purpose == selectedPurpose).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'কর্মীদের পেমেন্ট',
        subtitle: 'কবে কাকে কত দিয়েছেন',
      ),
      body: GetBuilder<WorkerController>(
        builder: (controller) {
          final records = _getFilteredRecords(controller);

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Month Selector Box
                Text('সময়', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildMonthSelectorBox(context, controller),

                SizedBox(height: 12.h),

                // 2. Filter Tabs Bar
                _buildFilterTabs(controller),

                SizedBox(height: 12.h),

                // 3. Summary Board Cards (2 Cards)
                _buildSummaryBoard(),

                SizedBox(height: 12.h),

                // 4. Payment History Cards List
                ...records.map((rec) => Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: _buildHistoryCard(rec),
                    )),

                SizedBox(height: 4.h),

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
                          'কোনো পেমেন্ট খুলে বিস্তারিত ও সংশোধনের অপশন পাবেন।',
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

                // 6. Bottom Action Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.bulkWorkerPaymentScreen);
                  },
                  text: 'একসাথে টাকা দিন',
                  icon: Icons.groups_outlined,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Month Selector Box
  Widget _buildMonthSelectorBox(
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
                _formatMonth(controller.historySelectedDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Filter Tabs Bar
  Widget _buildFilterTabs(WorkerController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(controller.historyFilterLabels.length, (index) {
          final isSelected = controller.historyFilterIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => controller.setHistoryFilterIndex(index),
              borderRadius: BorderRadius.circular(9.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 38.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Text(
                  controller.historyFilterLabels[index],
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    weight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // Summary Board (2 Cards)
  Widget _buildSummaryBoard() {
    return Row(
      children: [
        // Total Paid Card
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
                        Icons.payments_outlined,
                        color: const Color(0xFF079455),
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'মোট দেওয়া',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '৳২৩,১০০',
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

        // Total Advance Card
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
                        Icons.payments_outlined,
                        color: const Color(0xFFE66A00),
                        size: 16.sp,
                      ),
                    ),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'অগ্রিম দেওয়া',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Text(
                  '৳২,০০০',
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

  // Payment History Card Helper
  Widget _buildHistoryCard(PaymentHistoryRecord rec) {
    return AppCard(
      onTap: () {
        Get.snackbar(
          'পেমেন্ট বিবরণ',
          '${rec.name} এর ৳${rec.amount.toStringAsFixed(0)} প্রদানের বিবরণ',
          snackPosition: SnackPosition.BOTTOM,
        );
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
                  rec.name,
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${rec.dateText} • ${rec.purpose} • ${rec.method}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          Text(
            '৳${rec.amount.toStringAsFixed(0)}',
            style: AppTextStyles.custom(
              size: 16.sp,
              color: AppColors.textPrimary,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
