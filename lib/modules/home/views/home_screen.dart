import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';
import 'package:smart_contractor_app/modules/main/controllers/main_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top Header
            _buildTopHeader(),

            SizedBox(height: 14.h),

            // Material PDF Generator Banner
            _buildPdfBannerCard(),

            SizedBox(height: 16.h),

            // Section 1: Today Status
            _buildTodayStatusSection(),

            SizedBox(height: 16.h),

            // Section 2: Quick Actions
            _buildQuickActionsSection(),

            SizedBox(height: 16.h),

            // Section 3: Running Jobs
            _buildRunningJobsSection(),
          ],
        ),
      ),
    );
  }

  // Top Header
  Widget _buildTopHeader() {
    return Row(
      children: [
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.apartment,
            color: Colors.white,
            size: 26.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Smart Contractor',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'রহমান কন্ট্রাক্টর সার্ভিস',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ],
    );
  }

  // Material PDF Generator Banner Card
  Widget _buildPdfBannerCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'মালামালের PDF তৈরি করুন',
            style: AppTextStyles.custom(
              size: 20.sp,
              color: Colors.white,
              weight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            'টেমপ্লেট বাছুন অথবা নিজে তালিকা লিখুন',
            style: AppTextStyles.custom(
              size: 13.sp,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          SizedBox(height: 14.h),
          InkWell(
            onTap: () {
              Get.toNamed(AppRoutes.materialTemplateCategoriesScreen);
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.description_outlined,
                    color: AppColors.primary,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'তালিকা তৈরি করুন',
                    style: AppTextStyles.custom(
                      size: 14.sp,
                      color: AppColors.primary,
                      weight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chevron_right_rounded,
                    color: AppColors.primary,
                    size: 22.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Today's Status Section
  Widget _buildTodayStatusSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('আজকের অবস্থা', style: AppTextStyles.mediumBlackBold),
            Text(
              '২৩ অক্টোবর',
              style: AppTextStyles.custom(
                size: 13.sp,
                color: AppColors.primary,
                weight: FontWeight.w700,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: 8.h,
          crossAxisSpacing: 8.w,
          childAspectRatio: 1.85,
          children: const [
            _StatusCard(
              icon: Icons.work_outline_rounded,
              title: 'চলছে এমন কাজ',
              value: '৩টি',
              iconBgColor: AppColors.primaryLight,
              iconColor: AppColors.primary,
              valueColor: AppColors.primary,
            ),
            _StatusCard(
              icon: Icons.groups_outlined,
              title: 'আজ হাজির',
              value: '৮ জন',
              iconBgColor: Color(0xFFE8F8F0),
              iconColor: Color(0xFF079455),
              valueColor: Color(0xFF079455),
            ),
            _StatusCard(
              icon: Icons.payments_outlined,
              title: 'ক্লায়েন্টের কাছে পাওনা',
              value: '৳১০,০০০',
              iconBgColor: Color(0xFFFFEBEB),
              iconColor: Colors.red,
              valueColor: Colors.red,
            ),
            _StatusCard(
              icon: Icons.account_balance_wallet_outlined,
              title: 'কর্মীকে দিতে হবে',
              value: '৳৫,৪০০',
              iconBgColor: Color(0xFFFFF4E5),
              iconColor: Color(0xFFE66A00),
              valueColor: Color(0xFFE66A00),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('এই মাসে পাওয়া', style: AppTextStyles.smallGrey),
              Text(
                '৳৭৪,০০০',
                style: AppTextStyles.custom(
                  size: 14.sp,
                  color: const Color(0xFF079455),
                  weight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Quick Actions Section
  Widget _buildQuickActionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('দ্রুত কাজ', style: AppTextStyles.mediumBlackBold),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: _QuickActionCard(
                icon: Icons.add_rounded,
                label: 'নতুন কাজ',
                onTap: () {
                  Get.toNamed(AppRoutes.jobManagementScreen);
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.calendar_month_outlined,
                label: 'হাজিরা দিন',
                onTap: () {
                  if (Get.isRegistered<MainController>()) {
                    Get.find<MainController>().changeTab(2);
                  } else {
                    Get.toNamed(AppRoutes.attendanceScreen);
                  }
                },
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _QuickActionCard(
                icon: Icons.payments_outlined,
                label: 'কর্মীকে টাকা দিন',
                onTap: () {
                  if (Get.isRegistered<MainController>()) {
                    Get.find<MainController>().changeTab(3);
                  } else {
                    Get.toNamed(AppRoutes.workerManagementScreen);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Running Jobs Section
  Widget _buildRunningJobsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('চলমান কাজ', style: AppTextStyles.mediumBlackBold),
            InkWell(
              onTap: () {
                if (Get.isRegistered<MainController>()) {
                  Get.find<MainController>().changeTab(1);
                }
              },
              child: Text(
                'সব দেখুন',
                style: AppTextStyles.custom(
                  size: 13.sp,
                  color: AppColors.primary,
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        AppCard(
          onTap: () {
            Get.toNamed(AppRoutes.jobDetailsScreen);
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
                  Icons.work_outline_rounded,
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
                      'করিমের বাসা',
                      style: AppTextStyles.mediumBlackBold,
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      'বাথরুমের পানির লাইন',
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
        ),
      ],
    );
  }
}

// Individual Today Status Card Helper
class _StatusCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color iconBgColor;
  final Color iconColor;
  final Color valueColor;

  const _StatusCard({
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

// Individual Quick Action Card Helper
class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 8.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: AppColors.primary,
            size: 24.sp,
          ),
          SizedBox(height: 8.h),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.custom(
              size: 12.sp,
              color: AppColors.textPrimary,
              weight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
