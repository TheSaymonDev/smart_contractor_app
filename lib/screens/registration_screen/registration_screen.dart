import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_brand_header.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

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
                      'একাউন্ট তৈরি করুন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.largeBlackBold.copyWith(
                        fontSize: 28.sp,
                      ),
                    ),

                    Text(
                      'নতুন একাউন্ট খুলে কাজ শুরু করুন',
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
                    SizedBox(height: 8.h),
                    const AppTextField(
                      label: 'পাসওয়ার্ড',
                      hint: 'পাসওয়ার্ড লিখুন',
                      icon: Icons.lock,
                      suffixIcon: Icon(Icons.remove_red_eye_outlined),
                    ),
                    SizedBox(height: 8.h),
                    const AppTextField(
                      label: 'পাসওয়ার্ড নিশ্চিত করুন',
                      hint: 'আবার পাসওয়ার্ড লিখুন',
                      icon: Icons.lock,
                      suffixIcon: Icon(Icons.remove_red_eye_outlined),
                    ),
                    SizedBox(height: 20.h),
                    AppPrimaryButton(
                      text: 'একাউন্ট তৈরি করুন',
                      icon: Icons.person_add,
                      onPressed: () {},
                    ),

                    // CTA → Divider
                    SizedBox(height: 36.h),

                    _OrDivider(),

                    // Divider → Create Account
                    SizedBox(height: 18.h),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'আগেই একাউন্ট আছে?',
                          style: AppTextStyles.mediumGrey,
                        ),
                        TextButton(
                          onPressed: () {
                            Get.toNamed(AppRoutes.logInScreen);
                          },
                          child: Text(
                            'লগইন করুন',
                            style: AppTextStyles.mediumBlackBold.copyWith(
                              color: AppColors.primary,
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
