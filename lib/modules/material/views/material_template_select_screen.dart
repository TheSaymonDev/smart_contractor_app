import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';
import 'package:smart_contractor_app/modules/material/data/default_material_templates.dart';
import 'package:smart_contractor_app/modules/material/models/material_category_model.dart';
import 'package:smart_contractor_app/modules/material/models/material_template_model.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialTemplateSelectScreen extends StatelessWidget {
  const MaterialTemplateSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MaterialWizardController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'মালামালের টেমপ্লেট',
        subtitle: 'কোন ধরনের কাজ করবেন?',
      ),
      body: GetBuilder<MaterialWizardController>(
        builder: (controller) {
          final query =
              controller.categoriesSearchController.text.trim().toLowerCase();
          final filteredCategories = defaultCategories.where((cat) {
            return query.isEmpty ||
                cat.title.toLowerCase().contains(query) ||
                cat.englishTitle.toLowerCase().contains(query);
          }).toList();

          return Column(
            children: [
              const MaterialWizardStepper(currentStep: 1),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                  child: Column(
                    children: [
                      _buildDirectCreateCard(),
                      SizedBox(height: 14.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'কাজের বিভাগসমূহ (সাব-ক্যাটাগরি দেখুন)',
                          style: AppTextStyles.custom(
                            size: 16.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.h),
                      ...filteredCategories.map(
                        (category) => Padding(
                          padding: EdgeInsets.only(bottom: 10.h),
                          child: _buildExpandableCategoryCard(
                              context, controller, category),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildExpandableCategoryCard(BuildContext context,
      MaterialWizardController controller, MaterialCategoryModel category) {
    final templates = defaultCategoryTemplates[category.title] ?? [];

    return AppCard(
      padding: EdgeInsets.zero,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
          childrenPadding: EdgeInsets.fromLTRB(14.w, 0, 14.w, 12.h),
          leading: Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              category.icon,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),
          title: Text(
            category.title,
            style: AppTextStyles.custom(
              size: 16.sp,
              color: AppColors.textPrimary,
              weight: FontWeight.w700,
            ),
          ),
          subtitle: Text(
            '${category.englishTitle} • ${category.templateCountText}',
            style: AppTextStyles.smallGrey,
          ),
          children: [
            Divider(height: 12.h, color: AppColors.border),
            ...templates.map((tpl) => _buildSubTemplateItem(controller, tpl)),
          ],
        ),
      ),
    );
  }

  Widget _buildSubTemplateItem(
      MaterialWizardController controller, MaterialTemplateModel template) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: InkWell(
        onTap: () {
          controller.selectTemplate(template);
          Get.toNamed(AppRoutes.materialItemsListScreen);
        },
        borderRadius: BorderRadius.circular(10.r),
        child: Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF3F8),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      template.title,
                      style: AppTextStyles.custom(
                        size: 14.sp,
                        color: AppColors.textPrimary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      template.itemCountText,
                      style: AppTextStyles.custom(
                        size: 11.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                template.description,
                style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDirectCreateCard() {
    return AppCard(
      child: InkWell(
        onTap: () {
          Get.toNamed(AppRoutes.directMaterialListCreateScreen);
        },
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Icon(
                Icons.add_circle_outline_rounded,
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
                    'সরাসরি নতুন তালিকা তৈরি করুন',
                    style: AppTextStyles.custom(
                      size: 15.sp,
                      color: AppColors.primary,
                      weight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'টেমপ্লেট না বেছে নিজের মতো মালামাল লিখুন',
                    style: AppTextStyles.smallGrey,
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primary,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
