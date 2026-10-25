import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';

class SameMaterialsMergeScreen extends StatefulWidget {
  const SameMaterialsMergeScreen({super.key});

  @override
  State<SameMaterialsMergeScreen> createState() =>
      _SameMaterialsMergeScreenState();
}

class _SameMaterialsMergeScreenState extends State<SameMaterialsMergeScreen> {
  bool mergeItem1 = true;
  bool mergeItem2 = true;

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
              'একই মালামাল পাওয়া গেছে',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'দুই টেমপ্লেট একসাথে যোগ করার সময়',
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
            // Top Yellow Warning Notice Box
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4E5),
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: const Color(0xFFFFE0B2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.info_outline_rounded,
                    color: const Color(0xFFE66A00),
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'নাম, সাইজ ও একক একই হলে এক করতে পারেন। আপনার সিদ্ধান্ত ছাড়া কিছু এক হবে না।',
                      style: AppTextStyles.custom(
                        size: 12.sp,
                        color: const Color(0xFFE66A00),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 14.h),

            // Duplicate Item 1 Card
            _buildMergeCard(
              title: 'এলবো • ২০ মিমি',
              oldQty: '১০টি',
              newQty: '৪টি',
              totalQty: '১৪টি',
              isMerged: mergeItem1,
              onMergeTap: () => setState(() => mergeItem1 = true),
              onSeparateTap: () => setState(() => mergeItem1 = false),
            ),

            SizedBox(height: 12.h),

            // Duplicate Item 2 Card
            _buildMergeCard(
              title: 'সকেট • ২০ মিমি',
              oldQty: '১০টি',
              newQty: '৬টি',
              totalQty: '১৬টি',
              isMerged: mergeItem2,
              onMergeTap: () => setState(() => mergeItem2 = true),
              onSeparateTap: () => setState(() => mergeItem2 = false),
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
                      'দাম বা ব্র্যান্ড আলাদা হলে আগে দেখে নিন।',
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
                  'সিদ্ধান্ত সেভ',
                  'মালামাল মার্জ করার সিদ্ধান্ত সংরক্ষণ করা হয়েছে',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: AppColors.primary,
                  colorText: Colors.white,
                );
                Future.delayed(const Duration(milliseconds: 600), () {
                  Get.back();
                });
              },
              text: 'সিদ্ধান্ত সেভ করুন',
              icon: Icons.check_rounded,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMergeCard({
    required String title,
    required String oldQty,
    required String newQty,
    required String totalQty,
    required bool isMerged,
    required VoidCallback onMergeTap,
    required VoidCallback onSeparateTap,
  }) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.custom(size: 16.sp, weight: FontWeight.w700)),
          SizedBox(height: 10.h),
          _buildRow('আগের তালিকা', oldQty),
          Divider(height: 16.h, color: AppColors.border),
          _buildRow('নতুন টেমপ্লেট', newQty),
          Divider(height: 16.h, color: AppColors.border),
          _buildRow('এক করলে মোট', totalQty, isTotal: true),
          SizedBox(height: 12.h),

          // Option Toggle
          Container(
            height: 44.h,
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF3F8),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: onMergeTap,
                    borderRadius: BorderRadius.circular(8.r),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isMerged ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'এক করে দিন',
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: isMerged ? Colors.white : AppColors.textSecondary,
                          weight: isMerged ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: onSeparateTap,
                    borderRadius: BorderRadius.circular(8.r),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: !isMerged ? AppColors.primary : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'আলাদা রাখুন',
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: !isMerged ? Colors.white : AppColors.textSecondary,
                          weight: !isMerged ? FontWeight.w700 : FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.mediumGrey),
        Text(
          value,
          style: AppTextStyles.custom(
            size: 15.sp,
            color: isTotal ? AppColors.primary : AppColors.textPrimary,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
