import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialPdfPreviewScreen extends StatefulWidget {
  const MaterialPdfPreviewScreen({super.key});

  @override
  State<MaterialPdfPreviewScreen> createState() =>
      _MaterialPdfPreviewScreenState();
}

class _MaterialPdfPreviewScreenState extends State<MaterialPdfPreviewScreen> {
  bool showPrice = false;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is bool) {
      showPrice = args;
    }
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
              'PDF প্রিভিউ',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              showPrice
                  ? 'মালামালের তালিকা • দামসহ'
                  : 'মালামালের তালিকা • দাম ছাড়া',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Step 4 Stepper
          const MaterialWizardStepper(currentStep: 4),

          Expanded(
            child: SingleChildScrollView(
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
                          Text('বড় করে দেখুন',
                              style: AppTextStyles.smallGrey),
                          SizedBox(width: 4.w),
                          Icon(Icons.search,
                              size: 16.sp, color: AppColors.textSecondary),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 10.h),

                  // A4 Printable Document Container Box
                  AppCard(
                    padding: EdgeInsets.all(14.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Document Header
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

                        // Document Title & Info Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('মালামালের তালিকা',
                                style: AppTextStyles.mediumBlackBold),
                            Text('ML-2026-001 • ২৩ অক্টোবর ২০২৬',
                                style: AppTextStyles.custom(size: 10.sp)),
                          ],
                        ),

                        SizedBox(height: 10.h),

                        // Client Brief Box
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

                        // Materials Table
                        _buildTableHeader(showPrice),
                        Divider(height: 8.h, color: AppColors.border),
                        _buildTableRow('1', 'PPR পাইপ\n২০ মিমি • RFL', '১০০', 'ফুট',
                            showPrice, '৪০', '৪,০০০'),
                        Divider(height: 8.h, color: AppColors.border),
                        _buildTableRow('2', 'এলবো\n২০ মিমি • PPR', '১০', 'টি',
                            showPrice, '৩৫', '৩৫০'),
                        Divider(height: 8.h, color: AppColors.border),
                        _buildTableRow('3', 'সকেট\n২০ মিমি • PPR', '১০', 'টি',
                            showPrice, '২৫', '২৫০'),
                        Divider(height: 8.h, color: AppColors.border),
                        _buildTableRow('4', 'বল ভালভ\n২০ মিমি', '৪', 'টি',
                            showPrice, '৩৫০', '১,৪০০'),

                        if (showPrice) ...[
                          Divider(height: 16.h, color: AppColors.primary),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('মালামালের আনুমানিক মোট:',
                                  style: AppTextStyles.mediumBlackBold),
                              Text('৳৬,৬৪০',
                                  style: AppTextStyles.custom(
                                      size: 15.sp,
                                      color: AppColors.primary,
                                      weight: FontWeight.w700)),
                            ],
                          ),
                        ],

                        SizedBox(height: 12.h),

                        // Client Note Box in Document
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
                              Text('ক্লায়েন্টের জন্য নোট:',
                                  style: AppTextStyles.mediumBlackBold),
                              Text(
                                'কেনার আগে সাইজ, পরিমাণ ও ব্র্যান্ড ঠিকাদারের সাথে মিলিয়ে নিন।',
                                style: AppTextStyles.custom(size: 11.sp),
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
                      // Edit Info / Download Button
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.snackbar('ডাউনলোড', 'PDF ফাইলটি আপনার ডিভাইসে সেভ হয়েছে');
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
                      // Share Button
                      Expanded(
                        child: AppPrimaryButton(
                          onPressed: () {
                            Get.snackbar(
                              'PDF শেয়ার',
                              'হোয়াটসঅ্যাপ বা অন্যান্য প্ল্যাটফর্মে PDF শেয়ার করা হচ্ছে',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppColors.primary,
                              colorText: Colors.white,
                            );
                            Future.delayed(
                                const Duration(milliseconds: 1000), () {
                              Get.until((route) =>
                                  route.settings.name == AppRoutes.mainScreen);
                            });
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
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(bool showPrice) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Row(
        children: [
          SizedBox(
              width: 20.w,
              child: Text('#', style: AppTextStyles.mediumBlackBold)),
          Expanded(
              flex: 3,
              child: Text('মালামালের নাম',
                  style: AppTextStyles.mediumBlackBold)),
          Expanded(
              flex: 1,
              child: Text('পরিমাণ', style: AppTextStyles.mediumBlackBold)),
          Expanded(
              flex: 1,
              child: Text('একক', style: AppTextStyles.mediumBlackBold)),
          if (showPrice) ...[
            Expanded(
                flex: 1,
                child: Text('একক দাম', style: AppTextStyles.mediumBlackBold)),
            Expanded(
                flex: 1,
                child: Text('মোট', style: AppTextStyles.mediumBlackBold)),
          ],
        ],
      ),
    );
  }

  Widget _buildTableRow(String num, String name, String qty, String unit,
      bool showPrice, String price, String total) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
              width: 20.w,
              child: Text(num, style: AppTextStyles.custom(size: 11.sp))),
          Expanded(
              flex: 3,
              child: Text(name, style: AppTextStyles.custom(size: 11.sp))),
          Expanded(
              flex: 1,
              child: Text(qty, style: AppTextStyles.custom(size: 11.sp))),
          Expanded(
              flex: 1,
              child: Text(unit, style: AppTextStyles.custom(size: 11.sp))),
          if (showPrice) ...[
            Expanded(
                flex: 1,
                child: Text(price, style: AppTextStyles.custom(size: 11.sp))),
            Expanded(
                flex: 1,
                child: Text(total, style: AppTextStyles.custom(size: 11.sp))),
          ],
        ],
      ),
    );
  }
}
