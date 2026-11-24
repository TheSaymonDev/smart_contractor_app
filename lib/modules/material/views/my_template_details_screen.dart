import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_outlined_button.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';

class MyTemplateDetailsScreen extends StatelessWidget {
  const MyTemplateDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String templateTitle = '২ বাথরুমের পানির লাইন';
    const String templateSubtitle = 'পাইপ ফিটিংস • ৮টি মালামাল';

    final args = Get.arguments;
    if (args is Map<String, dynamic> && args.containsKey('title')) {
      templateTitle = args['title'].toString();
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppCustomAppBar(
        title: 'নিজের টেমপ্লেট',
        subtitle: templateTitle,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Brief Template Card
            _buildBriefTemplateCard(templateTitle, templateSubtitle),

            SizedBox(height: 14.h),

            // 2. Section Title: "সেভ করা মালামাল"
            Text(
              'সেভ করা মালামাল',
              style: AppTextStyles.mediumBlackBold,
            ),

            SizedBox(height: 10.h),

            // 3. Saved Materials List Card
            AppCard(
              child: Column(
                children: [
                  _buildMaterialItemRow('PPR পাইপ • ২০ মিমি', '১০০ ফুট'),
                  Divider(height: 16.h, color: AppColors.border),
                  _buildMaterialItemRow('এলবো • ২০ মিমি', '১০টি'),
                  Divider(height: 16.h, color: AppColors.border),
                  _buildMaterialItemRow('সকেট • ২০ মিমি', '১০টি'),
                  Divider(height: 16.h, color: AppColors.border),
                  _buildMaterialItemRow('বল ভালভ • ২০ মিমি', '৪টি'),
                  Divider(height: 16.h, color: AppColors.border),
                  Center(
                    child: InkWell(
                      onTap: () {
                        Get.snackbar('সকল মালামাল', '৮টি মালামালের সম্পূর্ণ তালিকা');
                      },
                      child: Text(
                        'সব ৮টি দেখুন',
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: AppColors.primary,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // 4. Action Buttons Row: "এডিট করুন" & "কপি বানান"
            Row(
              children: [
                // Edit Button
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.customTemplateCreateScreen);
                    },
                    text: 'এডিট করুন',
                    icon: Icons.edit_outlined,
                  ),
                ),

                SizedBox(width: 10.w),

                // Copy Button
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      Get.snackbar(
                        'কপি করা হয়েছে',
                        '$templateTitle এর একটি নতুন কপি তৈরি করা হয়েছে',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                      Get.toNamed(AppRoutes.customTemplateCreateScreen);
                    },
                    text: 'কপি বানান',
                    icon: Icons.copy_rounded,
                  ),
                ),
              ],
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
                      'ব্যবহার করলে কাজের জন্য আলাদা কপি হবে। নিজের সেভ করা টেমপ্লেট বদলাবে না।',
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

            // 6. Bottom Action Primary Button
            AppPrimaryButton(
              onPressed: () {
                Get.toNamed(AppRoutes.materialItemsListScreen);
              },
              text: 'এই তালিকা ব্যবহার করুন',
              icon: Icons.chevron_right_rounded,
            ),
          ],
        ),
      ),
    );
  }

  // Brief Template Card Helper
  Widget _buildBriefTemplateCard(String templateTitle, String templateSubtitle) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF4EBFF),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'আমার টেমপ্লেট',
                  style: AppTextStyles.custom(
                    size: 11.sp,
                    color: const Color(0xFF6941C6),
                    weight: FontWeight.w700,
                  ),
                ),
              ),
              Icon(
                Icons.layers_outlined,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            templateTitle,
            style: AppTextStyles.custom(
              size: 17.sp,
              color: AppColors.textPrimary,
              weight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            templateSubtitle,
            style: AppTextStyles.smallGrey,
          ),
        ],
      ),
    );
  }

  // Material Item Row Helper
  Widget _buildMaterialItemRow(String nameAndSize, String qty) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(nameAndSize, style: AppTextStyles.mediumGrey),
        Text(
          qty,
          style: AppTextStyles.custom(
            size: 15.sp,
            color: AppColors.textPrimary,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
