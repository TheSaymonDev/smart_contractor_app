import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class MyMaterialTemplatesScreen extends StatefulWidget {
  const MyMaterialTemplatesScreen({super.key});

  @override
  State<MyMaterialTemplatesScreen> createState() =>
      _MyMaterialTemplatesScreenState();
}

class _MyMaterialTemplatesScreenState extends State<MyMaterialTemplatesScreen> {
  final TextEditingController searchController = TextEditingController();
  int selectedFilterIndex = 0;

  final List<String> filterLabels = ['সব', 'পাইপ', 'বিদ্যুৎ', 'অন্যান্য'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            color: AppColors.primary,
            size: 24.sp,
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'আমার টেমপ্লেট',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'নিজের সেভ করা তালিকা',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Filter Tabs
                  Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.border),
                    ),
                    child: Row(
                      children: List.generate(filterLabels.length, (index) {
                        final isSelected = selectedFilterIndex == index;
                        return Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedFilterIndex = index;
                              });
                            },
                            borderRadius: BorderRadius.circular(9.r),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              height: 38.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(9.r),
                              ),
                              child: Text(
                                filterLabels[index],
                                style: AppTextStyles.custom(
                                  size: 12.sp,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  weight: isSelected
                                      ? FontWeight.w700
                                      : FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Search Input
                  AppTextField(
                    controller: searchController,
                    hint: 'নিজের টেমপ্লেট খুঁজুন',
                    icon: Icons.search_rounded,
                  ),

                  SizedBox(height: 12.h),

                  // Custom Saved Template Card 1
                  AppCard(
                    onTap: () {
                      Get.toNamed(AppRoutes.myTemplateDetailsScreen);
                    },
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
                            Icons.plumbing_outlined,
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
                                '২ বাথরুমের পানির লাইন',
                                style: AppTextStyles.mediumBlackBold,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'পাইপ ফিটিং • ১২টি মালামাল',
                                style: AppTextStyles.smallGrey,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.textSecondary,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // Custom Saved Template Card 2
                  AppCard(
                    onTap: () {
                      Get.toNamed(AppRoutes.myTemplateDetailsScreen);
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 44.w,
                          height: 44.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFF4E5),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(
                            Icons.bolt_rounded,
                            color: const Color(0xFFE66A00),
                            size: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'ছোট দোকানের ওয়্যারিং',
                                style: AppTextStyles.mediumBlackBold,
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'ইলেক্ট্রিক্যাল • ৯টি মালামাল',
                                style: AppTextStyles.smallGrey,
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.chevron_right_rounded,
                          color: AppColors.textSecondary,
                          size: 22.sp,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Info Notice Box
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
                            'সেভ করা টেমপ্লেট খুলে এডিট বা কপি করতে পারবেন।',
                            style: AppTextStyles.custom(
                              size: 12.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // How to Use Guide Card
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('যেভাবে ব্যবহার করবেন',
                            style: AppTextStyles.mediumBlackBold),
                        SizedBox(height: 4.h),
                        Text(
                          'নিজের টেমপ্লেট বাছুন ➔ কাজ অনুযায়ী তালিকা বদলান ➔ PDF দিন।',
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),
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
              text: 'নতুন টেমপ্লেট বানান',
              icon: Icons.add,
            ),
          ),
        ],
      ),
    );
  }
}
