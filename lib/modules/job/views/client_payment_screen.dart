import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/job/controllers/job_controller.dart';

class ClientPaymentScreen extends StatelessWidget {
  const ClientPaymentScreen({super.key});

  final double totalDue = 10000;

  final List<String> paymentMethods = const [
    'ক্যাশ / Cash',
    'বিকাশ / bKash',
    'নগদ / Nagad',
    'ব্যাংক ট্রান্সফার / Bank Transfer',
    'চেক / Cheque',
  ];

  // Date Picker
  Future<void> _selectDate(BuildContext context, JobController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.paymentDate,
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
      controller.setPaymentDate(picked);
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

  // Bottom Sheet Helper for Payment Methods
  void _showPaymentMethodBottomSheet(
      BuildContext context, JobController controller) {
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
              Text('টাকা পাওয়ার মাধ্যম নির্বাচন করুন',
                  style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              ...paymentMethods.map((method) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.payments_outlined,
                        color: AppColors.primary),
                  ),
                  title: Text(method, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    controller.setPaymentMethod(method);
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
    if (!Get.isRegistered<JobController>()) {
      Get.put(JobController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'ক্লায়েন্টের টাকা',
        subtitle: 'করিমের বাসা',
      ),
      body: GetBuilder<JobController>(
        builder: (controller) {
          final double receivedAmount =
              double.tryParse(controller.paymentAmountController.text.trim()) ?? 0;
          final double remainingDue =
              (totalDue - receivedAmount).clamp(0, 9999999);

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Client Brief Card
                _buildClientBriefCard(),

                SizedBox(height: 14.h),

                // 2. Amount Input
                AppTextField(
                  label: 'কত টাকা পেয়েছেন?',
                  controller: controller.paymentAmountController,
                  icon: Icons.payments_outlined,
                  hint: 'পরিমাণ লিখুন',
                  suffixText: 'টাকা',
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 12.h),

                // 3. Payment Type Toggle (আংশিক টাকা / অগ্রিম টাকা)
                _buildPaymentTypeToggle(controller),

                SizedBox(height: 14.h),

                // 4. Payment Method Dropdown
                Text('টাকা পাওয়ার মাধ্যম', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildPaymentMethodDropdown(context, controller),

                SizedBox(height: 14.h),

                // 5. Date Selector
                Text('তারিখ', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildDateSelector(context, controller),

                SizedBox(height: 14.h),

                // 6. Reference Field
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'রেফারেন্স / Txn ID ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  controller: controller.paymentReferenceController,
                  hint: 'ইচ্ছা হলে লিখুন',
                ),

                SizedBox(height: 14.h),

                // 7. Calculated Remaining Due Card
                AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'টাকা নিলে বাকি থাকবে',
                        style: AppTextStyles.mediumGrey,
                      ),
                      Text(
                        '৳${remainingDue.toStringAsFixed(0)}',
                        style: AppTextStyles.custom(
                          size: 16.sp,
                          color: Colors.red,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // 8. Generate Receipt Checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: Checkbox(
                        value: controller.generateReceipt,
                        activeColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        onChanged: (value) {
                          controller.setGenerateReceipt(value ?? true);
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'টাকার রসিদ তৈরি করুন',
                            style: AppTextStyles.mediumBlackBold,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'সেভ করার পর PDF দেখাবে',
                            style: AppTextStyles.smallGrey,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // 9. Info Notice Box
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
                          'এটি হাতে পাওয়া টাকার রেকর্ড।',
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

                // 10. Bottom Action Button
                AppPrimaryButton(
                  onPressed: () {
                    if (controller.generateReceipt) {
                      Get.toNamed(AppRoutes.paymentReceiptPdfPreviewScreen);
                    } else {
                      Get.snackbar(
                        'পেমেন্ট সেভ করা হয়েছে',
                        'ক্লায়েন্টের পেমেন্ট তথ্য সফলভাবে সংরক্ষিত হয়েছে',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.primary,
                        colorText: Colors.white,
                      );
                      Future.delayed(const Duration(milliseconds: 600), () {
                        Get.back();
                      });
                    }
                  },
                  text: 'টাকা পাওয়ার তথ্য সেভ',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Client Brief Card
  Widget _buildClientBriefCard() {
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
                  'আব্দুল করিম',
                  style: AppTextStyles.custom(
                    size: 17.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'এখন বাকি ৳১০,০০০',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Payment Type Toggle (আংশিক টাকা / অগ্রিম টাকা)
  Widget _buildPaymentTypeToggle(JobController controller) {
    return Container(
      height: 46.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          // Option 1: আংশিক টাকা
          Expanded(
            child: InkWell(
              onTap: () => controller.setPartialPayment(true),
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: controller.isPartialPayment
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'আংশিক টাকা',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: controller.isPartialPayment
                        ? Colors.white
                        : AppColors.textSecondary,
                    weight: controller.isPartialPayment
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),

          // Option 2: অগ্রিম টাকা
          Expanded(
            child: InkWell(
              onTap: () => controller.setPartialPayment(false),
              borderRadius: BorderRadius.circular(8.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: !controller.isPartialPayment
                      ? AppColors.primary
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  'অগ্রিম টাকা',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: !controller.isPartialPayment
                        ? Colors.white
                        : AppColors.textSecondary,
                    weight: !controller.isPartialPayment
                        ? FontWeight.w700
                        : FontWeight.w500,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Payment Method Dropdown
  Widget _buildPaymentMethodDropdown(
      BuildContext context, JobController controller) {
    return InkWell(
      onTap: () => _showPaymentMethodBottomSheet(context, controller),
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
                controller.selectedPaymentMethod,
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
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
                _formatDate(controller.paymentDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
