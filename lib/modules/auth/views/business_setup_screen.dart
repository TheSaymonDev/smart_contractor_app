import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class BusinessSetupScreen extends StatefulWidget {
  const BusinessSetupScreen({super.key});

  @override
  State<BusinessSetupScreen> createState() => _BusinessSetupScreenState();
}

class _BusinessSetupScreenState extends State<BusinessSetupScreen> {
  final TextEditingController businessNameController = TextEditingController(
    text: 'রহমান কন্ট্রাক্টর সার্ভিস',
  );
  final TextEditingController contractorNameController = TextEditingController(
    text: 'রহমান আলী',
  );
  final TextEditingController phoneController = TextEditingController(
    text: '01712-345678',
  );
  final TextEditingController addressController = TextEditingController(
    text: 'মিরপুর-১০, ঢাকা',
  );

  @override
  void dispose() {
    businessNameController.dispose();
    contractorNameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
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
          icon: Icon(Icons.arrow_back, color: AppColors.primary, size: 24.sp),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ব্যবসার তথ্য',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text('সব নতুন PDF-এ এই তথ্য থাকবে', style: AppTextStyles.smallGrey),
          ],
        ),
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Dashed Logo Box
            _buildLogoBox(),

            SizedBox(height: 16.h),

            // 2. Business Name Field
            AppTextField(
              label: 'ব্যবসার নাম',
              controller: businessNameController,
              icon: Icons.apartment,
              hint: 'রহমান কন্ট্রাক্টর সার্ভিস',
            ),

            SizedBox(height: 14.h),

            // 3. Contractor Name Field
            AppTextField(
              label: 'ঠিকাদারের নাম',
              controller: contractorNameController,
              icon: Icons.person_outline_rounded,
              hint: 'রহমান আলী',
            ),

            SizedBox(height: 14.h),

            // 4. Mobile Number Field
            AppTextField(
              label: 'মোবাইল নম্বর',
              controller: phoneController,
              icon: Icons.phone_outlined,
              hint: '01712-345678',
              keyboardType: TextInputType.phone,
            ),

            SizedBox(height: 14.h),

            // 5. Address Field
            AppTextField(
              label: 'ঠিকানা',
              controller: addressController,
              icon: Icons.location_on_outlined,
              hint: 'মিরপুর-১০, ঢাকা',
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
                      'তথ্য বদলালে নতুন PDF-এ দেখাবে। আগের তৈরি PDF আগের মতোই থাকবে।',
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

            // 7. Bottom Action Button
            AppPrimaryButton(
              onPressed: () {
                Get.snackbar(
                  'তথ্য সংরক্ষিত',
                  'ব্যবসার তথ্য সফলভাবে সেভ করা হয়েছে',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
                Future.delayed(const Duration(milliseconds: 600), () {
                  Get.back();
                });
              },
              text: 'পরিবর্তন সেভ করুন',
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  // Logo Box Helper
  Widget _buildLogoBox() {
    return InkWell(
      onTap: () {
        Get.snackbar(
          'লোগো আপলোড',
          'ব্যবসার লোগো সিলেক্ট করুন',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3F8),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.4),
            width: 1.5,
          ),
        ),
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
                Icons.apartment,
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
                    'লোগো বদলান',
                    style: AppTextStyles.custom(
                      size: 16.sp,
                      color: AppColors.primary,
                      weight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text('ইচ্ছা হলে যোগ করুন', style: AppTextStyles.smallGrey),
                ],
              ),
            ),
            Icon(Icons.edit_outlined, color: AppColors.primary, size: 20.sp),
          ],
        ),
      ),
    );
  }
}
