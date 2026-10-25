import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/core/widgets/app_primary_button.dart';
import 'package:smart_contractor_app/modules/main/controllers/main_controller.dart';

class JobDetailsScreen extends StatefulWidget {
  const JobDetailsScreen({super.key});

  @override
  State<JobDetailsScreen> createState() => _JobDetailsScreenState();
}

class _JobDetailsScreenState extends State<JobDetailsScreen> {
  int selectedTabIndex = 0;

  final List<String> tabLabels = [
    'সারাংশ',
    'মালামাল',
    'হাজিরা',
    'হিসাব',
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
              'কাজের বিস্তারিত',
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
            // 1. Brief Job Card
            _buildBriefJobCard(),

            SizedBox(height: 12.h),

            // 2. Navigation Tabs Bar
            _buildNavigationTabs(),

            SizedBox(height: 16.h),

            // 3. Dynamic Tab Content View
            _buildTabContent(),
          ],
        ),
      ),
    );
  }

  // Brief Job Card
  Widget _buildBriefJobCard() {
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 22.r,
            backgroundColor: AppColors.primaryLight,
            child: Icon(
              Icons.person_outline_rounded,
              size: 26.sp,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'করিমের বাসা',
                  style: AppTextStyles.custom(
                    size: 17.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  'আব্দুল করিম • মিরপুর-১০, ঢাকা',
                  style: AppTextStyles.smallGrey,
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'চলছে',
              style: AppTextStyles.custom(
                size: 12.sp,
                color: AppColors.primary,
                weight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Navigation Tabs Bar
  Widget _buildNavigationTabs() {
    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: List.generate(tabLabels.length, (index) {
          final isSelected = selectedTabIndex == index;
          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedTabIndex = index;
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
                  tabLabels[index],
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

  // Dynamic Tab Content Selector
  Widget _buildTabContent() {
    switch (selectedTabIndex) {
      case 1:
        return _buildMaterialsTab();
      case 2:
        return _buildAttendanceTab();
      case 3:
        return _buildAccountsTab();
      case 0:
      default:
        return _buildSummaryTab();
    }
  }

  // ==========================================
  // TAB 0: saraamsho (Summary Tab)
  // ==========================================
  Widget _buildSummaryTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('কাজের সারাংশ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 8.h),

        // 2x2 Summary Grid
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 1.85,
          children: const [
            _SummaryCardItem(
              icon: Icons.description_outlined,
              title: 'মোট বিল',
              value: '৳২৮,০০০',
              iconBgColor: AppColors.primaryLight,
              iconColor: AppColors.primary,
              valueColor: AppColors.primary,
            ),
            _SummaryCardItem(
              icon: Icons.payments_outlined,
              title: 'পাওয়া টাকা',
              value: '৳১৮,০০০',
              iconBgColor: Color(0xFFE8F8F0),
              iconColor: Color(0xFF079455),
              valueColor: Color(0xFF079455),
            ),
            _SummaryCardItem(
              icon: Icons.account_balance_wallet_outlined,
              title: 'ক্লায়েন্টের বাকি',
              value: '৳১০,০০০',
              iconBgColor: Color(0xFFFFEBEB),
              iconColor: Colors.red,
              valueColor: Colors.red,
            ),
            _SummaryCardItem(
              icon: Icons.calendar_month_outlined,
              title: 'কাজ হয়েছে',
              value: '৩ দিন',
              iconBgColor: AppColors.primaryLight,
              iconColor: AppColors.primary,
              valueColor: AppColors.primary,
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Materials Card Link -> Tab 1
        AppCard(
          onTap: () {
            setState(() {
              selectedTabIndex = 1;
            });
          },
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.layers_outlined,
                  color: AppColors.primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('মালামালের তালিকা', style: AppTextStyles.mediumBlackBold),
                    SizedBox(height: 2.h),
                    Text(
                      '৮টি মালামাল • PDF তৈরি করুন',
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

        SizedBox(height: 8.h),

        // Days & Workers Card Link -> Tab 2
        AppCard(
          onTap: () {
            setState(() {
              selectedTabIndex = 2;
            });
          },
          child: Row(
            children: [
              Container(
                width: 42.w,
                height: 42.w,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.calendar_month_outlined,
                  color: AppColors.primary,
                  size: 22.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('কাজের দিন ও কর্মী', style: AppTextStyles.mediumBlackBold),
                    SizedBox(height: 2.h),
                    Text(
                      '৩ দিন • ৪ জন কর্মী',
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

        SizedBox(height: 12.h),

        // Info Box
        _buildInfoNoticeBox('কাজ শেষ করলেও বাকি টাকার হিসাব থাকবে।'),

        SizedBox(height: 24.h),

        // Bottom Action Buttons
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.jobManagementScreen);
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit_outlined,
                          color: AppColors.primary, size: 18.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'কাজের তথ্য এডিট',
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
                    'কাজ সম্পন্ন',
                    'কাজ সফলভাবে সমাপ্ত করা হয়েছে',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: AppColors.primary,
                    colorText: Colors.white,
                  );
                },
                text: 'কাজ শেষ করুন',
                icon: Icons.check_rounded,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================
  // TAB 1: maalamaal (Materials Tab)
  // ==========================================
  Widget _buildMaterialsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('মালামালের তালিকা', style: AppTextStyles.mediumBlackBold),
                      SizedBox(height: 2.h),
                      Text('বাথরুমের পানির লাইন', style: AppTextStyles.smallGrey),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      '৮টি',
                      style: AppTextStyles.custom(
                        size: 12.sp,
                        color: AppColors.primary,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12.h),

              // Material Items List
              _buildMaterialItemRow('PPR পাইপ • ২০ মিমি', '১০০ ফুট'),
              Divider(height: 16.h, color: AppColors.border),
              _buildMaterialItemRow('এলবো • ২০ মিমি', '১০টি'),
              Divider(height: 16.h, color: AppColors.border),
              _buildMaterialItemRow('সকেট • ২০ মিমি', '১০টি'),
              Divider(height: 16.h, color: AppColors.border),
              _buildMaterialItemRow('বল ভালভ • ২০ মিমি', '৪টি'),

              SizedBox(height: 14.h),
              InkWell(
                onTap: () {
                  Get.snackbar('মালামাল তালিকা', 'সকল ৮টি মালামাল');
                },
                child: Center(
                  child: Text(
                    'সব ৮টি মালামাল দেখুন',
                    style: AppTextStyles.custom(
                      size: 13.sp,
                      color: AppColors.primary,
                      weight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Action Buttons: Edit List & Add Templates
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.materialItemsEditScreen);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 48.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.edit_outlined, color: AppColors.primary, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'তালিকা এডিট করুন',
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

        SizedBox(height: 8.h),

        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.materialTemplateCategoriesScreen);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            height: 48.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColors.primary, width: 1.5),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.layers_outlined, color: AppColors.primary, size: 18.sp),
                SizedBox(width: 8.w),
                Text(
                  'আরও টেমপ্লেট যোগ করুন',
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

        SizedBox(height: 12.h),

        // Info Notice Box
        _buildInfoNoticeBox(
          'ক্লায়েন্ট মালামাল কিনলে এই তালিকা দিন। কাজের বিলে এই দাম নিজে থেকে যোগ হবে না।',
        ),

        SizedBox(height: 24.h),

        // Bottom PDF Button
        AppPrimaryButton(
          onPressed: () {
            Get.toNamed(AppRoutes.materialPdfPreviewScreen);
          },
          text: 'মালামালের PDF',
          icon: Icons.description_outlined,
        ),
      ],
    );
  }

  // Material Row Helper
  Widget _buildMaterialItemRow(String name, String quantity) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(name, style: AppTextStyles.mediumGrey),
        Text(
          quantity,
          style: AppTextStyles.mediumBlackBold,
        ),
      ],
    );
  }

  // ==========================================
  // TAB 2: hajira (Attendance Tab)
  // ==========================================
  Widget _buildAttendanceTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('কাজের দিন', style: AppTextStyles.mediumBlackBold),
            Text(
              '৩ দিন',
              style: AppTextStyles.custom(
                size: 13.sp,
                color: AppColors.primary,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),

        // Day Cards
        _buildAttendanceDayCard('২৩ অক্টোবর ২০২৬', '৩ জন কর্মী • খরচ ৳২,০০০'),
        SizedBox(height: 8.h),
        _buildAttendanceDayCard('২২ অক্টোবর ২০২৬', '৪ জন কর্মী • খরচ ৳২,৮০০'),
        SizedBox(height: 8.h),
        _buildAttendanceDayCard('২১ অক্টোবর ২০২৬', '৩ জন কর্মী • খরচ ৳২,২০০'),

        SizedBox(height: 12.h),

        // Total Wage Summary Card
        AppCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('মোট কর্মীর মজুরি', style: AppTextStyles.mediumGrey),
              Text(
                '৳৭,০০০',
                style: AppTextStyles.custom(
                  size: 16.sp,
                  color: AppColors.textPrimary,
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Info Notice Box
        _buildInfoNoticeBox('একই কর্মীর আজকের হাজিরা আগে দেওয়া থাকলে সেটাই খুলবে।'),

        SizedBox(height: 24.h),

        // Bottom Attendance Action Button
        AppPrimaryButton(
          onPressed: () {
            if (Get.isRegistered<MainController>()) {
              Get.find<MainController>().changeTab(2);
            } else {
              Get.toNamed(AppRoutes.attendanceScreen);
            }
          },
          text: 'আজকের হাজিরা দিন',
          icon: Icons.calendar_month_outlined,
        ),
      ],
    );
  }

  // Attendance Day Card Helper
  Widget _buildAttendanceDayCard(String dateText, String subtitle) {
    return AppCard(
      onTap: () {
        if (Get.isRegistered<MainController>()) {
          Get.find<MainController>().changeTab(2);
        }
      },
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.calendar_month_outlined,
              color: AppColors.primary,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(dateText, style: AppTextStyles.mediumBlackBold),
                SizedBox(height: 2.h),
                Text(subtitle, style: AppTextStyles.smallGrey),
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
    );
  }

  // ==========================================
  // TAB 3: hisab (Accounts Tab)
  // ==========================================
  Widget _buildAccountsTab() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Billing & Client Payment Summary Card
        AppCard(
          child: Column(
            children: [
              _buildAccountRow('ঠিক করা মজুরি', '৳২৬,০০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),
              _buildAccountRow('বাড়তি কাজের বিল', '৳২,০০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),
              _buildAccountRow('মোট বিল', '৳২৮,০০০', AppColors.primary),
              Divider(height: 16.h, color: AppColors.border),
              _buildAccountRow(
                'ক্লায়েন্ট দিয়েছেন',
                '৳১৮,০০০',
                const Color(0xFF079455),
              ),
              Divider(height: 16.h, color: AppColors.border),
              _buildAccountRow('ক্লায়েন্টের বাকি', '৳১০,০০০', Colors.red),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Action Buttons Row: Wage / Extra Bill & Add Expense
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.wageAndExpenseScreen, arguments: 0);
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 46.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit_outlined,
                          color: AppColors.primary, size: 18.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'মজুরি / বাড়তি বিল',
                        style: AppTextStyles.custom(
                          size: 13.sp,
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
              child: InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.wageAndExpenseScreen, arguments: 2);
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 46.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: AppColors.primary, size: 18.sp),
                      SizedBox(width: 6.w),
                      Text(
                        'খরচ লিখুন',
                        style: AppTextStyles.custom(
                          size: 13.sp,
                          color: AppColors.primary,
                          weight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 12.h),

        // Expenses & Estimated Profit Summary Card
        AppCard(
          child: Column(
            children: [
              _buildAccountRow('কর্মীর মজুরি', '৳৭,০০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),
              _buildAccountRow('অন্য খরচ', '৳১,৫০০', AppColors.textPrimary),
              Divider(height: 16.h, color: AppColors.border),
              _buildAccountRow(
                'আনুমানিক লাভ',
                '৳১৯,৫০০',
                const Color(0xFF079455),
              ),
            ],
          ),
        ),

        SizedBox(height: 12.h),

        // Info Notice Box
        _buildInfoNoticeBox('মোট বিল – কর্মীর মজুরি – অন্য খরচ = লাভ।'),

        SizedBox(height: 24.h),

        // Bottom Action Buttons Row
        Row(
          children: [
            Expanded(
              child: InkWell(
                onTap: () {
                  Get.snackbar('ফাইনাল বিল', 'ফাইনাল বিল জেনারেট হচ্ছে...');
                },
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  height: 48.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.description_outlined,
                        color: AppColors.primary,
                        size: 20.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        'ফাইনাল বিল',
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
                  Get.toNamed(AppRoutes.clientPaymentScreen);
                },
                text: 'ক্লায়েন্টের টাকা নিন',
                icon: Icons.payments_outlined,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Account Row Helper
  Widget _buildAccountRow(String title, String amount, Color amountColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: AppTextStyles.mediumGrey),
        Text(
          amount,
          style: AppTextStyles.custom(
            size: 15.sp,
            color: amountColor,
            weight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // Info Notice Box Helper
  Widget _buildInfoNoticeBox(String message) {
    return Container(
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
              message,
              style: AppTextStyles.custom(
                size: 12.sp,
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Summary Grid Card Item Helper
class _SummaryCardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconBgColor;
  final Color iconColor;
  final Color valueColor;

  const _SummaryCardItem({
    required this.icon,
    required this.title,
    required this.value,
    required this.iconBgColor,
    required this.iconColor,
    required this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Container(
                width: 28.w,
                height: 28.w,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: iconColor, size: 16.sp),
              ),
              SizedBox(width: 6.w),
              Expanded(
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.smallGrey.copyWith(fontSize: 11.sp),
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: AppTextStyles.custom(
              size: 20.sp,
              color: valueColor,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
