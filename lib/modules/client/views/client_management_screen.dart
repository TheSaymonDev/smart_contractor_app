import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/client/controllers/client_controller.dart';

class ClientManagementScreen extends StatelessWidget {
  const ClientManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<ClientController>()
        ? Get.find<ClientController>()
        : Get.put(ClientController());

    final args = Get.arguments;
    if (args is Map<String, dynamic>) {
      if (args.containsKey('name')) controller.nameController.text = args['name'].toString();
      if (args.containsKey('phone')) controller.phoneController.text = args['phone'].toString();
      if (args.containsKey('address')) controller.addressController.text = args['address'].toString();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'ক্লায়েন্টের তথ্য',
        subtitle: 'এই তথ্য ক্লায়েন্টের PDF-এ যাবে',
      ),
      body: GetBuilder<ClientController>(
        builder: (controller) {
          return SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Client Name
                AppTextField(
                  label: 'ক্লায়েন্টের নাম',
                  controller: controller.nameController,
                  icon: Icons.person_outline_rounded,
                  hint: 'আব্দুল করিম',
                ),

                SizedBox(height: 14.h),

                // 2. Mobile Number (Optional)
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'মোবাইল নম্বর ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  controller: controller.phoneController,
                  icon: Icons.phone_outlined,
                  hint: '01812-345678',
                  keyboardType: TextInputType.phone,
                ),

                SizedBox(height: 14.h),

                // 3. Address (Optional)
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'ঠিকানা ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  controller: controller.addressController,
                  icon: Icons.location_on_outlined,
                  hint: 'মিরপুর-১০, ঢাকা',
                ),

                SizedBox(height: 14.h),

                // 4. Note (Optional)
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'নোট ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                          text: '(ইচ্ছা হলে)',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
                  controller: controller.noteController,
                  hint: 'প্রয়োজনীয় অন্য তথ্য',
                ),

                SizedBox(height: 14.h),

                // 5. Info Notice Box
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(12.w),
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
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'PDF পাঠানোর আগে নাম, মোবাইল ও ঠিকানা মিলিয়ে নেবেন।',
                          style: AppTextStyles.custom(
                            size: 12.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),

                // 6. Bottom Action Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'ক্লায়েন্ট সংরক্ষিত',
                      'ক্লায়েন্টের তথ্য সফলভাবে সেভ করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'ক্লায়েন্ট সেভ করুন',
                  icon: Icons.check_rounded,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
