import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';
import 'package:smart_contractor_app/modules/attendance/views/attendance_screen.dart';
import 'package:smart_contractor_app/modules/home/views/home_screen.dart';
import 'package:smart_contractor_app/modules/job/views/jobs_screen.dart';
import 'package:smart_contractor_app/modules/main/controllers/main_controller.dart';
import 'package:smart_contractor_app/modules/more/views/more_screen.dart';
import 'package:smart_contractor_app/modules/worker/views/workers_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  final List<Widget> screens = const [
    HomeScreen(),
    JobsScreen(),
    AttendanceScreen(),
    WorkersScreen(),
    MoreScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: Get.isRegistered<MainController>()
          ? Get.find<MainController>()
          : Get.put(MainController()),
      builder: (controller) {
        return Scaffold(
          body: IndexedStack(
            index: controller.currentIndex,
            children: screens,
          ),
          bottomNavigationBar: _buildCustomBottomNavBar(controller),
        );
      },
    );
  }

  Widget _buildCustomBottomNavBar(MainController controller) {
    final navItems = [
      {
        'label': 'হোম',
        'icon': Icons.home_outlined,
        'activeIcon': Icons.home_rounded,
      },
      {
        'label': 'কাজ',
        'icon': Icons.work_outline_rounded,
        'activeIcon': Icons.work_rounded,
      },
      {
        'label': 'হাজিরা',
        'icon': Icons.calendar_month_outlined,
        'activeIcon': Icons.calendar_month,
      },
      {
        'label': 'কর্মী',
        'icon': Icons.groups_outlined,
        'activeIcon': Icons.groups_rounded,
      },
      {
        'label': 'আরও',
        'icon': Icons.more_horiz_rounded,
        'activeIcon': Icons.more_horiz_rounded,
      },
    ];

    return Container(
      height: 66.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: const Border(
          top: BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(navItems.length, (index) {
          final isSelected = controller.currentIndex == index;
          final item = navItems[index];

          return InkWell(
            onTap: () => controller.changeTab(index),
            borderRadius: BorderRadius.circular(14.r),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primaryLight : Colors.transparent,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isSelected
                        ? (item['activeIcon'] as IconData)
                        : (item['icon'] as IconData),
                    size: 22.sp,
                    color: isSelected
                        ? AppColors.primary
                        : const Color(0xFF5F6B7A),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    item['label'] as String,
                    style: AppTextStyles.custom(
                      size: 11.sp,
                      color: isSelected
                          ? AppColors.primary
                          : const Color(0xFF5F6B7A),
                      weight: isSelected ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
