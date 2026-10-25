import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class JobManagementScreen extends StatefulWidget {
  const JobManagementScreen({super.key});

  @override
  State<JobManagementScreen> createState() => _JobManagementScreenState();
}

class _JobManagementScreenState extends State<JobManagementScreen> {
  // Form Controllers
  final TextEditingController workNameController =
      TextEditingController(text: 'করিমের বাসা');
  final TextEditingController addressController =
      TextEditingController(text: 'মিরপুর-১০, ঢাকা');
  final TextEditingController noteController = TextEditingController();

  // Selected Values
  String selectedClientName = 'আব্দুল করিম';
  String selectedWorkType = 'পাইপ ফিটিংস';

  DateTime startDate = DateTime(2026, 10, 23);
  DateTime? endDate;

  // Options
  final List<String> clients = [
    'আব্দুল করিম',
    'সেলিম মিয়া',
    'হানিফ স্টোর',
    'রহিমা বেগম',
  ];

  final List<String> workTypes = [
    'পাইপ ফিটিংস',
    'মোটর বসানো',
    'বেসিন ফিটিং',
    'ওয়্যারিং কাজ',
    'অন্যান্য কাজ',
  ];

  // Date Picker
  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? startDate : (endDate ?? DateTime.now()),
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
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
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
    return '${date.day} ${months[date.month - 1]}';
  }

  // Selection Bottom Sheet Helper
  void _showSelectionBottomSheet({
    required String title,
    required List<Widget> children,
  }) {
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
              ...children,
            ],
          ),
        );
      },
    );
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
              'নতুন কাজ',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'আগে ক্লায়েন্ট বাছুন',
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
            // 1. Client Field
            Text('ক্লায়েন্ট', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildClientSelector(),

            SizedBox(height: 6.h),
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.clientManagementScreen);
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 4.h),
                child: Text(
                  '+ নতুন ক্লায়েন্ট যোগ করুন',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: AppColors.primary,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            ),

            SizedBox(height: 12.h),

            // 2. Work Name
            AppTextField(
              label: 'কাজের নাম',
              controller: workNameController,
              icon: Icons.work_outline_rounded,
              hint: 'করিমের বাসা',
            ),

            SizedBox(height: 12.h),

            // 3. Work Type Dropdown
            Text('কাজের ধরন', style: AppTextStyles.mediumBlackBold),
            SizedBox(height: 6.h),
            _buildWorkTypeDropdown(),

            SizedBox(height: 12.h),

            // 4. Address Field
            AppTextField(
              label: 'কাজের ঠিকানা',
              controller: addressController,
              icon: Icons.location_on_outlined,
              hint: 'মিরপুর-১০, ঢাকা',
            ),

            SizedBox(height: 12.h),

            // 5. Dates Row
            Row(
              children: [
                // Start Date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('শুরু তারিখ', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 6.h),
                      _buildDateBox(
                        dateText: _formatDate(startDate),
                        onTap: () => _selectDate(context, true),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),

                // End Date (Optional)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: 'শেষের তারিখ ',
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
                      _buildDateBox(
                        dateText: endDate != null
                            ? _formatDate(endDate!)
                            : 'পরে দিন',
                        isOptional: endDate == null,
                        onTap: () => _selectDate(context, false),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            // 6. Additional Note (Optional)
            AppTextField(
              labelWidget: RichText(
                text: TextSpan(
                  text: 'কাজের নোট ',
                  style: AppTextStyles.mediumBlackBold,
                  children: [
                    TextSpan(
                      text: '(ইচ্ছা হলে)',
                      style: AppTextStyles.smallGrey,
                    ),
                  ],
                ),
              ),
              controller: noteController,
              maxLines: 2,
              hint: 'যেমন: ২য় তলার বাথরুম',
            ),

            SizedBox(height: 14.h),

            // Info Notice Box
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
                      'শুরুতে কাজের অবস্থা "চলছে" থাকবে। মজুরি পরে ঠিক করতে পারবেন।',
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

            // Bottom Action Button
            AppPrimaryButton(
              onPressed: () {
                Get.snackbar(
                  'সফল হয়েছে',
                  'নতুন কাজ সফলভাবে তৈরি করা হয়েছে',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
                Future.delayed(const Duration(milliseconds: 600), () {
                  Get.back();
                });
              },
              text: 'কাজ তৈরি করুন',
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  // Client Selector Box
  Widget _buildClientSelector() {
    return InkWell(
      onTap: () {
        _showSelectionBottomSheet(
          title: 'ক্লায়েন্ট নির্বাচন করুন',
          children: clients.map((client) {
            return ListTile(
              leading: CircleAvatar(
                backgroundColor: AppColors.primaryLight,
                child: const Icon(Icons.person, color: AppColors.primary),
              ),
              title: Text(client, style: AppTextStyles.mediumBlackBold),
              onTap: () {
                setState(() {
                  selectedClientName = client;
                });
                Get.back();
              },
            );
          }).toList(),
        );
      },
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
              Icons.person_outline_rounded,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Text(
                selectedClientName,
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Work Type Dropdown Helper
  Widget _buildWorkTypeDropdown() {
    return InkWell(
      onTap: () {
        _showSelectionBottomSheet(
          title: 'কাজের ধরন নির্বাচন করুন',
          children: workTypes.map((type) {
            return ListTile(
              title: Text(type, style: AppTextStyles.mediumBlack),
              onTap: () {
                setState(() {
                  selectedWorkType = type;
                });
                Get.back();
              },
            );
          }).toList(),
        );
      },
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
                selectedWorkType,
                style: AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Date Selector Box Helper
  Widget _buildDateBox({
    required String dateText,
    bool isOptional = false,
    required VoidCallback onTap,
  }) {
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
              Icons.calendar_month_outlined,
              color: AppColors.textSecondary,
              size: 20.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                dateText,
                style: isOptional
                    ? AppTextStyles.mediumGrey
                    : AppTextStyles.mediumBlackBold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
