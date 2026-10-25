import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/attendance/models/attendance_model.dart';

class SplitWageScreen extends StatefulWidget {
  const SplitWageScreen({super.key});

  @override
  State<SplitWageScreen> createState() => _SplitWageScreenState();
}

class _SplitWageScreenState extends State<SplitWageScreen> {
  final TextEditingController totalWageController =
      TextEditingController(text: '800');
  final TextEditingController job1AmountController =
      TextEditingController(text: '500');
  final TextEditingController job2AmountController =
      TextEditingController(text: '300');

  String selectedJob1 = 'করিমের বাসা';
  String selectedJob2 = 'সেলিমের দোকান';

  String workerName = 'রহিম মিয়া';
  String dateText = '২৩ অক্টোবর';

  final List<String> availableJobs = [
    'করিমের বাসা',
    'সেলিমের দোকান',
    'হানিফের বাড়ি',
    'রহিমার বাসা',
    'টিউবওয়েল বসানো',
  ];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is AttendanceModel) {
      workerName = args.workerName;
      totalWageController.text = args.dailyRate.toStringAsFixed(0);
      selectedJob1 = args.jobName;
    }

    totalWageController.addListener(() => setState(() {}));
    job1AmountController.addListener(() => setState(() {}));
    job2AmountController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    totalWageController.dispose();
    job1AmountController.dispose();
    job2AmountController.dispose();
    super.dispose();
  }

  // Job Selector Bottom Sheet Helper
  void _showJobSelectionBottomSheet(bool isJob1) {
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
              Text('কাজ নির্বাচন করুন', style: AppTextStyles.mediumBlackBold),
              SizedBox(height: 12.h),
              ...availableJobs.map((job) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryLight,
                    child: const Icon(Icons.work_outline,
                        color: AppColors.primary),
                  ),
                  title: Text(job, style: AppTextStyles.mediumBlack),
                  onTap: () {
                    setState(() {
                      if (isJob1) {
                        selectedJob1 = job;
                      } else {
                        selectedJob2 = job;
                      }
                    });
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
    final double job1Val =
        double.tryParse(job1AmountController.text.trim()) ?? 0;
    final double job2Val =
        double.tryParse(job2AmountController.text.trim()) ?? 0;
    final double splitTotal = job1Val + job2Val;

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
              'দুই কাজে মজুরি ভাগ',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '$workerName • $dateText',
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

            // 2. Today's Total Wage Field
            AppTextField(
              label: 'আজকের মোট মজুরি',
              controller: totalWageController,
              icon: Icons.payments_outlined,
              hint: '৮০০',
              suffixText: 'টাকা',
              keyboardType: TextInputType.number,
            ),

            SizedBox(height: 14.h),

            // 3. Job 1 Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('১ম কাজ', style: AppTextStyles.mediumBlackBold),
                  SizedBox(height: 6.h),
                  _buildJobDropdown(selectedJob1, () => _showJobSelectionBottomSheet(true)),
                  SizedBox(height: 10.h),
                  Text('এই কাজের মজুরি', style: AppTextStyles.mediumBlackBold),
                  SizedBox(height: 6.h),
                  _buildInputField(
                    controller: job1AmountController,
                    hint: '৫০০',
                    suffixText: 'টাকা',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // 4. Job 2 Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('২য় কাজ', style: AppTextStyles.mediumBlackBold),
                  SizedBox(height: 6.h),
                  _buildJobDropdown(selectedJob2, () => _showJobSelectionBottomSheet(false)),
                  SizedBox(height: 10.h),
                  Text('এই কাজের মজুরি', style: AppTextStyles.mediumBlackBold),
                  SizedBox(height: 6.h),
                  _buildInputField(
                    controller: job2AmountController,
                    hint: '৩০০',
                    suffixText: 'টাকা',
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // 5. Calculated Split Total Card
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'দুই কাজে মোট',
                    style: AppTextStyles.mediumGrey,
                  ),
                  Text(
                    '৳${splitTotal.toStringAsFixed(0)}',
                    style: AppTextStyles.custom(
                      size: 16.sp,
                      color: const Color(0xFF079455),
                      weight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),

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
                      'দুই কাজে ভাগ করা টাকা আজকের মোট মজুরির সমান হতে হবে।',
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
                  'হিসাব সংরক্ষিত',
                  'দুই কাজে মজুরি ভাগ করার হিসাব সফলভাবে সেভ করা হয়েছে',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
                Future.delayed(const Duration(milliseconds: 600), () {
                  Get.back();
                });
              },
              text: 'ভাগ করা হিসাব সেভ',
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  // Worker Brief Card Helper
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
                  'পূর্ণ দিন • আজকের মোট মজুরি ৳${totalWageController.text}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Job Dropdown Helper
  Widget _buildJobDropdown(String selectedJob, VoidCallback onTap) {
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
                selectedJob,
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
        prefixIcon: Icon(
          Icons.payments_outlined,
          color: AppColors.textSecondary,
          size: 20.sp,
        ),
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
}
