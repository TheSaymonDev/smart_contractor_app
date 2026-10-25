import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/material/models/material_template_model.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialTemplateDetailScreen extends StatefulWidget {
  const MaterialTemplateDetailScreen({super.key});

  @override
  State<MaterialTemplateDetailScreen> createState() =>
      _MaterialTemplateDetailScreenState();
}

class _MaterialTemplateDetailScreenState
    extends State<MaterialTemplateDetailScreen> {
  bool checkPipeClamp = true;
  bool checkUnion = true;

  late MaterialTemplateModel template;

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is MaterialTemplateModel) {
      template = args;
    } else {
      template = const MaterialTemplateModel(
        id: '10',
        title: 'বাথরুমের পানির লাইন',
        englishTitle: 'Bathroom water line',
        category: 'পাইপ ফিটিংস',
        description: 'PPR লাইনের প্রাথমিক তালিকা',
        items: [],
      );
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
              'টেমপ্লেটের বিস্তারিত',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              template.title,
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Step 1 Stepper
          const MaterialWizardStepper(currentStep: 1),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Brief Template Card
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10.w, vertical: 4.h),
                              decoration: BoxDecoration(
                                color: const Color(0xFFE8F8F0),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                'প্রস্তুত টেমপ্লেট',
                                style: AppTextStyles.custom(
                                  size: 11.sp,
                                  color: const Color(0xFF079455),
                                  weight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.plumbing_outlined,
                              color: AppColors.textSecondary,
                              size: 20.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          template.title,
                          style: AppTextStyles.custom(
                            size: 18.sp,
                            color: AppColors.textPrimary,
                            weight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          template.description,
                          style: AppTextStyles.smallGrey,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Section Title
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('সাধারণ মালামাল',
                          style: AppTextStyles.mediumBlackBold),
                      Text(
                        '৬টি',
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: AppColors.primary,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),

                  // Standard Items Card Box
                  AppCard(
                    child: Column(
                      children: [
                        _buildDetailItemRow('PPR পাইপ', 'পরিমাণ দিন'),
                        Divider(height: 16.h, color: AppColors.border),
                        _buildDetailItemRow('এলবো ও সকেট', 'পরিমাণ দিন'),
                        Divider(height: 16.h, color: AppColors.border),
                        _buildDetailItemRow('টি ও বল ভালভ', 'পরিমাণ দিন'),
                        Divider(height: 16.h, color: AppColors.border),
                        _buildDetailItemRow('টেফলন টেপ', 'পরিমাণ দিন'),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Optional Additions Section
                  Text('দরকার হলে যোগ করুন',
                      style: AppTextStyles.mediumBlackBold),
                  SizedBox(height: 8.h),

                  _buildCheckboxOptionRow(
                    title: 'পাইপ ক্ল্যাম্প',
                    subtitle: 'দেয়ালে পাইপ আটকাতে',
                    value: checkPipeClamp,
                    onChanged: (val) {
                      setState(() {
                        checkPipeClamp = val ?? true;
                      });
                    },
                  ),

                  SizedBox(height: 8.h),

                  _buildCheckboxOptionRow(
                    title: 'ইউনিয়ন',
                    subtitle: 'খোলা ও লাগানোর সুবিধার জন্য',
                    value: checkUnion,
                    onChanged: (val) {
                      setState(() {
                        checkUnion = val ?? true;
                      });
                    },
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
                            'পরের ধাপে সাইজ, পরিমাণ ও ব্র্যান্ড বদলান। মূল টেমপ্লেট ঠিক থাকবে।',
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

                  // Bottom Action Button -> Step 2
                  AppPrimaryButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.materialItemsEditScreen);
                    },
                    text: 'এই তালিকা ব্যবহার করুন',
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

  // Detail Item Row Helper
  Widget _buildDetailItemRow(String title, String actionText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.mediumGrey),
        Text(
          actionText,
          style: AppTextStyles.custom(
            size: 13.sp,
            color: AppColors.textPrimary,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // Checkbox Option Row Helper
  Widget _buildCheckboxOptionRow({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool?> onChanged,
  }) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Row(
        children: [
          SizedBox(
            width: 24.w,
            height: 24.w,
            child: Checkbox(
              value: value,
              activeColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              onChanged: onChanged,
            ),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 2.h),
                Text(subtitle, style: AppTextStyles.smallGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
