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

class BusinessSetupScreen extends StatelessWidget {
  const BusinessSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'ব্যবসার তথ্য',
        subtitle: 'এই তথ্য আপনার PDF-এ থাকবে',
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

                // 1. Logo Add Box
                _buildLogoAddBox(),

                SizedBox(height: 20.h),

                // 2. Business Name Field
                AppTextField(
                  label: 'ব্যবসার নাম',
                  controller: controller.businessNameController,
                  icon: Icons.apartment,
                  hint: 'রহমান কন্ট্রাক্টর সার্ভিস',
                ),

                SizedBox(height: 14.h),

                // 3. Contractor Name Field
                AppTextField(
                  label: 'ঠিকাদারের নাম',
                  controller: controller.contractorNameController,
                  icon: Icons.person_outline_rounded,
                  hint: 'রহমান আলী',
                ),

                SizedBox(height: 14.h),

                // 4. Mobile Number Field
                AppTextField(
                  label: 'মোবাইল নম্বর',
                  controller: controller.businessPhoneController,
                  icon: Icons.phone_outlined,
                  hint: '01712-345678',
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 14.h),

                // 5. Address Field
                AppTextField(
                  label: 'ঠিকানা',
                  controller: controller.businessAddressController,
                  icon: Icons.location_on_outlined,
                  hint: 'মিরপুর-১০, ঢাকা',
                ),

                SizedBox(height: 16.h),

                // 6. Info Notice Box
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
                          'পরে আরও → ব্যবসার তথ্য থেকে বদলাতে পারবেন।',
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

                SizedBox(height: 24.h),

                // 7. Primary Action Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'তথ্য সংরক্ষিত',
                      'ব্যবসার তথ্য সফলভাবে সেভ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Get.offAllNamed(AppRoutes.mainScreen);
                  },
                  text: 'শুরু করুন',
                  icon: Icons.chevron_right_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Logo Add Box Helper
  Widget _buildLogoAddBox() {
    return InkWell(
      onTap: () {
        Get.snackbar(
          'লোগো আপলোড',
          'ব্যবসার লোগো সিলেক্ট করুন',
          snackPosition: SnackPosition.BOTTOM,
        );
      },
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: const Color(0xFFEFF3F8),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                Icons.apartment,
                color: AppColors.primary,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'লোগো যোগ করুন',
                    style: AppTextStyles.custom(
                      size: 15.sp,
                      color: AppColors.primary,
                      weight: FontWeight.w800,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'ইচ্ছা হলে · না দিলেও চলবে',
                    style: AppTextStyles.custom(
                      size: 12.sp,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.add,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ],
        ),
      ),
    );
  }
}
