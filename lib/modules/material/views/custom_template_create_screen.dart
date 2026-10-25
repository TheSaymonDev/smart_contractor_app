import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class CustomTemplateCreateScreen extends StatefulWidget {
  const CustomTemplateCreateScreen({super.key});

  @override
  State<CustomTemplateCreateScreen> createState() =>
      _CustomTemplateCreateScreenState();
}

class _CustomTemplateCreateScreenState
    extends State<CustomTemplateCreateScreen> {
  final TextEditingController templateNameController =
      TextEditingController(text: '২ বাথরুমের পানির লাইন');
  String selectedWorkType = 'পাইপ ফিটিংস';

  final List<String> workTypes = [
    'পাইপ ফিটিংস',
    'ইলেক্ট্রিক্যাল',
    'প্লাম্বিং',
    'স্যানিটারি',
    'কনস্ট্রাকশন',
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
              'নিজের টেমপ্লেট',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'তালিকাটি বারবার ব্যবহার করুন',
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
            // 1. Template Name
            AppTextField(
              label: 'টেমপ্লেটের নাম',
              controller: templateNameController,
              icon: Icons.layers_outlined,
              hint: 'যেমন: ২ বাথরুমের পানির লাইন',
            ),

            SizedBox(height: 14.h),

            // 2. Work Type Dropdown
            Text('কাজের ধরন', style: AppTextStyles.mediumBlackBold),
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
                        children: workTypes.map((type) {
                          return ListTile(
                            title:
                                Text(type, style: AppTextStyles.mediumBlack),
                            onTap: () {
                              setState(() {
                                selectedWorkType = type;
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
                height: 52.h,
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.border, width: 1.5),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary,
                      size: 22.sp,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        selectedWorkType,
                        style: AppTextStyles.mediumBlackBold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16.h),

            // 3. Template Items List
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('টেমপ্লেটের মালামাল',
                    style: AppTextStyles.mediumBlackBold),
                Text(
                  '৮টি',
                  style: AppTextStyles.custom(
                    size: 13.sp,
                    color: AppColors.primary,
                    weight: FontWeight.w700,
                  ),
                ),
              ],
            ),

            SizedBox(height: 8.h),

            // Item Card 1
            _buildTemplateItemCard('1', 'PPR পাইপ', '২০ মিমি • ব্র্যান্ড ইচ্ছা হলে',
                '১০০', 'ফুট', 'দাম দিন'),
            SizedBox(height: 8.h),

            // Item Card 2
            _buildTemplateItemCard('2', 'এলবো', '২০ মিমি', '১০', 'টি', 'দাম দিন'),

            SizedBox(height: 12.h),

            // Add Material Item Button
            InkWell(
              onTap: () {
                Get.toNamed(AppRoutes.materialItemAddEditScreen);
              },
              borderRadius: BorderRadius.circular(12.r),
              child: Container(
                height: 48.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: AppColors.border, width: 1.5),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: AppColors.primary, size: 20.sp),
                    SizedBox(width: 6.w),
                    Text(
                      'মালামাল যোগ করুন',
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
                      'নতুন টেমপ্লেট আলাদা সেভ হবে। অন্য কাজের তালিকা বদলাবে না।',
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
                  'টেমপ্লেট সংরক্ষিত',
                  'নিজের টেমপ্লেট সফলভাবে সেভ করা হয়েছে',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
                Future.delayed(const Duration(milliseconds: 600), () {
                  Get.back();
                });
              },
              text: 'টেমপ্লেট সেভ করুন',
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  // Template Item Card Helper
  Widget _buildTemplateItemCard(String index, String title, String subtitle,
      String qty, String unit, String priceText) {
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
                      index,
                      style: AppTextStyles.custom(
                        size: 11.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Text(title, style: AppTextStyles.mediumBlackBold),
                ],
              ),
              Icon(
                Icons.edit_outlined,
                color: AppColors.primary,
                size: 18.sp,
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Padding(
            padding: EdgeInsets.only(left: 30.w),
            child: Text(subtitle, style: AppTextStyles.smallGrey),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: _buildSubValBox('পরিমাণ', qty),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: _buildSubValBox('একক', unit),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: _buildSubValBox('একক দাম', priceText),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubValBox(String label, String value) {
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
              style:
                  AppTextStyles.custom(size: 10.sp, color: AppColors.textSecondary)),
          SizedBox(height: 2.h),
          Text(value, style: AppTextStyles.custom(size: 12.sp, weight: FontWeight.w700)),
        ],
      ),
    );
  }
}
