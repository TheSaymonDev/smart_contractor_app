import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_custom_app_bar.dart';
import 'package:smart_contractor_app/core/widgets/app_outlined_button.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';

class FinalBillPdfPreviewScreen extends StatelessWidget {
  const FinalBillPdfPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppCustomAppBar(
        title: 'PDF প্রিভিউ',
        subtitle: 'করিমের বাসা • ফাইনাল বিল',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
        child: Column(
          children: [
            // Page Specs Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.description_outlined,
                        size: 16.sp, color: AppColors.textSecondary),
                    SizedBox(width: 4.w),
                    Text('A4 • ১ পৃষ্ঠা', style: AppTextStyles.smallGrey),
                  ],
                ),
                Row(
                  children: [
                    Text('বড় করে দেখুন', style: AppTextStyles.smallGrey),
                    SizedBox(width: 4.w),
                    Icon(Icons.search,
                        size: 16.sp, color: AppColors.textSecondary),
                  ],
                ),
              ],
            ),

            SizedBox(height: 10.h),

            // A4 Document Container Box
            AppCard(
              padding: EdgeInsets.all(14.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Company Header
                  Row(
                    children: [
                      Container(
                        width: 32.w,
                        height: 32.w,
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(
                          Icons.apartment,
                          color: AppColors.primary,
                          size: 18.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'রহমান কন্ট্রাক্টর সার্ভিস',
                            style: AppTextStyles.custom(
                              size: 14.sp,
                              color: AppColors.primary,
                              weight: FontWeight.w700,
                            ),
                          ),
                          Text('ঠিকাদার: রহমান আলী • 01712-345678',
                              style: AppTextStyles.custom(size: 10.sp)),
                          Text('মিরপুর-১০, ঢাকা',
                              style: AppTextStyles.custom(size: 10.sp)),
                        ],
                      ),
                    ],
                  ),

                  Divider(height: 16.h, color: AppColors.primary),

                  // Document Title & ID
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('কাজের ফাইনাল বিল',
                          style: AppTextStyles.mediumBlackBold),
                      Text('FB-2026-001 • ২৩ অক্টোবর ২০২৬',
                          style: AppTextStyles.custom(size: 10.sp)),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // Client & Job Brief Box
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3F8),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ক্লায়েন্ট:',
                                style: AppTextStyles.custom(size: 10.sp)),
                            Text('আব্দুল করিম',
                                style: AppTextStyles.mediumBlackBold),
                            Text('মোবাইল: 01812-345678',
                                style: AppTextStyles.custom(size: 10.sp)),
                            Text('ঠিকানা: মিরপুর-১০, ঢাকা',
                                style: AppTextStyles.custom(size: 10.sp)),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('কাজের জন্য:',
                                style: AppTextStyles.custom(size: 10.sp)),
                            Text('করিমের বাসা',
                                style: AppTextStyles.mediumBlackBold),
                            Text('বাথরুমের পানির লাইন',
                                style: AppTextStyles.custom(size: 10.sp)),
                            Text('কাজের ঠিকানা: মিরপুর-১০, ঢাকা - ২য় তলা',
                                style: AppTextStyles.custom(size: 10.sp)),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Table Header Row
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 6.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('বিবরণ', style: AppTextStyles.mediumBlackBold),
                        Text('টাকা', style: AppTextStyles.mediumBlackBold),
                      ],
                    ),
                  ),

                  SizedBox(height: 6.h),

                  // Table Item Rows
                  _buildBillRow('ফিক্সড কাজের মজুরি', '৳২৭,০০০'),
                  Divider(height: 12.h, color: AppColors.border),
                  _buildBillRow('বাড়তি কাজ: পুরোনো পাইপ খোলা', '৳১,০০০'),

                  Divider(height: 16.h, color: AppColors.primary),

                  // Bill Total Summary Box Right Aligned
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      width: 180.w,
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF3F8),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow(
                              'মোট বিল', '৳২৮,০০০', AppColors.primary),
                          SizedBox(height: 4.h),
                          _buildSummaryRow('পাওয়া টাকা', '৳১৮,০০০',
                              const Color(0xFF079455)),
                          SizedBox(height: 4.h),
                          _buildSummaryRow(
                              'ক্লায়েন্টের বাকি', '৳১০,০০০', Colors.red),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Bill Note Box
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('বিলের নোট:', style: AppTextStyles.mediumBlackBold),
                        SizedBox(height: 2.h),
                        Text(
                          'ক্লায়েন্টের কেনা মালামালের দাম এই বিলে যোগ করা হয়নি। কাজের মজুরি দেওয়া বাকি টাকার তথ্য: বাকি আছে',
                          style: AppTextStyles.custom(size: 10.sp),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 24.h),

                  // Signature Lines
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                              width: 100.w,
                              height: 1.h,
                              color: AppColors.border),
                          SizedBox(height: 4.h),
                          Text('ক্লায়েন্ট / কর্মীর স্বাক্ষর',
                              style: AppTextStyles.custom(size: 10.sp)),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                              width: 100.w,
                              height: 1.h,
                              color: AppColors.border),
                          SizedBox(height: 4.h),
                          Text('ঠিকাদারের স্বাক্ষর',
                              style: AppTextStyles.custom(size: 10.sp)),
                        ],
                      ),
                    ],
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
                      'সব তথ্য দেখে তারপর শেয়ার করুন।',
                      style: AppTextStyles.custom(
                        size: 12.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20.h),

            // Bottom Action Buttons
            Row(
              children: [
                Expanded(
                  child: AppOutlinedButton(
                    onPressed: () {
                      Get.snackbar(
                          'ডাউনলোড', 'ফাইনাল বিল PDF ফাইল ডিভাইসে সেভ হয়েছে');
                    },
                    text: 'ডাউনলোড',
                    icon: Icons.download_rounded,
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppPrimaryButton(
                    onPressed: () {
                      Get.snackbar(
                        'PDF শেয়ার',
                        'হোয়াটসঅ্যাপে ফাইনাল বিল শেয়ার করা হচ্ছে',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: AppColors.primary,
                        colorText: Colors.white,
                      );
                    },
                    text: 'PDF শেয়ার করুন',
                    icon: Icons.share_rounded,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBillRow(String name, String price) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: AppTextStyles.custom(size: 11.sp)),
          Text(price, style: AppTextStyles.custom(size: 11.sp, weight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.custom(size: 10.sp)),
        Text(value,
            style: AppTextStyles.custom(
                size: 12.sp, color: color, weight: FontWeight.w700)),
      ],
    );
  }
}
