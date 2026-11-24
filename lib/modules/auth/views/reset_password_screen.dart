import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/auth/controllers/auth_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'নতুন পাসওয়ার্ড',
        subtitle: 'আপনার অ্যাকাউন্ট সুরক্ষিত রাখুন',
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 12.h),

                // 1. Center Lock Banner Icon Box
                Center(
                  child: Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                    child: Icon(
                      Icons.lock_outline_rounded,
                      color: AppColors.primary,
                      size: 38.sp,
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // 2. New Password Field
                AppTextField(
                  label: 'নতুন পাসওয়ার্ড',
                  controller: controller.newPasswordController,
                  hint: 'কমপক্ষে ৮ অক্ষর',
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.isResetPasswordObscured,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.toggleResetPasswordVisibility();
                    },
                    icon: Icon(
                      controller.isResetPasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                  ),
                ),

                SizedBox(height: 14.h),

                // 3. Confirm New Password Field
                AppTextField(
                  label: 'আবার নতুন পাসওয়ার্ড',
                  controller: controller.resetConfirmPasswordController,
                  hint: 'একই পাসওয়ার্ড লিখুন',
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.isResetPasswordObscured,
                ),

                SizedBox(height: 20.h),

                // 4. Primary Save Password Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'পাসওয়ার্ড পরিবর্তিত হয়েছে',
                      'নতুন পাসওয়ার্ড সফলভাবে সংরক্ষণ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Get.offAllNamed(AppRoutes.logInScreen);
                  },
                  text: 'পাসওয়ার্ড সেভ করুন',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
