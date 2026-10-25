import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';

class PaymentReceiptPdfPreviewScreen extends StatefulWidget {
  const PaymentReceiptPdfPreviewScreen({super.key});

  @override
  State<PaymentReceiptPdfPreviewScreen> createState() =>
      _PaymentReceiptPdfPreviewScreenState();
}

class _PaymentReceiptPdfPreviewScreenState
    extends State<PaymentReceiptPdfPreviewScreen> {
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
              'PDF প্রিভিউ',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'করিমের বাসা • টাকা পাওয়ার রসিদ',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
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
                      Text('টাকা পাওয়ার রসিদ',
                          style: AppTextStyles.mediumBlackBold),
                      Text('MR-2026-001 • ২৩ অক্টোবর ২০২৬',
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
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Today Received Amount Highlight Box (Center)
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      children: [
                        Text('আজ পাওয়া টাকা',
                            style: AppTextStyles.custom(
                                size: 11.sp, color: AppColors.primary)),
                        SizedBox(height: 4.h),
                        Text(
                          '৳৫,০০০',
                          style: AppTextStyles.custom(
                            size: 24.sp,
                            color: AppColors.primary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text('পাঁচ হাজার টাকা মাত্র',
                            style: AppTextStyles.custom(size: 10.sp)),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Payment Details Table Rows
                  _buildDetailRow('মাধ্যম', 'ক্যাশ / Cash'),
                  Divider(height: 10.h, color: AppColors.border),
                  _buildDetailRow('ধরন', 'আংশিক টাকা'),
                  Divider(height: 10.h, color: AppColors.border),
                  _buildDetailRow('রেফারেন্স', '—'),
                  Divider(height: 10.h, color: AppColors.border),
                  _buildDetailRow('আগে পাওয়া', '৳১৮,০০০'),
                  Divider(height: 10.h, color: AppColors.border),
                  _buildDetailRow('সব মিলিয়ে পাওয়া', '৳২৩,০০০',
                      color: const Color(0xFF079455)),
                  Divider(height: 10.h, color: AppColors.border),
                  _buildDetailRow('মোট বিল', '৳২৮,০০০'),
                  Divider(height: 10.h, color: AppColors.border),
                  _buildDetailRow('এখন বাকি', '৳৫,০০০', color: Colors.red),

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
                  child: InkWell(
                    onTap: () {
                      Get.snackbar('ডাউনলোড',
                          'টাকা পাওয়ার রসিদ PDF ফাইল ডিভাইসে সেভ হয়েছে');
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: AppColors.primary, width: 1.5),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.download_rounded,
                              color: AppColors.primary, size: 18.sp),
                          SizedBox(width: 6.w),
                          Text(
                            'ডাউনলোড',
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
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: AppPrimaryButton(
                    onPressed: () {
                      Get.snackbar(
                        'PDF শেয়ার',
                        'হোয়াটসঅ্যাপে টাকা পাওয়ার রসিদ শেয়ার করা হচ্ছে',
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

  Widget _buildDetailRow(String label, String value, {Color? color}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 4.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.custom(size: 11.sp)),
          Text(
            value,
            style: AppTextStyles.custom(
              size: 11.sp,
              color: color ?? AppColors.textPrimary,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
