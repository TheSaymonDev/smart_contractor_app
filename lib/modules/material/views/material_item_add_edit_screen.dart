import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';

class MaterialItemAddEditScreen extends StatelessWidget {
  const MaterialItemAddEditScreen({super.key});

  final List<String> units = const ['ফুট', 'টি', 'মিটার', 'কেজি', 'ব্যাগ', 'রোল'];

  @override
  Widget build(BuildContext context) {
    final controller = Get.isRegistered<MaterialWizardController>()
        ? Get.find<MaterialWizardController>()
        : Get.put(MaterialWizardController());

    final args = Get.arguments;
    if (args is MaterialItemModel) {
      controller.itemNameController.text = args.name;
      controller.itemSizeController.text = args.size;
      controller.itemBrandController.text = args.brand;
      controller.itemQuantityController.text = args.quantity.toStringAsFixed(0);
      controller.itemPriceController.text =
          args.unitPrice > 0 ? args.unitPrice.toStringAsFixed(0) : '';
      controller.itemNoteController.text = args.note;
      controller.itemUnit = args.unit;
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'মালামাল যোগ / এডিট',
        subtitle: 'করিমের বাসা',
      ),
      body: GetBuilder<MaterialWizardController>(
        builder: (controller) {
          return SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // 1. Material Name
                AppTextField(
                  label: 'মালামালের নাম',
                  controller: controller.itemNameController,
                  icon: Icons.layers_outlined,
                  hint: 'PPR পাইপ',
                ),

                SizedBox(height: 14.h),

                // 2. Size & Brand Row
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'সাইজ / মাপ',
                        controller: controller.itemSizeController,
                        hint: '২০ মিমি',
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: AppTextField(
                        labelWidget: RichText(
                          text: TextSpan(
                            text: 'ব্র্যান্ড ',
                            style: AppTextStyles.mediumBlackBold,
                            children: [
                              TextSpan(
                                text: '(ইচ্ছা হলে)',
                                style: AppTextStyles.smallGrey,
                              ),
                            ],
                          ),
                        ),
                        controller: controller.itemBrandController,
                        hint: 'RFL',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // 3. Quantity & Unit Row
                Row(
                  children: [
                    Expanded(
                      child: AppTextField(
                        label: 'পরিমাণ',
                        controller: controller.itemQuantityController,
                        hint: '১০০',
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('একক', style: AppTextStyles.mediumBlackBold),
                          SizedBox(height: 6.h),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Padding(
                                    padding: EdgeInsets.all(16.w),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: units.map((u) {
                                        return ListTile(
                                          title: Text(u,
                                              style: AppTextStyles.mediumBlack),
                                          onTap: () {
                                            controller.setItemUnit(u);
                                            Get.back();
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  );
                                },
                              );
                            },
                            borderRadius: BorderRadius.circular(12.r),
                            child: Container(
                              height: 48.h,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.r),
                                border: Border.all(
                                    color: AppColors.border, width: 1.5),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(controller.itemUnit,
                                      style: AppTextStyles.mediumBlackBold),
                                  Icon(Icons.keyboard_arrow_down_rounded,
                                      color: AppColors.textSecondary,
                                      size: 22.sp),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 14.h),

                // 4. Unit Price
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'একক দাম ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                            text: '(ইচ্ছা হলে)', style: AppTextStyles.smallGrey),
                      ],
                    ),
                  ),
                  controller: controller.itemPriceController,
                  icon: Icons.payments_outlined,
                  hint: 'এক ফুট / এক পিসের দাম',
                  keyboardType: TextInputType.number,
                ),

                SizedBox(height: 14.h),

                // 5. Note
                AppTextField(
                  labelWidget: RichText(
                    text: TextSpan(
                      text: 'নোট ',
                      style: AppTextStyles.mediumBlackBold,
                      children: [
                        TextSpan(
                            text: '(ইচ্ছা হলে)', style: AppTextStyles.smallGrey),
                      ],
                    ),
                  ),
                  controller: controller.itemNoteController,
                  hint: 'দোকানদারকে কিছু বলতে চাইলে',
                ),

                SizedBox(height: 14.h),

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
                          'নাম খুঁজে না পেলেও নিজের মতো লিখে সেভ করুন।',
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

                // Bottom Action Button
                AppPrimaryButton(
                  onPressed: () {
                    Get.snackbar(
                      'সংরক্ষিত হয়েছে',
                      'মালামাল তালিকায় যুক্ত করা হয়েছে',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: AppColors.primary,
                      colorText: Colors.white,
                    );
                    Future.delayed(const Duration(milliseconds: 600), () {
                      Get.back();
                    });
                  },
                  text: 'তালিকায় রাখুন',
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
