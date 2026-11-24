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

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'পাসওয়ার্ড ভুলে গেছেন?',
        subtitle: 'আপনার মোবাইলে কোড পাঠাব',
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

                // 1. Center Phone Banner Icon Box
                Center(
                  child: Container(
                    width: 72.w,
                    height: 72.w,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(22.r),
                    ),
                    child: Icon(
                      Icons.phone_outlined,
                      color: AppColors.primary,
                      size: 38.sp,
                    ),
                  ),
                ),

                SizedBox(height: 32.h),

                // 2. Mobile Number Field
                AppTextField(
                  label: 'অ্যাকাউন্টের মোবাইল নম্বর',
                  controller: controller.forgotPhoneController,
                  hint: '01XXXXXXXXX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 14.h),

                // 3. Info Notice Box
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
                          'SMS-এ একটি ৬ সংখ্যার কোড পাবেন। সেই কোড দিয়ে নতুন পাসওয়ার্ড দিন।',
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

                SizedBox(height: 20.h),

                // 4. Primary Send Code Button
                AppPrimaryButton(
                  onPressed: () {
                    controller.startOtpTimer();
                    Get.toNamed(AppRoutes.otpVerificationScreen);
                  },
                  text: 'কোড পাঠান',
                  icon: Icons.chevron_right_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
