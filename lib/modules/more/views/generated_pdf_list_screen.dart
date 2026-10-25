import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_text_field.dart';

class GeneratedPdfItem {
  final String id;
  final String title;
  final String subtitle;
  final String category; // মালামাল, বিল, রসিদ, কর্মী
  final Color badgeColor;
  final Color badgeBgColor;

  const GeneratedPdfItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.category,
    required this.badgeColor,
    required this.badgeBgColor,
  });
}

class GeneratedPdfListScreen extends StatefulWidget {
  const GeneratedPdfListScreen({super.key});

  @override
  State<GeneratedPdfListScreen> createState() => _GeneratedPdfListScreenState();
}

class _GeneratedPdfListScreenState extends State<GeneratedPdfListScreen> {
  final TextEditingController searchController = TextEditingController();
  int selectedFilterIndex = 0;

  final List<String> filterLabels = ['সব', 'মালামাল', 'বিল', 'রসিদ', 'কর্মী'];

  final List<GeneratedPdfItem> pdfItems = const [
    GeneratedPdfItem(
      id: '1',
      title: 'মালামালের তালিকা',
      subtitle: 'করিমের বাসা • ২৩ অক্টোবর • v2',
      category: 'মালামাল',
      badgeColor: AppColors.primary,
      badgeBgColor: AppColors.primaryLight,
    ),
    GeneratedPdfItem(
      id: '2',
      title: 'মালামালের তালিকা',
      subtitle: 'করিমের বাসা • ২২ অক্টোবর • v1',
      category: 'মালামাল',
      badgeColor: AppColors.primary,
      badgeBgColor: AppColors.primaryLight,
    ),
    GeneratedPdfItem(
      id: '3',
      title: 'ফাইনাল বিল',
      subtitle: 'করিমের বাসা • ২৩ অক্টোবর',
      category: 'বিল',
      badgeColor: Color(0xFF079455),
      badgeBgColor: Color(0xFFE8F8F0),
    ),
    GeneratedPdfItem(
      id: '4',
      title: 'টাকা পাওয়ার রসিদ',
      subtitle: 'করিমের বাসা • ২৩ অক্টোবর',
      category: 'রসিদ',
      badgeColor: Color(0xFFE66A00),
      badgeBgColor: Color(0xFFFFF4E5),
    ),
    GeneratedPdfItem(
      id: '5',
      title: 'কর্মীর হিসাব',
      subtitle: 'রহিম মিয়া • অক্টোবর ২০২৬',
      category: 'কর্মী',
      badgeColor: Color(0xFF6941C6),
      badgeBgColor: Color(0xFFF4EBFF),
    ),
  ];

  @override
  void initState() {
    super.initState();
    searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  List<GeneratedPdfItem> get filteredPdfItems {
    final query = searchController.text.trim().toLowerCase();

    return pdfItems.where((item) {
      // Category Tab Filter
      bool matchesTab = true;
      if (selectedFilterIndex > 0) {
        matchesTab = item.category == filterLabels[selectedFilterIndex];
      }

      // Search Query Filter
      bool matchesSearch = query.isEmpty ||
          item.title.toLowerCase().contains(query) ||
          item.subtitle.toLowerCase().contains(query);

      return matchesTab && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final items = filteredPdfItems;

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
              'তৈরি করা PDF',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'আগের PDF আবার দেখুন ও পাঠান',
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
            // 1. Search Field
            _buildSearchBar(),

            SizedBox(height: 12.h),

            // 2. Filter Tabs Bar
            _buildFilterTabs(),

            SizedBox(height: 12.h),

            // 3. PDF Cards List
            ...items.map((pdf) => Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: _buildPdfCard(pdf),
                )),

            SizedBox(height: 6.h),

            // 4. Info Notice Box
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
                      'প্রতিটি PDF তৈরির সময়কার কপি। তালিকা বদলালে নতুন PDF তৈরি করুন।',
                      style: AppTextStyles.custom(
                        size: 12.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Search Input Bar Helper
  Widget _buildSearchBar() {
    return AppTextField(
      controller: searchController,
      hint: 'কাজ, কর্মী বা PDF খুঁজুন',
      icon: Icons.search_rounded,
    );
  }

  // Filter Tabs Bar Helper
  Widget _buildFilterTabs() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(filterLabels.length, (index) {
          final isSelected = selectedFilterIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedFilterIndex = index;
                });
              },
              borderRadius: BorderRadius.circular(9.r),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                height: 38.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(9.r),
                ),
                child: Text(
                  filterLabels[index],
                  style: AppTextStyles.custom(
                    size: 12.sp,
                    color: isSelected ? Colors.white : AppColors.textSecondary,
                    weight: isSelected ? FontWeight.w700 : FontWeight.w400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // PDF Card Helper
  Widget _buildPdfCard(GeneratedPdfItem pdf) {
    return AppCard(
      onTap: () {
        if (pdf.category == 'বিল') {
          Get.toNamed(AppRoutes.finalBillPdfPreviewScreen);
        } else if (pdf.category == 'রসিদ') {
          Get.toNamed(AppRoutes.paymentReceiptPdfPreviewScreen);
        } else if (pdf.category == 'কর্মী') {
          Get.toNamed(AppRoutes.workerLedgerPdfPreviewScreen);
        } else {
          Get.toNamed(AppRoutes.materialPdfPreviewScreen);
        }
      },
      child: Row(
        children: [
          Container(
            width: 42.w,
            height: 42.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.description_outlined,
              color: AppColors.primary,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pdf.title,
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  pdf.subtitle,
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: pdf.badgeBgColor,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              'PDF',
              style: AppTextStyles.custom(
                size: 11.sp,
                color: pdf.badgeColor,
                weight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
