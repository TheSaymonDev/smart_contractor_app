import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_brand_header.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class BusinessSetupScreen extends StatelessWidget {
  const BusinessSetupScreen({super.key});

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
                      'ব্যবসার তথ্য দিন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.largeBlackBold.copyWith(
                        fontSize: 28.sp,
                      ),
                    ),

                    Text(
                      'আপনার ব্যবসার প্রাথমিক তথ্য যুক্ত করুন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.smallGrey,
                    ),

                    // Subtitle → First Field
                    SizedBox(height: 20.h),

                    const AppTextField(
                      label: 'কন্ট্রাক্টর নাম',
                      hint: 'আপনার নাম লিখুন',
                      icon: Icons.person,
                    ),
                    SizedBox(height: 8.h),
                    const AppTextField(
                      label: 'ব্যবসার নাম',
                      hint: 'আপনার ব্যবসার নাম লিখুন',
                      icon: Icons.apartment,
                    ),
                    SizedBox(height: 8.h),
                    const AppTextField(
                      label: 'মোবাইল নম্বর',
                      hint: '01XXXXXXXXXX',
                      icon: Icons.phone_android_rounded,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 8.h,),
                    const AppTextField(
                      label: 'ঠিকানা',
                      hint: 'আপনার ব্যবসার ঠিকানা লিখুন',
                      icon: Icons.location_on,
                    ),
                    SizedBox(height: 20.h),
                    AppPrimaryButton(
                      text: 'শুরু করুন',
                      icon: Icons.arrow_forward,
                      onPressed: () {
                        Get.toNamed(AppRoutes.registrationScreen);
                      },
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
