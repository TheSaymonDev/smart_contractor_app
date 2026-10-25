import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/config/routes/app_routes.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/core/widgets/app_card.dart';

class MoreMenuItemData {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const MoreMenuItemData({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });
}

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<MoreMenuItemData> menuItems = [
      MoreMenuItemData(
        icon: Icons.apartment,
        title: 'রহমান কন্ট্রাক্টর সার্ভিস',
        subtitle: 'রহমান আলী • মিরপুর-১০, ঢাকা',
        onTap: () {
          Get.toNamed(AppRoutes.businessSetupScreen);
        },
      ),
      MoreMenuItemData(
        icon: Icons.groups_outlined,
        title: 'ক্লায়েন্ট',
        subtitle: 'নাম, কাজ ও পাওনা',
        onTap: () {
          Get.toNamed(AppRoutes.clientsScreen);
        },
      ),
      MoreMenuItemData(
        icon: Icons.layers_outlined,
        title: 'মালামালের টেমপ্লেট',
        subtitle: 'প্রস্তুত তালিকা ও নিজের টেমপ্লেট',
        onTap: () {
          Get.toNamed(AppRoutes.materialTemplateCategoriesScreen);
        },
      ),
      MoreMenuItemData(
        icon: Icons.payments_outlined,
        title: 'কর্মীদের পেমেন্ট',
        subtitle: 'একজন বা একসাথে টাকা দিন',
        onTap: () {
          Get.toNamed(AppRoutes.workerPaymentHistoryScreen);
        },
      ),
      MoreMenuItemData(
        icon: Icons.description_outlined,
        title: 'তৈরি করা PDF',
        subtitle: 'পুরোনো PDF দেখুন ও শেয়ার করুন',
        onTap: () {
          Get.toNamed(AppRoutes.generatedPdfListScreen);
        },
      ),
      MoreMenuItemData(
        icon: Icons.bar_chart_rounded,
        title: 'রিপোর্ট',
        subtitle: 'মাসের কাজ ও হিসাব',
        onTap: () {
          Get.toNamed(AppRoutes.reportsScreen);
        },
      ),
      MoreMenuItemData(
        icon: Icons.apartment,
        title: 'ব্যবসার তথ্য',
        subtitle: 'PDF-এর নাম, ঠিকানা ও লোগো',
        onTap: () {
          Get.toNamed(AppRoutes.businessSetupScreen);
        },
      ),
      MoreMenuItemData(
        icon: Icons.help_outline_rounded,
        title: 'সেটিংস ও সাহায্য',
        subtitle: 'পাসওয়ার্ড, অ্যাকাউন্ট ও সহায়তা',
        onTap: () {
          Get.toNamed(AppRoutes.settingsAndHelpScreen);
        },
      ),
    ];

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 0),
        child: Column(
          children: [
            // Top Header Bar
            _buildHeader(),

            SizedBox(height: 14.h),

            // Menu Cards List
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.only(bottom: 16.h),
                itemCount: menuItems.length,
                separatorBuilder: (context, index) => SizedBox(height: 10.h),
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  return _buildMenuCard(item);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Header Bar Helper
  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 42.w,
          height: 42.w,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(
            Icons.apartment,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'আরও',
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              'আপনার ব্যবসার সবকিছু',
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
      ],
    );
  }

  // Menu Card Helper
  Widget _buildMenuCard(MoreMenuItemData item) {
    return AppCard(
      onTap: item.onTap,
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
              item.icon,
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
                  item.title,
                  style: AppTextStyles.custom(
                    size: 16.sp,
                    color: AppColors.textPrimary,
                    weight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  item.subtitle,
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
    );
  }
}
