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
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';
import 'package:smart_contractor_app/modules/material/data/default_material_templates.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialItemsListScreen extends StatelessWidget {
  const MaterialItemsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<MaterialWizardController>()
        ? Get.find<MaterialWizardController>()
        : Get.put(MaterialWizardController());

    // Fallback template items if opened directly without selecting in Step 1
    if (controller.selectedItems.isEmpty &&
        defaultCategoryTemplates['প্লাম্বিং ও পাইপ ফিটিংস'] != null) {
      final fallbackTpl =
          defaultCategoryTemplates['প্লাম্বিং ও পাইপ ফিটিংস']!.first;
      controller.selectedTemplate = fallbackTpl;
      controller.selectedItems = List.from(fallbackTpl.items);

      // Add a sample price and note to demonstration items
      if (controller.selectedItems.isNotEmpty) {
        controller.selectedItems[0] = controller.selectedItems[0].copyWith(
          unitPrice: 350,
          note: 'ব্র্যান্ডের অরিজিনাল মালের গ্যারান্টি যাচাই করুন',
        );
      }
    }

    return GetBuilder<MaterialWizardController>(
      builder: (controller) {
        final items = controller.selectedItems;
        final templateTitle =
            controller.selectedTemplate?.title ?? 'মালামালের তালিকা';

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppCustomAppBar(
            title: 'মালামালের তালিকা',
            subtitle: '$templateTitle • ${items.length}টি মালামাল',
          ),
          body: Column(
            children: [
              // Step 2 Stepper
              const MaterialWizardStepper(currentStep: 2),

              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
                  child: Column(
                    children: [
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
                                'সাইজ, পরিমাণ ও ব্র্যান্ড কাজ দেখে ঠিক করুন। দাম ইচ্ছা হলে দিন।',
                                style: AppTextStyles.custom(
                                  size: 12.sp,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 12.h),

                      // Compact Table Card Container
                      AppCard(
                        padding: EdgeInsets.zero,
                        child: Column(
                          children: [
                            // Table Header Row (Blue Bar)
                            _buildTableHeader(),

                            // Table Data Rows
                            if (items.isEmpty)
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 24.h),
                                child: Text(
                                  'কোনো মালামাল যোগ করা হয়নি। নিচে "মালামাল যোগ" চাপুন।',
                                  style: AppTextStyles.smallGrey,
                                ),
                              )
                            else
                              ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: items.length,
                                separatorBuilder: (context, index) =>
                                    Divider(height: 1, color: AppColors.border),
                                itemBuilder: (context, index) {
                                  return _buildTableRow(
                                      controller, index + 1, items[index], index);
                                },
                              ),
                          ],
                        ),
                      ),

                      SizedBox(height: 10.h),

                      // Total Items Summary Box
                      _buildTotalItemsSummaryBox(items.length),

                      SizedBox(height: 16.h),

                      // Action Buttons Row: Add Item / Add Template
                      Row(
                        children: [
                          Expanded(
                            child: AppOutlinedButton(
                              onPressed: () {
                                Get.toNamed(AppRoutes.materialItemAddEditScreen);
                              },
                              text: 'মালামাল যোগ',
                              icon: Icons.add,
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: AppOutlinedButton(
                              onPressed: () {
                                _showAddTemplateBottomSheet(context, controller);
                              },
                              text: 'টেমপ্লেট যোগ',
                              icon: Icons.layers_outlined,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 14.h),

                      // Save as My Template Link
                      InkWell(
                        onTap: () {
                          Get.snackbar(
                            'টেমপ্লেট সেভ',
                            'নিজের টেমপ্লেট হিসেবে সেভ করা হয়েছে',
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: AppColors.primary,
                            colorText: Colors.white,
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_outline_rounded,
                              color: AppColors.primary,
                              size: 18.sp,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              'নিজের টেমপ্লেট হিসেবে সেভ',
                              style: AppTextStyles.custom(
                                size: 13.sp,
                                color: AppColors.primary,
                                weight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Bottom Action Button -> Step 3
                      AppPrimaryButton(
                        onPressed: () {
                          controller.setStep(3);
                          Get.toNamed(AppRoutes.materialPdfInfoScreen);
                        },
                        text: 'সেভ করে পরের ধাপ',
                        icon: Icons.chevron_right_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // BottomSheet to pick 2nd template and merge items
  void _showAddTemplateBottomSheet(
      BuildContext context, MaterialWizardController controller) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.75,
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('আরেকটি টেমপ্লেট যোগ করুন',
                      style: AppTextStyles.mediumBlackBold),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Text(
                '২৩টি ডিফল্ট টেমপ্লেট থেকে যেকোনো একটি বাছুন। একই মালামাল থাকলে পরিমাণ নিজে থেকে যোগ হয়ে যাবে।',
                style: AppTextStyles.smallGrey,
              ),
              SizedBox(height: 12.h),
              Expanded(
                child: ListView(
                  children: defaultCategoryTemplates.entries.map((entry) {
                    final categoryName = entry.key;
                    final templates = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            categoryName,
                            style: AppTextStyles.custom(
                              size: 14.sp,
                              color: AppColors.primary,
                              weight: FontWeight.w700,
                            ),
                          ),
                        ),
                        ...templates.map((tpl) => Padding(
                              padding: EdgeInsets.only(bottom: 6.h),
                              child: AppCard(
                                onTap: () {
                                  controller.mergeTemplate(tpl);
                                  Get.back();
                                  Get.snackbar(
                                    'টেমপ্লেট যুক্ত হয়েছে',
                                    '${tpl.title}-এর মালামাল বর্তমান তালিকায় যোগ করা হয়েছে',
                                    snackPosition: SnackPosition.BOTTOM,
                                    backgroundColor: AppColors.primary,
                                    colorText: Colors.white,
                                  );
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(tpl.title,
                                              style: AppTextStyles
                                                  .mediumBlackBold),
                                          SizedBox(height: 2.h),
                                          Text(tpl.description,
                                              style: AppTextStyles.smallGrey),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 8.w, vertical: 4.h),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryLight,
                                        borderRadius:
                                            BorderRadius.circular(6.r),
                                      ),
                                      child: Text(
                                        '+ যোগ করুন',
                                        style: AppTextStyles.custom(
                                          size: 11.sp,
                                          color: AppColors.primary,
                                          weight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Table Header Row Helper
  Widget _buildTableHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.r)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 32.w,
            child: Text(
              '#',
              textAlign: TextAlign.center,
              style: AppTextStyles.custom(
                size: 13.sp,
                color: Colors.white,
                weight: FontWeight.w700,
              ),
            ),
          ),
          Expanded(
            child: Text(
              'মালামাল',
              style: AppTextStyles.custom(
                size: 12.sp,
                color: Colors.white,
                weight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 72.w,
            child: Text(
              'পরিমাণ',
              textAlign: TextAlign.center,
              style: AppTextStyles.custom(
                size: 12.sp,
                color: Colors.white,
                weight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            width: 52.w,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                'অ্যাকশন',
                textAlign: TextAlign.center,
                maxLines: 1,
                softWrap: false,
                style: AppTextStyles.custom(
                  size: 12.sp,
                  color: Colors.white,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Table Single Data Row Helper
  Widget _buildTableRow(MaterialWizardController controller, int num,
      MaterialItemModel item, int index) {
    final String qtyWithUnit =
        '${item.quantity % 1 == 0 ? item.quantity.toInt() : item.quantity} ${item.unit}';

    final String specBrandText =
        '${item.size.isNotEmpty ? item.size : 'সাধারণ'}${item.brand.isNotEmpty ? ' • ব্র্যান্ড: ${item.brand}' : ''}';

    final bool hasPriceOrNote = item.unitPrice > 0 || item.note.isNotEmpty;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 1. Serial Badge Number
          SizedBox(
            width: 32.w,
            child: Center(
              child: Container(
                width: 24.w,
                height: 24.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  '$num',
                  style: AppTextStyles.custom(
                    size: 10.sp,
                    color: AppColors.primary,
                    weight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ),

          // 2. Material Details Column (Name, Spec/Brand, Price/Note)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Line 1: Material Name
                Text(
                  item.name,
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2.h),

                // Line 2: Size/Spec & Brand
                Text(
                  specBrandText,
                  style: AppTextStyles.custom(
                    size: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                // Line 3: Price & Note Badge (If entered)
                if (hasPriceOrNote) ...[
                  SizedBox(height: 4.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3F8),
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                          color: AppColors.primary.withValues(alpha: 0.2)),
                    ),
                    child: Text(
                      [
                        if (item.unitPrice > 0)
                          'দাম: ৳${item.unitPrice.toStringAsFixed(0)}${item.totalPrice > 0 ? ' (মোট ৳${item.totalPrice.toStringAsFixed(0)})' : ''}',
                        if (item.note.isNotEmpty) 'নোট: ${item.note}',
                      ].join(' • '),
                      style: AppTextStyles.custom(
                        size: 10.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ],
            ),
          ),

          // 3. Combined Quantity + Unit
          SizedBox(
            width: 72.w,
            child: Text(
              qtyWithUnit,
              textAlign: TextAlign.center,
              style: AppTextStyles.custom(
                size: 12.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
          ),

          // 4. Action Popup Menu Button (3-dots)
          SizedBox(
            width: 52.w,
            child: PopupMenuButton<String>(
              icon: Icon(
                Icons.more_vert_rounded,
                color: AppColors.textSecondary,
                size: 20.sp,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
              onSelected: (value) {
                if (value == 'edit') {
                  Get.toNamed(
                    AppRoutes.materialItemAddEditScreen,
                    arguments: {'item': item, 'index': index},
                  );
                } else if (value == 'delete') {
                  controller.removeItem(index);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit_outlined,
                          color: AppColors.primary, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text('এডিট করুন', style: AppTextStyles.mediumBlack),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete_outline_rounded,
                          color: AppColors.error, size: 18.sp),
                      SizedBox(width: 8.w),
                      Text('ডেলিট করুন',
                          style: AppTextStyles.custom(
                              size: 13.sp, color: AppColors.error)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Total Items Summary Box Helper
  Widget _buildTotalItemsSummaryBox(int totalCount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Icon(
            Icons.layers_outlined,
            color: AppColors.primary,
            size: 20.sp,
          ),
          SizedBox(width: 10.w),
          Text(
            'মোট মালামাল: $totalCountটি',
            style: AppTextStyles.custom(
              size: 14.sp,
              color: AppColors.textPrimary,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
