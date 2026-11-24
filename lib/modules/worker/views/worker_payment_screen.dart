import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/worker/controllers/worker_controller.dart';

class WorkerPaymentScreen extends StatelessWidget {
  const WorkerPaymentScreen({super.key});

  final String workerName = 'রহিম মিয়া';
  final double currentDue = 2400;

  final List<String> purposeOptions = const [
    'আজকের মজুরি / হাজিরা',
    'বাকি পাওনা দেওয়া',
    'অগ্রিম / খোররাকি দেওয়া',
    'মাসিক বেতন',
  ];

  final List<String> methodOptions = const [
    'ক্যাশ / Cash',
    'বিকাশ / bKash',
    'নগদ / Nagad',
    'ব্যাংক ট্রান্সফার / Bank Transfer',
  ];

  // Date Picker
  Future<void> _selectDate(
      BuildContext context, WorkerController controller) async {
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

  void _showBottomSheet(
      BuildContext context, String title, List<String> options, Function(String) onSelect) {
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
              Text(title, style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              ...options.map((opt) {
                return ListTile(
                  title: Text(opt, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    onSelect(opt);
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
    if (!Get.isRegistered<WorkerController>()) {
      Get.put(WorkerController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'কর্মীকে টাকা দিন',
        subtitle: workerName,
      ),
      body: GetBuilder<WorkerController>(
        builder: (controller) {
          final double payingAmount = double.tryParse(
                  controller.paymentAmountController.text.trim()) ??
              0;
          final double remainingDue = currentDue - payingAmount;
          final bool isSurplusAdvance = payingAmount > currentDue;

          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Worker Brief Card
                _buildWorkerBriefCard(),

                SizedBox(height: 14.h),

                // 2. Amount Field
                AppTextField(
                  label: 'টাকার পরিমাণ',
                  controller: controller.paymentAmountController,
                  icon: Icons.payments_outlined,
                  hint: '১,০০০',
                  suffixText: 'টাকা',
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 14.h),

                // 3. Purpose Dropdown (কিসের টাকা?)
                Text('কিসের টাকা?', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildDropdownBox(
                    controller.selectedPurpose,
                    () => _showBottomSheet(
                        context, 'কিসের টাকা নির্বাচন করুন', purposeOptions, (val) {
                      controller.setPaymentPurpose(val);
                    })),

                SizedBox(height: 14.h),

                // 4. Method Dropdown (মাধ্যম)
                Text('মাধ্যম', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildDropdownBox(
                    controller.selectedMethod,
                    () => _showBottomSheet(
                        context, 'মাধ্যম নির্বাচন করুন', methodOptions, (val) {
                      controller.setPaymentMethod(val);
                    })),

                SizedBox(height: 14.h),

                // 5. Date Field (তারিখ)
                Text('তারিখ', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildDateSelector(context, controller),

                SizedBox(height: 14.h),

                // 6. Note Field (রেফারেন্স / নোট)
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'রেফারেন্স / নোট ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  controller: controller.paymentNoteController,
                  hint: 'ইচ্ছা হলে লিখুন',
                ),

                SizedBox(height: 14.h),

                // 7. Calculated Due / Advance Card
                AppCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isSurplusAdvance
                            ? 'টাকা দিলে অগ্রিম দাঁড়াবে'
                            : 'টাকা দিলে বাকি থাকবে',
                        style: AppTextStyles.mediumGrey,
                      ),
                      Text(
                        '৳${remainingDue.abs().toStringAsFixed(0)}',
                        style: AppTextStyles.custom(
                          size: 16.sp,
                          color: isSurplusAdvance
                              ? AppColors.primary
                              : (remainingDue == 0
                                  ? const Color(0xFF079455)
                                  : Colors.red),
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 14.h),

                // 8. Info Notice Box
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
                          'টাকা দেওয়ার পর কর্মীর পাওনা নিজে থেকেই আপডেট হয়ে যাবে।',
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

                // 9. Bottom Action Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'পেমেন্ট সংরক্ষিত',
                      'কর্মীর পেমেন্ট তথ্য সফলভাবে সেভ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'পেমেন্ট সেভ করুন',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

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
                  'এখন পাবে ৳${currentDue.toStringAsFixed(0)}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownBox(String value, VoidCallback onTap) {
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
                value,
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector(BuildContext context, WorkerController controller) {
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
