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

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'অ্যাকাউন্ট খুলুন',
        subtitle: 'শুরু করতে মাত্র ৩টি তথ্য',
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8.h),

                // 1. Horizontal Brand Header Row
                Row(
                  children: [
                    Icon(
                      Icons.apartment,
                      color: AppColors.primary,
                      size: 26.sp,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Smart Contractor',
                      style: AppTextStyles.custom(
                        size: 20.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // 2. Name Field
                AppTextField(
                  label: 'আপনার নাম',
                  controller: controller.regNameController,
                  hint: 'আপনার নাম লিখুন',
                  icon: Icons.person_outline_rounded,
                ),

                SizedBox(height: 14.h),

                // 3. Mobile Number Field
                AppTextField(
                  label: 'মোবাইল নম্বর',
                  controller: controller.regPhoneController,
                  hint: '01XXXXXXXXX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 14.h),

                // 4. Password Field
                AppTextField(
                  label: 'পাসওয়ার্ড',
                  controller: controller.regPasswordController,
                  hint: 'কমপক্ষে ৮ অক্ষর',
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.isRegPasswordObscured,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.toggleRegPasswordVisibility();
                    },
                    icon: Icon(
                      controller.isRegPasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // 5. Info Notice Box
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
                          'এই নম্বর ও পাসওয়ার্ড দিয়ে পরে লগইন করবেন।',
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

                // 6. Primary Action Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.offAllNamed(AppRoutes.mainScreen);
                  },
                  text: 'অ্যাকাউন্ট খুলুন',
                  icon: Icons.chevron_right_rounded,
                ),

                SizedBox(height: 20.h),

                // 7. Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'অ্যাকাউন্ট আছে? ',
                      style: AppTextStyles.custom(
                        size: 14.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offNamed(AppRoutes.logInScreen);
                      },
                      child: Text(
                        'লগইন করুন',
                        style: AppTextStyles.custom(
                          size: 14.sp,
                          color: AppColors.primary,
                          weight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
