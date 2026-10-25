import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialItemsEditScreen extends StatefulWidget {
  const MaterialItemsEditScreen({super.key});

  @override
  State<MaterialItemsEditScreen> createState() =>
      _MaterialItemsEditScreenState();
}

class _MaterialItemsEditScreenState extends State<MaterialItemsEditScreen> {
  final List<MaterialItemModel> items = [
    const MaterialItemModel(
      id: '1',
      name: 'PPR পাইপ',
      size: '২০ মিমি',
      brand: 'RFL',
      quantity: 100,
      unit: 'ফুট',
      unitPrice: 0,
    ),
    const MaterialItemModel(
      id: '2',
      name: 'এলবো',
      size: '২০ মিমি',
      brand: 'PPR',
      quantity: 10,
      unit: 'টি',
      unitPrice: 0,
    ),
    const MaterialItemModel(
      id: '3',
      name: 'সকেট',
      size: '২০ মিমি',
      brand: 'PPR',
      quantity: 10,
      unit: 'টি',
      unitPrice: 0,
    ),
    const MaterialItemModel(
      id: '4',
      name: 'বল ভালভ',
      size: '২০ মিমি',
      brand: 'PPR',
      quantity: 4,
      unit: 'টি',
      unitPrice: 350,
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
              'মালামালের তালিকা',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'করিমের বাসা • ৮টি মালামাল',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
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
                            'সাইজ ও পরিমাণ কাজ দেখে ঠিক করুন। দাম ইচ্ছা হলে দিন।',
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

                  // Material Items List
                  ...List.generate(items.length, (index) {
                    final item = items[index];
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: _buildItemCard(index + 1, item),
                    );
                  }),

                  SizedBox(height: 6.h),

                  // View More Link
                  Center(
                    child: Text(
                      'বাকি ৪টি মালামাল দেখুন',
                      style: AppTextStyles.custom(
                        size: 13.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Action Buttons Row: Add Item / Add Template
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.materialItemAddEditScreen);
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.primary, width: 1.5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add,
                                    color: AppColors.primary, size: 18.sp),
                                SizedBox(width: 6.w),
                                Text(
                                  'মালামাল যোগ',
                                  style: AppTextStyles.custom(
                                    size: 13.sp,
                                    color: AppColors.primary,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.toNamed(AppRoutes.sameMaterialsMergeScreen);
                          },
                          borderRadius: BorderRadius.circular(12.r),
                          child: Container(
                            height: 48.h,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                  color: AppColors.primary, width: 1.5),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.layers_outlined,
                                    color: AppColors.primary, size: 18.sp),
                                SizedBox(width: 6.w),
                                Text(
                                  'টেমপ্লেট যোগ',
                                  style: AppTextStyles.custom(
                                    size: 13.sp,
                                    color: AppColors.primary,
                                    weight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
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
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.bookmark_outline_rounded,
                            color: AppColors.primary, size: 18.sp),
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
  }

  Widget _buildItemCard(int index, MaterialItemModel item) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 22.w,
                    height: 22.w,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '$index',
                      style: AppTextStyles.custom(
                        size: 11.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(item.name, style: AppTextStyles.mediumBlackBold),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.materialItemAddEditScreen,
                      arguments: item);
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 18.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Text(
              '${item.size}${item.brand.isNotEmpty ? ' • ব্র্যান্ড: ${item.brand}' : ''}',
              style: AppTextStyles.smallGrey,
            ),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child:
                    _buildSubBox('পরিমাণ', item.quantity.toStringAsFixed(0)),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: _buildSubBox('একক', item.unit),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: _buildSubBox(
                  'একক দাম',
                  item.unitPrice > 0
                      ? '৳${item.unitPrice.toStringAsFixed(0)}'
                      : 'দাম দিন',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubBox(String label, String value) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF3F8),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label,
              style: AppTextStyles.custom(
                  size: 10.sp, color: AppColors.textSecondary)),
          SizedBox(height: 2.h),
          Text(value,
              style: AppTextStyles.custom(size: 12.sp, weight: FontWeight.w700)),
        ],
      ),
    );
  }
}
