import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';

class MaterialItemAddEditScreen extends StatefulWidget {
  const MaterialItemAddEditScreen({super.key});

  @override
  State<MaterialItemAddEditScreen> createState() =>
      _MaterialItemAddEditScreenState();
}

class _MaterialItemAddEditScreenState extends State<MaterialItemAddEditScreen> {
  final TextEditingController nameController =
      TextEditingController(text: 'PPR পাইপ');
  final TextEditingController sizeController =
      TextEditingController(text: '২০ মিমি');
  final TextEditingController brandController =
      TextEditingController(text: 'RFL');
  final TextEditingController quantityController =
      TextEditingController(text: '১০০');
  final TextEditingController priceController = TextEditingController();
  final TextEditingController noteController = TextEditingController();

  String selectedUnit = 'ফুট';

  final List<String> units = ['ফুট', 'টি', 'মিটার', 'কেজি', 'ব্যাগ', 'রোল'];

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is MaterialItemModel) {
      nameController.text = args.name;
      sizeController.text = args.size;
      brandController.text = args.brand;
      quantityController.text = args.quantity.toStringAsFixed(0);
      priceController.text =
          args.unitPrice > 0 ? args.unitPrice.toStringAsFixed(0) : '';
      noteController.text = args.note;
      selectedUnit = args.unit;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    sizeController.dispose();
    brandController.dispose();
    quantityController.dispose();
    priceController.dispose();
    noteController.dispose();
    super.dispose();
  }

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
              'মালামাল যোগ / এডিট',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'করিমের বাসা',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            AppTextField(
              hint: 'মালামালের নাম খুঁজুন',
              icon: Icons.search_rounded,
            ),

            SizedBox(height: 14.h),

            // 1. Material Name
            AppTextField(
              label: 'মালামালের নাম',
              controller: nameController,
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
                    controller: sizeController,
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
                    controller: brandController,
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
                    controller: quantityController,
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
                                      title: Text(u, style: AppTextStyles.mediumBlack),
                                      onTap: () {
                                        setState(() {
                                          selectedUnit = u;
                                        });
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
                            border: Border.all(color: AppColors.border, width: 1.5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(selectedUnit, style: AppTextStyles.mediumBlackBold),
                              Icon(Icons.keyboard_arrow_down_rounded,
                                  color: AppColors.textSecondary, size: 22.sp),
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
                    TextSpan(text: '(ইচ্ছা হলে)', style: AppTextStyles.smallGrey),
                  ],
                ),
              ),
              controller: priceController,
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
                    TextSpan(text: '(ইচ্ছা হলে)', style: AppTextStyles.smallGrey),
                  ],
                ),
              ),
              controller: noteController,
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
      ),
    );
  }
}
