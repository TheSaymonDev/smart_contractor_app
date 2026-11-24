import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/worker/controllers/worker_controller.dart';

class BulkWorkerPaymentItem {
  final String id;
  final String name;
  final String dueText;
  bool isSelected;
  final TextEditingController amountController;
  String purpose;
  String method;

  BulkWorkerPaymentItem({
    required this.id,
    required this.name,
    required this.dueText,
    this.isSelected = true,
    required this.amountController,
    this.purpose = 'মজুরি',
    this.method = 'ক্যাশ',
  });
}

class BulkWorkerPaymentScreen extends StatelessWidget {
  const BulkWorkerPaymentScreen({super.key});

  final List<String> purposeOptions = const ['মজুরি', 'অগ্রিম', 'খোরাকি / বোনাস'];
  final List<String> methodOptions = const [
    'ক্যাশ',
    'bKash',
    'Nagad',
    'ব্যাংক ট্রান্সফার'
  ];

  // Date Picker
  Future<void> _selectDate(
      BuildContext context, WorkerController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: controller.bulkDate,
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
      controller.setBulkDate(picked);
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
    if (!Get.isRegistered<WorkerController>()) {
      Get.put(WorkerController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'একসাথে টাকা দিন',
        subtitle: 'কর্মী বেছে টাকা ও মাধ্যম লিখুন',
      ),
      body: GetBuilder<WorkerController>(
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Date Field
                Text('তারিখ', style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 6.h),
                _buildDateSelectorBox(context, controller),

                SizedBox(height: 14.h),

                // 2. Info Notice Box
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
                          'সেভ করার আগে প্রতিটি কর্মীর টাকার পরিমাণ মিলিয়ে নিন।',
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

                // 3. Bottom Action Save Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'পেমেন্ট সেভ করা হয়েছে',
                      'কর্মীদের পেমেন্ট প্রদানের তথ্য সংরক্ষিত হয়েছে',
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

  Widget _buildDateSelectorBox(
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
                _formatDate(controller.bulkDate),
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
