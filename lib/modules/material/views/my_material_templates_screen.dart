import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';

class MyMaterialTemplatesScreen extends StatelessWidget {
  const MyMaterialTemplatesScreen({super.key});

  final List<Map<String, String>> myTemplates = const [
    {
      'title': '২ বাথরুমের পানির লাইন',
      'items': '৮টি মালামাল',
      'date': '১৫ অক্টোবর ২০২৬',
      'category': 'পাইপ',
    },
    {
      'title': '৩ রুমের লাইট ও ফ্যান পয়েন্ট',
      'items': '১২টি মালামাল',
      'date': '১০ অক্টোবর ২০২৬',
      'category': 'বিদ্যুৎ',
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (!Get.isRegistered<MaterialWizardController>()) {
      Get.put(MaterialWizardController());
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'আমার টেমপ্লেট',
        subtitle: 'নিজের সেভ করা তালিকা',
      ),
      body: GetBuilder<MaterialWizardController>(
        builder: (controller) {
          final query =
              controller.myTemplatesSearchController.text.trim().toLowerCase();
          final filtered = myTemplates.where((tpl) {
            return query.isEmpty || tpl['title']!.toLowerCase().contains(query);
          }).toList();

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                  child: Column(
                    children: [
                      // Search Input
                      AppTextField(
                        controller: controller.myTemplatesSearchController,
                        hint: 'নিজের টেমপ্লেট খুঁজুন',
                        icon: Icons.search_rounded,
                      ),

                      SizedBox(height: 14.h),

                      // My Templates List
                      ...filtered.map((tpl) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: _buildMyTemplateCard(tpl),
                        );
                      }),
                    ],
                  ),
                ),
              ),

              // Bottom Action Button
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
                child: AppPrimaryButton(
                  onPressed: () {
                    Get.toNamed(AppRoutes.customTemplateCreateScreen);
                  },
                  text: 'নতুন টেমপ্লেট তৈরি করুন',
                  icon: Icons.add,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildMyTemplateCard(Map<String, String> tpl) {
    return AppCard(
      onTap: () {
        Get.toNamed(AppRoutes.myTemplateDetailsScreen, arguments: tpl);
      },
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.bookmark_outline_rounded,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tpl['title']!,
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '${tpl['items']} • ${tpl['date']}',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.textSecondary,
            size: 14.sp,
          ),
        ],
      ),
    );
  }
}
