import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/modules/auth/services/auth_session.dart';

class SettingsAndHelpScreen extends StatelessWidget {
  const SettingsAndHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'সেটিংস ও সাহায্য',
        subtitle: 'সহজে অ্যাপ ব্যবহার করুন',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          children: [
            // 1. Password Change Card
            AppCard(
              onTap: () {
                Get.toNamed(AppRoutes.resetPasswordScreen);
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
                      Icons.lock_outline_rounded,
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
                          'পাসওয়ার্ড পরিবর্তন',
                          style: AppTextStyles.custom(
                            size: 16.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'SMS কোড দিয়ে নতুন পাসওয়ার্ড দিন',
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

            SizedBox(height: 12.h),

            // 2. "যেভাবে PDF দেবেন" Guide Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'যেভাবে PDF দেবেন',
                        style: AppTextStyles.custom(
                          size: 16.sp,
                          color: AppColors.textPrimary,
                          weight: FontWeight.w700,
                        ),
                      ),
                      Icon(
                        Icons.description_outlined,
                        color: AppColors.textSecondary,
                        size: 20.sp,
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  _buildGuideStep('১. মালামালের টেমপ্লেট খুলুন'),
                  SizedBox(height: 8.h),
                  _buildGuideStep('২. মালামাল ও পরিমাণ ঠিক করুন'),
                  SizedBox(height: 8.h),
                  _buildGuideStep('৩. ক্লায়েন্টের তথ্য মিলিয়ে নিন'),
                  SizedBox(height: 8.h),
                  _buildGuideStep('৪. PDF দেখে শেয়ার করুন'),
                ],
              ),
            ),

            SizedBox(height: 12.h),

            // 3. Support Card
            AppCard(
              onTap: () {
                Get.snackbar(
                  'সাহায্য ও সাপোর্ট',
                  'আমাদের হটলাইন: 01700-000000 (সকাল ৯টা - রাত ৯টা)',
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
                      Icons.help_outline_rounded,
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
                          'সাহায্য নিন',
                          style: AppTextStyles.custom(
                            size: 16.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'অ্যাপ ব্যবহারে সমস্যা হলে',
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

            SizedBox(height: 12.h),

            // 4. Delete Account Request Card
            AppCard(
              onTap: () {
                Get.defaultDialog(
                  title: 'অ্যাকাউন্ট মোছার আবেদন',
                  middleText: 'আপনি কি নিশ্চিত যে আপনার অ্যাকাউন্টটি মুছতে চান?',
                  textConfirm: 'হ্যাঁ, আবেদন পাঠান',
                  textCancel: 'বাতিল',
                  confirmTextColor: Colors.white,
                  buttonColor: Colors.red,
                  onConfirm: () {
                    Get.back();
                    Get.snackbar(
                      'আবেদন গৃহীত হয়েছে',
                      'আপনার অ্যাকাউন্ট মোছার আবেদন প্রক্রিয়াধীন রয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
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
                      Icons.person_outline_rounded,
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
                          'অ্যাকাউন্ট মুছতে আবেদন',
                          style: AppTextStyles.custom(
                            size: 16.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'আবেদনের আগে তথ্য দেখে নিন',
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

            SizedBox(height: 20.h),

            // 5. Version Text
            Center(
              child: Text(
                'Smart Contractor • V1',
                style: AppTextStyles.custom(
                  size: 13.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // 6. Bottom Logout Button
            InkWell(
              onTap: () {
                if (Get.isRegistered<AuthSession>()) {
                  Get.find<AuthSession>().clear();
                }
                Get.offAllNamed(AppRoutes.logInScreen);
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.primary, width: 1.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_rounded,
                      color: AppColors.primary,
                      size: 20.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'লগআউট',
                      style: AppTextStyles.custom(
                        size: 14.sp,
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
      ),
    );
  }

  Widget _buildGuideStep(String stepText) {
    return Text(
      stepText,
      style: AppTextStyles.custom(
        size: 13.sp,
        color: AppColors.textSecondary,
        height: 1.4,
      ),
    );
  }
}
