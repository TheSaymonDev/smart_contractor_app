import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';
import 'package:smart_contractor_app/modules/material/models/material_category_model.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialTemplateCategoriesScreen extends StatefulWidget {
  const MaterialTemplateCategoriesScreen({super.key});

  @override
  State<MaterialTemplateCategoriesScreen> createState() =>
      _MaterialTemplateCategoriesScreenState();
}

class _MaterialTemplateCategoriesScreenState
    extends State<MaterialTemplateCategoriesScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<MaterialCategoryModel> categories = const [
    MaterialCategoryModel(
      id: 'electrical',
      title: 'ইলেক্ট্রিক্যাল',
      englishTitle: 'Electrical',
      countText: '5টি টেমপ্লেট',
      icon: Icons.bolt_rounded,
      iconBgColor: Color(0xFFFFF4E5),
      iconColor: Color(0xFFE66A00),
    ),
    MaterialCategoryModel(
      id: 'plumbing',
      title: 'প্লাম্বিং',
      englishTitle: 'Plumbing',
      countText: '7টি টেমপ্লেট',
      icon: Icons.water_drop_outlined,
      iconBgColor: AppColors.primaryLight,
      iconColor: AppColors.primary,
    ),
    MaterialCategoryModel(
      id: 'pipe_fittings',
      title: 'পাইপ ফিটিংস',
      englishTitle: 'Pipe Fittings',
      countText: '3টি টেমপ্লেট',
      icon: Icons.plumbing_outlined,
      iconBgColor: Color(0xFFE8F8F0),
      iconColor: Color(0xFF079455),
    ),
    MaterialCategoryModel(
      id: 'sanitary',
      title: 'স্যানিটারি',
      englishTitle: 'Sanitary',
      countText: '3টি টেমপ্লেট',
      icon: Icons.bathtub_outlined,
      iconBgColor: Color(0xFFF4EBFF),
      iconColor: Color(0xFF6941C6),
    ),
    MaterialCategoryModel(
      id: 'construction',
      title: 'কনস্ট্রাকশন',
      englishTitle: 'Construction',
      countText: '5টি টেমপ্লেট',
      icon: Icons.apartment,
      iconBgColor: Color(0xFFE8F8F0),
      iconColor: Color(0xFF079455),
    ),
    MaterialCategoryModel(
      id: 'my_templates',
      title: 'আমার টেমপ্লেট',
      englishTitle: 'My Saved Templates',
      countText: 'নিজের সেভ করা তালিকা',
      icon: Icons.layers_outlined,
      iconBgColor: AppColors.primaryLight,
      iconColor: AppColors.primary,
    ),
  ];

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
              'মালামালের টেমপ্লেট',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'কোন ধরনের কাজ করবেন?',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Step 1 Stepper
          const MaterialWizardStepper(currentStep: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
              child: Column(
                children: [
                  // Search Bar
                  AppTextField(
                    controller: searchController,
                    hint: 'টেমপ্লেট খুঁজুন',
                    icon: Icons.search_rounded,
                  ),

                  SizedBox(height: 14.h),

                  // Category Cards List
                  ...categories.map((cat) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: AppCard(
                        onTap: () {
                          if (cat.id == 'my_templates') {
                            Get.toNamed(AppRoutes.myMaterialTemplatesScreen);
                          } else {
                            if (Get.isRegistered<MaterialWizardController>()) {
                              Get.find<MaterialWizardController>()
                                  .setSelectedCategory(cat.title);
                            }
                            Get.toNamed(
                              AppRoutes.materialTemplateListScreen,
                              arguments: cat,
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: cat.iconBgColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                cat.icon,
                                color: cat.iconColor,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cat.title,
                                    style: AppTextStyles.mediumBlackBold,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    '${cat.englishTitle} • ${cat.countText}',
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
                    );
                  }),

                  SizedBox(height: 16.h),

                  // Start Empty List Button
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.directMaterialListCreateScreen);
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: AppColors.primary, width: 1.5),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,
                              color: AppColors.primary, size: 20.sp),
                          SizedBox(width: 6.w),
                          Text(
                            'খালি তালিকা দিয়ে শুরু',
                            style: AppTextStyles.custom(
                              size: 14.sp,
                              color: AppColors.primary,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
