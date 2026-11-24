import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/more/controllers/more_controller.dart';

class GeneratedPdfItem {
  final String id;
  final String title;
  final String subtitle;
  final String category; // মালামাল, বিল, রসিদ, কর্মী
  final Color badgeColor;
  final Color badgeBgColor;

  const GeneratedPdfItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.badgeColor,
    required this.badgeBgColor,
  });
}

class GeneratedPdfListScreen extends StatelessWidget {
  const GeneratedPdfListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MoreController());

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'তৈরি করা PDF',
        subtitle: 'আগের PDF আবার দেখুন ও পাঠান',
      ),
      body: GetBuilder<MoreController>(
        builder: (controller) {
          final items = controller.filteredPdfItems;

          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Search Field
                _buildSearchBar(controller),

                SizedBox(height: 12.h),

                // 2. Filter Tabs Bar
                _buildFilterTabs(controller),

                SizedBox(height: 12.h),

                // 3. PDF Cards List
                ...items.map(
                  (pdf) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: _buildPdfCard(pdf),
                  ),
                ),

                SizedBox(height: 6.h),

                // 4. Info Notice Box
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
                          'প্রতিটি PDF তৈরির সময়কার কপি। তালিকা বদলালে নতুন PDF তৈরি করুন।',
                          style: AppTextStyles.custom(
                            size: 12.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Search Input Bar Helper
  Widget _buildSearchBar(MoreController controller) {
    return AppTextField(
      controller: controller.pdfSearchController,
      hint: 'কাজ, কর্মী বা PDF খুঁজুন',
      icon: Icons.search_rounded,
    );
  }

  // Filter Tabs Bar Helper
  Widget _buildFilterTabs(MoreController controller) {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(controller.filterLabels.length, (index) {
          final isSelected = controller.selectedFilterIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () => controller.setFilterIndex(index),
              borderRadius: BorderRadius.circular(9.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 38.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Text(
                  controller.filterLabels[index],
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    weight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // PDF Card Helper
  Widget _buildPdfCard(GeneratedPdfItem pdf) {
    return AppCard(
      onTap: () {
        if (pdf.category == 'বিল') {
          Get.toNamed(AppRoutes.finalBillPdfPreviewScreen);
        } else if (pdf.category == 'রসিদ') {
          Get.toNamed(AppRoutes.paymentReceiptPdfPreviewScreen);
        } else if (pdf.category == 'কর্মী') {
          Get.toNamed(AppRoutes.workerLedgerPdfPreviewScreen);
        } else {
          Get.toNamed(AppRoutes.materialPdfPreviewScreen);
        }
      },
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.description_outlined,
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
                  pdf.title,
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(pdf.subtitle, style: AppTextStyles.smallGrey),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: pdf.badgeBgColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'PDF',
              style: AppTextStyles.custom(
                size: 11.sp,
                color: pdf.badgeColor,
                weight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
