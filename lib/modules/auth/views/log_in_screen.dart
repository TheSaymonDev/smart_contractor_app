import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/network/api_exceptions.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_message.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/auth/controllers/log_in_controller.dart';
import 'package:smart_contractor_app/modules/auth/utils/auth_phone.dart';

class LogInScreen extends GetView<LogInController> {
  const LogInScreen({super.key});

  Future<void> _submit(BuildContext context) async {
    final controller = this.controller;
    if (controller.isSubmitting || controller.formKey.currentState?.validate() != true) return;
    FocusScope.of(context).unfocus();
    try {
      final result = await controller.logIn();
      if (!context.mounted ||
          result == null ||
          ModalRoute.of(context)?.isCurrent != true) {
        return;
      }
      Get.offAllNamed(
        result.businessSetupRequired
            ? AppRoutes.businessSetupScreen
            : AppRoutes.mainScreen,
      );
    } on ApiException catch (error) {
      if (!context.mounted || ModalRoute.of(context)?.isCurrent != true) return;
      AppMessage.error(
        context,
        error.statusCode == 401
            ? 'মোবাইল নম্বর বা পাসওয়ার্ড সঠিক নয়।'
            : error.message,
      );
    }
  }

  Future<void> _openRegistration(BuildContext context) async {
    final controller = this.controller;
    if (controller.isSubmitting) return;

    final phone = await Get.toNamed<String>(AppRoutes.registrationScreen);
    if (!context.mounted || phone == null) return;

    controller.phoneController.text = phone;
    controller.passwordController.clear();
    AppMessage.success(context, 'অ্যাকাউন্ট তৈরি হয়েছে। এখন লগইন করুন।');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'স্বাগতম',
        subtitle: 'আপনার অ্যাকাউন্টে প্রবেশ করুন',
      ),
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),

              _buildBrandHeader(),

              SizedBox(height: 28.h),

              Text(
                'লগইন করুন',
                style: AppTextStyles.custom(
                  size: 18.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w800,
                ),
              ),

              SizedBox(height: 14.h),

              GetBuilder<LogInController>(
                id: LogInController.submissionId,
                builder: (controller) => AppTextField(
                  label: 'মোবাইল নম্বর',
                  controller: controller.phoneController,
                  readOnly: controller.isSubmitting,
                  validator: (value) => normalizeAuthPhone(value ?? '') == null
                      ? 'সঠিক বাংলাদেশি মোবাইল নম্বর লিখুন'
                      : null,
                  hint: '01XXXXXXXXX',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                ),
              ),

              SizedBox(height: 14.h),

              GetBuilder<LogInController>(
                id: LogInController.passwordId,
                builder: (controller) => AppTextField(
                  label: 'পাসওয়ার্ড',
                  controller: controller.passwordController,
                  readOnly: controller.isSubmitting,
                  validator: (value) {
                    final length = value?.runes.length ?? 0;
                    if (length == 0) return 'পাসওয়ার্ড লিখুন';
                    if (length > 72) {
                      return 'পাসওয়ার্ড সর্বোচ্চ ৭২ অক্ষরের হতে পারে';
                    }
                    return null;
                  },
                  hint: '••••••••',
                  icon: Icons.lock_outline_rounded,
                  obscureText: controller.isPasswordObscured,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.togglePasswordVisibility();
                    },
                    icon: Icon(
                      controller.isPasswordObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: AppColors.textSecondary,
                      size: 20.sp,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 8.h),

              GetBuilder<LogInController>(
                id: LogInController.submissionId,
                builder: (controller) => Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: controller.isSubmitting
                        ? null
                        : () => Get.toNamed(AppRoutes.forgotPasswordScreen),
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
              ),

              SizedBox(height: 20.h),

              GetBuilder<LogInController>(
                id: LogInController.submissionId,
                builder: (controller) => AppPrimaryButton(
                  isLoading: controller.isSubmitting,
                  onPressed: () => _submit(context),
                  text: controller.isSubmitting ? 'লগইন হচ্ছে…' : 'লগইন করুন',
                  icon: Icons.chevron_right_rounded,
                ),
              ),

              SizedBox(height: 20.h),

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
                    onTap: () => _openRegistration(context),
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

              _buildContractorNotice(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrandHeader() => Center(
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
  );

  Widget _buildContractorNotice() => Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
  );
}
