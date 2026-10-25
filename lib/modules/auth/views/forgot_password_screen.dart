import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_brand_header.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

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
                    SizedBox(height: 80.h),

                    Text(
                      'পাসওয়ার্ড ভুলে গেছেন?',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.custom(
                        size: 28.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    Text(
                      'আপনার মোবাইল নম্বর দিন, আমরা OTP পাঠাবো',
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

                    SizedBox(height: 20.h),
                    AppPrimaryButton(
                      text: 'OTP পাঠান',
                      icon: Icons.send,
                      onPressed: () {
                        Get.toNamed(AppRoutes.otpVerificationScreen);
                      },
                    ),

                    // CTA → Divider
                    SizedBox(height: 36.h),

                    const _OrDivider(),

                    // Divider → Create Account
                    SizedBox(height: 18.h),

                    TextButton(
                      onPressed: () {
                        Get.offNamed(AppRoutes.logInScreen);
                      },
                      child: Text(
                        'লগইন-এ ফিরে যান',
                        style: AppTextStyles.custom(
                          color: AppColors.primary,
                          weight: FontWeight.w700,
                          size: 16.sp,
                        ),
                      ),
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
