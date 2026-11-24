import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/auth/controllers/auth_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  const OtpVerificationScreen({super.key});

  String _toBengaliNumber(String number) {
    const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
    const bengali = ['০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯'];
    for (int i = 0; i < english.length; i++) {
      number = number.replaceAll(english[i], bengali[i]);
    }
    return number;
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 46.w,
      height: 52.h,
      textStyle: AppTextStyles.custom(
        size: 22.sp,
        color: AppColors.primary,
        weight: FontWeight.w800,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.8),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'কোড দিন',
        subtitle: 'পাসওয়ার্ড পরিবর্তন',
      ),
      body: GetBuilder<AuthController>(
        builder: (controller) {
          final String formattedTimer =
              '০০:${_toBengaliNumber(controller.remainingSeconds.toString().padLeft(2, '0'))}';

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

                SizedBox(height: 28.h),

                // 2. Headings
                Text(
                  'SMS-এর কোড লিখুন',
                  style: AppTextStyles.custom(
                    size: 18.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w800,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  '01712•••678 নম্বরে কোড পাঠানো হয়েছে',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: AppColors.textSecondary,
                  ),
                ),

                SizedBox(height: 24.h),

                // 3. Pinput 6-Digit Boxes
                Center(
                  child: Pinput(
                    length: 6,
                    controller: controller.otpController,
                    autofocus: true,
                    keyboardType: TextInputType.number,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    separatorBuilder: (index) => SizedBox(width: 8.w),
                    onCompleted: (pin) {
                      controller.verifyOtp();
                    },
                  ),
                ),

                SizedBox(height: 24.h),

                // 4. Resend & Timer Text Row
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: controller.remainingSeconds == 0
                            ? controller.resendOtp
                            : null,
                        child: Text(
                          'আবার কোড পাঠান',
                          style: AppTextStyles.custom(
                            size: 13.sp,
                            color: controller.remainingSeconds == 0
                                ? AppColors.primary
                                : AppColors.textSecondary,
                            weight: controller.remainingSeconds == 0
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                      Text(
                        ' · ',
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      Text(
                        formattedTimer,
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: AppColors.primary,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

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
                          'কোডটি কাউকে বলবেন না।',
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

                // 6. Primary Action Button (পরের ধাপ)
                AppPrimaryButton(
                  onPressed: controller.verifyOtp,
                  text: 'পরের ধাপ',
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
