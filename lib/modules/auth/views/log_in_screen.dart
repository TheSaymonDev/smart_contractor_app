import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/auth/controllers/auth_controller.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'স্বাগতম',
        subtitle: 'আপনার অ্যাকাউন্টে প্রবেশ করুন',
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                // 1. Center Brand Logo Banner
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: 72.w,
                        height: 72.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(22.r),
                        ),
                        child: Icon(
                          Icons.apartment,
                          color: Colors.white,
                          size: 38.sp,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'Smart Contractor',
                        style: AppTextStyles.custom(
                          size: 24.sp,
                          color: AppColors.primary,
                          weight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'কাজ, মালামাল ও হিসাব — এক জায়গায়',
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 28.h),

                // 2. Section Heading
                Text(
                  'লগইন করুন',
                  style: AppTextStyles.custom(
                    size: 18.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 14.h),

                // 3. Mobile Number Field
                AppTextField(
                  label: 'মোবাইল নম্বর',
                  controller: controller.loginPhoneController,
                  hint: '01XXXXXXXXX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 14.h),

                // 4. Password Field
                AppTextField(
                  label: 'পাসওয়ার্ড',
                  controller: controller.loginPasswordController,
                  hint: '••••••••',
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.isLoginPasswordObscured,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.toggleLoginPasswordVisibility();
                    },
                    icon: Icon(
                      controller.isLoginPasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                  ),
                ),

                SizedBox(height: 8.h),

                // 5. Forgot Password Link
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.forgotPasswordScreen);
                    },
                    child: Text(
                      'পাসওয়ার্ড ভুলে গেছেন?',
                      style: AppTextStyles.custom(
                        size: 13.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // 6. Primary Login Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.mainScreen);
                  },
                  text: 'লগইন করুন',
                  icon: Icons.chevron_right_rounded,
                ),

                SizedBox(height: 20.h),

                // 7. Register Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'নতুন ব্যবহারকারী? ',
                      style: AppTextStyles.custom(
                        size: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.toNamed(AppRoutes.registrationScreen);
                      },
                      child: Text(
                        'অ্যাকাউন্ট খুলুন',
                        style: AppTextStyles.custom(
                          size: 14.sp,
                          color: AppColors.primary,
                          weight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // 8. Bottom Contractor Notice Box
                Container(
                  width: double.infinity,
                  padding:
                      EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
                      SizedBox(width: 10.w),
                      Expanded(
                        child: Text(
                          'শুধু ঠিকাদার এই অ্যাপ ব্যবহার করবেন।',
                          style: AppTextStyles.custom(
                            size: 13.sp,
                            color: AppColors.primary,
                            weight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
