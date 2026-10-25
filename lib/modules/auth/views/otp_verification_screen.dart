import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_brand_header.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final TextEditingController otpController = TextEditingController();

  Timer? timer;
  int remainingSeconds = 45;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    if (!mounted) return;
    setState(() {
      remainingSeconds = 45;
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();
      }
    });
  }

  void resendOtp() {
    otpController.clear();
    startTimer();
  }

  void verifyOtp() {
    if (otpController.text.length != 6) {
      Get.snackbar(
        'OTP প্রয়োজন',
        '৬ সংখ্যার OTP কোডটি লিখুন',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.toNamed(AppRoutes.resetPasswordScreen);
  }

  @override
  void dispose() {
    timer?.cancel();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 48.w,
      height: 55.h,
      textStyle: AppTextStyles.custom(
        size: 22.sp,
        color: AppColors.primary,
        weight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.border, width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.8),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),
    );

    return Scaffold(
      body: Column(
        children: [
          // Logo + App Name
          const AppBrandHeader(),

          // OTP Content
          Expanded(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 40.h),

                    Text(
                      'OTP যাচাই করুন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.custom(
                        size: 28.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),

                    SizedBox(height: 4.h),

                    Text(
                      'আপনার মোবাইলে পাঠানো ৬ সংখ্যার কোডটি লিখুন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.smallGrey,
                    ),

                    SizedBox(height: 25.h),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: AppTextStyles.mediumGrey,
                        children: [
                          const TextSpan(text: 'কোড পাঠানো হয়েছে '),
                          TextSpan(
                            text: '01XXXXXXXXXX',
                            style: AppTextStyles.custom(
                              color: AppColors.primary,
                              weight: FontWeight.w700,
                              size: 16.sp,
                            ),
                          ),
                          const TextSpan(text: ' নম্বরে'),
                        ],
                      ),
                    ),

                    SizedBox(height: 22.h),

                    // OTP Input
                    Pinput(
                      length: 6,
                      controller: otpController,
                      autofocus: true,
                      keyboardType: TextInputType.number,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
                      separatorBuilder: (index) => SizedBox(width: 8.w),
                      onCompleted: (pin) {
                        // OTP complete
                      },
                    ),

                    SizedBox(height: 22.h),

                    // Timer
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        vertical: 11.h,
                        horizontal: 12.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primarySoft,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            color: AppColors.primary,
                            size: 20.sp,
                          ),

                          SizedBox(width: 8.w),

                          Text('কোডটি ', style: AppTextStyles.smallBlack),

                          Text(
                            '00:${remainingSeconds.toString().padLeft(2, '0')}',
                            style: AppTextStyles.custom(
                              color: AppColors.primary,
                              size: 16.sp,
                              weight: FontWeight.w700,
                            ),
                          ),

                          Text(
                            ' পর্যন্ত কার্যকর থাকবে',
                            style: AppTextStyles.smallBlack,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    const _OrDivider(),

                    SizedBox(height: 12.h),

                    // Resend
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('কোড পাননি?', style: AppTextStyles.mediumGrey),

                        TextButton(
                          onPressed: remainingSeconds == 0 ? resendOtp : null,
                          child: Text(
                            'OTP আবার পাঠান',
                            style: AppTextStyles.custom(
                              color: remainingSeconds == 0
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              weight: FontWeight.w700,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    AppPrimaryButton(
                      text: 'যাচাই করুন',
                      icon: Icons.verified_user_outlined,
                      onPressed: verifyOtp,
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
