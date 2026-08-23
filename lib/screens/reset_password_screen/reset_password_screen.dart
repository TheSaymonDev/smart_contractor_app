import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_brand_header.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

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
                    SizedBox(height: 60.h),

                    Text(
                      'নতুন পাসওয়ার্ড সেট করুন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.largeBlackBold.copyWith(
                        fontSize: 28.sp,
                      ),
                    ),

                    Text(
                      'আপনার একাউন্টের জন্য নতুন পাসওয়ার্ড দিন',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.smallGrey,
                    ),

                    SizedBox(height: 20.h),
                    const AppTextField(
                      label: 'নতুন পাসওয়ার্ড',
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
                      text: 'পাসওয়ার্ড সংরক্ষণ করুন',
                      icon: Icons.save,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.r)),
                        color: AppColors.primaryLight
                      ),
                      padding: EdgeInsets.all(8.w),
                      child: Row(
                        children: [
                          Icon(Icons.shield_moon, size: 60.sp, color: AppColors.primary,),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('শক্তিশালী পাসওয়ার্ড ব্যবহার করুন',style: AppTextStyles.mediumBlack.copyWith(color: AppColors.primary),),
                                Text('অন্তত ৮ অক্ষর, বড় হাতের অক্ষর, ছোট হাতের অক্ষর, সংখ্যা ও বিশেষ চিহ্ন ব্যবহার করুন।',style: AppTextStyles.smallBlack,),
                              ],
                            ),
                          )
                        ],
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
