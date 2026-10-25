import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';
import 'package:smart_contractor_app/modules/material/controllers/material_wizard_controller.dart';
import 'package:smart_contractor_app/modules/material/models/material_category_model.dart';
import 'package:smart_contractor_app/modules/material/models/material_item_model.dart';
import 'package:smart_contractor_app/modules/material/models/material_template_model.dart';
import 'package:smart_contractor_app/modules/material/widgets/material_wizard_stepper.dart';

class MaterialTemplateListScreen extends StatefulWidget {
  const MaterialTemplateListScreen({super.key});

  @override
  State<MaterialTemplateListScreen> createState() =>
      _MaterialTemplateListScreenState();
}

class _MaterialTemplateListScreenState
    extends State<MaterialTemplateListScreen> {
  final TextEditingController searchController = TextEditingController();
  int selectedToggleIndex = 0; // 0 = প্রস্তুত টেমপ্লেট, 1 = আমার টেমপ্লেট

  late MaterialCategoryModel category;

  final Map<String, List<MaterialTemplateModel>> categoryTemplates = {
    'ইলেক্ট্রিক্যাল': [
      const MaterialTemplateModel(
        id: '1',
        title: 'বাসার ওয়ার্যারিং',
        englishTitle: 'House wiring',
        category: 'ইলেক্ট্রিক্যাল',
        description: 'বাসার সাধারণ ওয়্যারিংয়ের তালিকা',
        items: [
          MaterialItemModel(id: 'e1', name: 'কপার ক্যাবল', size: '১.৫ মিমি', quantity: 100, unit: 'মিটার', unitPrice: 45),
          MaterialItemModel(id: 'e2', name: 'সুইচ বোর্ড', size: '৬ গ্যাং', quantity: 5, unit: 'টি', unitPrice: 350),
          MaterialItemModel(id: 'e3', name: 'সার্কিট ব্রেকার', size: '১৬ অ্যাম্পিয়ার', quantity: 2, unit: 'টি', unitPrice: 450),
        ],
      ),
      const MaterialTemplateModel(
        id: '2',
        title: 'সুইচ ও সকেট বসানো',
        englishTitle: 'Switch / Socket',
        category: 'ইলেক্ট্রিক্যাল',
        description: 'সুইচ ও সকেট সামগ্রী',
        items: [
          MaterialItemModel(id: 'e4', name: 'সুইচ সকেট কম্বো', size: 'সাধারণ', quantity: 10, unit: 'টি', unitPrice: 220),
        ],
      ),
      const MaterialTemplateModel(
        id: '3',
        title: 'ফ্যান বসানো',
        englishTitle: 'Fan fitting',
        category: 'ইলেক্ট্রিক্যাল',
        description: 'ফ্যান ফিটিং সামগ্রী',
        items: [
          MaterialItemModel(id: 'e5', name: 'ফ্যান হুক', size: 'এমএস', quantity: 2, unit: 'টি', unitPrice: 120),
          MaterialItemModel(id: 'e6', name: 'রেগুলেটর', size: 'ডিজিটাল', quantity: 2, unit: 'টি', unitPrice: 250),
        ],
      ),
      const MaterialTemplateModel(
        id: '4',
        title: 'DB বোর্ড বসানো',
        englishTitle: 'Distribution board',
        category: 'ইলেক্ট্রিক্যাল',
        description: 'মেইন ডিস্ট্রিবিউশন বোর্ড',
        items: [
          MaterialItemModel(id: 'e7', name: 'DB বক্স', size: '৮ ওয়ে', quantity: 1, unit: 'টি', unitPrice: 1200),
        ],
      ),
      const MaterialTemplateModel(
        id: '5',
        title: 'পাম্পের বিদ্যুৎ সংযোগ',
        englishTitle: 'Pump connection',
        category: 'ইলেক্ট্রিক্যাল',
        description: 'পানির পাম্পের ওয়্যারিং',
        items: [
          MaterialItemModel(id: 'e8', name: 'স্টারটার সুইচ', size: '১ এইচপি', quantity: 1, unit: 'টি', unitPrice: 850),
        ],
      ),
    ],
    'প্লাম্বিং': [
      const MaterialTemplateModel(
        id: '6',
        title: 'সাধারণ চাপকল বসানো',
        englishTitle: 'Shallow tube well',
        category: 'প্লাম্বিং',
        description: 'সাধারণ চাপকল ফিটিং',
        items: [
          MaterialItemModel(id: 'p1', name: 'চাপকল হেড', size: '৬ নম্বর', quantity: 1, unit: 'টি', unitPrice: 2800),
          MaterialItemModel(id: 'p2', name: 'জিআই পাইপ', size: '১.৫ ইঞ্চি', quantity: 40, unit: 'ফুট', unitPrice: 180),
        ],
      ),
      const MaterialTemplateModel(
        id: '7',
        title: 'গভীর চাপকল বসানো',
        englishTitle: 'Deep tube well',
        category: 'প্লাম্বিং',
        description: 'গভীর টিউবওয়েল ফিটিং',
        items: [
          MaterialItemModel(id: 'p3', name: 'ফিল্টার পাইপ', size: '১.৫ ইঞ্চি', quantity: 20, unit: 'ফুট', unitPrice: 150),
        ],
      ),
      const MaterialTemplateModel(
        id: '8',
        title: 'বাসার পানির পাম্প',
        englishTitle: 'Home water pump',
        category: 'প্লাম্বিং',
        description: 'বাসাবাড়ির ওয়াটার পাম্প',
        items: [
          MaterialItemModel(id: 'p4', name: 'পানির পাম্প', size: '১ এইচপি', quantity: 1, unit: 'টি', unitPrice: 7500),
        ],
      ),
      const MaterialTemplateModel(
        id: '9',
        title: 'সাবমারসিবল পাম্প',
        englishTitle: 'Submersible pump',
        category: 'প্লাম্বিং',
        description: 'সাবমারসিবল পাম্প ফিটিং',
        items: [
          MaterialItemModel(id: 'p5', name: 'সাবমারসিবল সেট', size: '১.৫ এইচপি', quantity: 1, unit: 'টি', unitPrice: 18500),
        ],
      ),
    ],
    'পাইপ ফিটিংস': [
      const MaterialTemplateModel(
        id: '10',
        title: 'বাথরুমের পানির লাইন',
        englishTitle: 'Bathroom water line',
        category: 'পাইপ ফিটিংস',
        description: 'PPR লাইনের প্রাথমিক তালিকা',
        items: [
          MaterialItemModel(id: 'm1', name: 'PPR পাইপ', size: '২০ মিমি', brand: 'RFL', quantity: 100, unit: 'ফুট', unitPrice: 40),
          MaterialItemModel(id: 'm2', name: 'এলবো', size: '২০ মিমি', brand: 'PPR', quantity: 10, unit: 'টি', unitPrice: 35),
          MaterialItemModel(id: 'm3', name: 'সকেট', size: '২০ মিমি', brand: 'PPR', quantity: 10, unit: 'টি', unitPrice: 25),
          MaterialItemModel(id: 'm4', name: 'বল ভালভ', size: '২০ মিমি', brand: 'PPR', quantity: 4, unit: 'টি', unitPrice: 350),
          MaterialItemModel(id: 'm5', name: 'টেফলন টেপ', size: 'সাধারণ', brand: 'PPR', quantity: 3, unit: 'রোল', unitPrice: 25),
          MaterialItemModel(id: 'm6', name: 'পাইপ ক্ল্যাম্প', size: '২০ মিমি', brand: 'PPR', quantity: 15, unit: 'টি', unitPrice: 15),
        ],
      ),
      const MaterialTemplateModel(
        id: '11',
        title: 'ড্রেন ও বর্জ্য পানির লাইন',
        englishTitle: 'Drain / Waste line',
        category: 'পাইপ ফিটিংস',
        description: 'PVC ড্রেন লাইন ফিটিং',
        items: [
          MaterialItemModel(id: 'm7', name: 'PVC পাইপ', size: '৪ ইঞ্চি', quantity: 40, unit: 'ফুট', unitPrice: 110),
          MaterialItemModel(id: 'm8', name: 'PVC এলবো', size: '৪ ইঞ্চি', quantity: 4, unit: 'টি', unitPrice: 85),
        ],
      ),
      const MaterialTemplateModel(
        id: '12',
        title: 'সম্পূর্ণ বাথরুমের পাইপ',
        englishTitle: 'Complete bathroom piping',
        category: 'পাইপ ফিটিংস',
        description: 'বাথরুমের সুয়ারেজ ও ওয়াটার লাইন',
        items: [
          MaterialItemModel(id: 'm9', name: 'PPR পাইপ', size: '২০ মিমি', quantity: 120, unit: 'ফুট', unitPrice: 40),
        ],
      ),
    ],
    'স্যানিটারি': [
      const MaterialTemplateModel(
        id: '13',
        title: 'হাই কমোড বসানো',
        englishTitle: 'High commode',
        category: 'স্যানিটারি',
        description: 'কমোড ফিটিং সামগ্রী',
        items: [
          MaterialItemModel(id: 's1', name: 'হাই কমোড সেট', size: 'স্ট্যান্ডার্ড', quantity: 1, unit: 'টি', unitPrice: 8500),
        ],
      ),
      const MaterialTemplateModel(
        id: '14',
        title: 'লো কমোড / প্যান বসানো',
        englishTitle: 'Low commode / Pan',
        category: 'স্যানিটারি',
        description: 'প্যান ও ফ্ল্যাশ ট্যাঙ্ক',
        items: [
          MaterialItemModel(id: 's2', name: 'লো প্যান', size: 'সাদা', quantity: 1, unit: 'টি', unitPrice: 1800),
        ],
      ),
      const MaterialTemplateModel(
        id: '15',
        title: 'বেসিন বসানো',
        englishTitle: 'Basin fitting',
        category: 'স্যানিটারি',
        description: 'বেসিন ও পেডেস্টাল',
        items: [
          MaterialItemModel(id: 's3', name: 'বেসিন সেট', size: '১৮ ইঞ্চি', quantity: 1, unit: 'টি', unitPrice: 4200),
        ],
      ),
    ],
    'কনস্ট্রাকশন': [
      const MaterialTemplateModel(
        id: '16',
        title: 'ইটের দেয়াল তৈরি',
        englishTitle: 'Brickwork',
        category: 'কনস্ট্রাকশন',
        description: '৫ ইঞ্চি গাঁথুনির মালপত্র',
        items: [
          MaterialItemModel(id: 'c1', name: '১ম শ্রেণীর ইট', size: 'স্ট্যান্ডার্ড', quantity: 1000, unit: 'টি', unitPrice: 13),
          MaterialItemModel(id: 'c2', name: 'সিমেন্ট', size: '৫০ কেজি', quantity: 8, unit: 'ব্যাগ', unitPrice: 520),
          MaterialItemModel(id: 'c3', name: 'বালু', size: 'এফএম ১.৫', quantity: 45, unit: 'সিএফটি', unitPrice: 38),
        ],
      ),
      const MaterialTemplateModel(
        id: '17',
        title: 'দেয়াল প্লাস্টার',
        englishTitle: 'Plaster',
        category: 'কনস্ট্রাকশন',
        description: 'দেয়াল প্লাস্টারের মালামাল',
        items: [
          MaterialItemModel(id: 'c4', name: 'সিমেন্ট', size: '৫০ কেজি', quantity: 6, unit: 'ব্যাগ', unitPrice: 520),
        ],
      ),
    ],
  };

  @override
  void initState() {
    super.initState();
    final args = Get.arguments;
    if (args is MaterialCategoryModel) {
      category = args;
    } else {
      category = const MaterialCategoryModel(
        id: 'pipe_fittings',
        title: 'পাইপ ফিটিংস',
        englishTitle: 'Pipe Fittings',
        countText: '3টি টেমপ্লেট',
        icon: Icons.plumbing_outlined,
        iconBgColor: Color(0xFFE8F8F0),
        iconColor: Color(0xFF079455),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final templates = categoryTemplates[category.title] ?? [];

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
              category.title,
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              '${templates.length}টি প্রস্তুত টেমপ্লেট',
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
                children: [
                  // Toggle Segmented Control (প্রস্তুত টেমপ্লেট / আমার টেমপ্লেট)
                  Container(
                    height: 46.h,
                    padding: EdgeInsets.all(3.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF3F8),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                selectedToggleIndex = 0;
                              });
                            },
                            borderRadius: BorderRadius.circular(8.r),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedToggleIndex == 0
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'প্রস্তুত টেমপ্লেট',
                                style: AppTextStyles.custom(
                                  size: 13.sp,
                                  color: selectedToggleIndex == 0
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  weight: selectedToggleIndex == 0
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.myMaterialTemplatesScreen);
                            },
                            borderRadius: BorderRadius.circular(8.r),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: selectedToggleIndex == 1
                                    ? AppColors.primary
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Text(
                                'আমার টেমপ্লেট',
                                style: AppTextStyles.custom(
                                  size: 13.sp,
                                  color: selectedToggleIndex == 1
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  weight: selectedToggleIndex == 1
                                      ? FontWeight.w700
                                      : FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 12.h),

                  // Search Field
                  AppTextField(
                    controller: searchController,
                    hint: 'এই বিভাগের টেমপ্লেট খুঁজুন',
                    icon: Icons.search_rounded,
                  ),

                  SizedBox(height: 12.h),

                  // Template Item Cards
                  ...templates.map((template) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 8.h),
                      child: AppCard(
                        onTap: () {
                          if (Get.isRegistered<MaterialWizardController>()) {
                            Get.find<MaterialWizardController>()
                                .selectTemplate(template);
                          }
                          Get.toNamed(
                            AppRoutes.materialTemplateDetailScreen,
                            arguments: template,
                          );
                        },
                        child: Row(
                          children: [
                            Container(
                              width: 44.w,
                              height: 44.w,
                              decoration: BoxDecoration(
                                color: category.iconBgColor,
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Icon(
                                category.icon,
                                color: category.iconColor,
                                size: 24.sp,
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    template.title,
                                    style: AppTextStyles.mediumBlackBold,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    template.englishTitle,
                                    style: AppTextStyles.smallGrey,
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textSecondary,
                              size: 22.sp,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

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
                            'সাইট দেখে মালামাল, পরিমাণ ও সাইজ ঠিক করবেন।',
                            style: AppTextStyles.custom(
                              size: 12.sp,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Create Own Template Button
                  InkWell(
                    onTap: () {
                      Get.toNamed(AppRoutes.customTemplateCreateScreen);
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Container(
                      height: 48.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: AppColors.primary, width: 1.5),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add,
                              color: AppColors.primary, size: 20.sp),
                          SizedBox(width: 6.w),
                          Text(
                            'নিজের টেমপ্লেট বানান',
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
