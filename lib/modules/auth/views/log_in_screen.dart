import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_brand_header.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Logo + App Name
          const AppBrandHeader(),

          // Login Content
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    Text(
                      'লগইন করুন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.custom(
                        size: 28.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    Text(
                      'আপনার মোবাইল নম্বর ও পাসওয়ার্ড দিয়ে প্রবেশ করুন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.smallGrey,
                    ),

                    // Subtitle → First Field
                    SizedBox(height: 20.h),

                    const AppTextField(
                      label: 'মোবাইল নম্বর',
                      hint: '01XXXXXXXXXX',
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                    ),

                    // Field → Field
                    SizedBox(height: 8.h),

                    const AppTextField(
                      label: 'পাসওয়ার্ড',
                      hint: 'পাসওয়ার্ড লিখুন',
                      icon: Icons.lock,
                      suffixIcon: Icon(Icons.remove_red_eye_outlined),
                    ),

                    // Password Field → Forgot Password
                    SizedBox(height: 2.h),

                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.forgotPasswordScreen);
                        },
                        child: Text(
                          'পাসওয়ার্ড ভুলে গেছেন?',
                          style: AppTextStyles.custom(
                            color: AppColors.primary,
                            weight: FontWeight.w700,
                            size: 12.sp,
                          ),
                        ),
                      ),
                    ),

                    // Forgot Password → CTA
                    SizedBox(height: 2.h),

                    AppPrimaryButton(
                      text: 'লগইন',
                      icon: Icons.login_rounded,
                      onPressed: () {
                        Get.offAllNamed(AppRoutes.mainScreen);
                      },
                    ),

                    // CTA → Divider
                    SizedBox(height: 36.h),

                    const _OrDivider(),

                    // Divider → Create Account
                    SizedBox(height: 18.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('নতুন একাউন্ট?', style: AppTextStyles.mediumGrey),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.businessSetupScreen);
                          },
                          child: Text(
                            'একাউন্ট তৈরি করুন',
                            style: AppTextStyles.mediumBlackBold.copyWith(
                              color: AppColors.primary,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          child: Text('অথবা', style: AppTextStyles.smallGrey),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
