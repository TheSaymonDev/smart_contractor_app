import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';

class AppTabHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? action;

  const AppTabHeader({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.apartment,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
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
            icon,
            color: Colors.white,
            size: 24.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.custom(
                size: 20.sp,
                color: AppColors.textPrimary,
                weight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 2.h),
            Text(
              subtitle,
              style: AppTextStyles.smallGrey,
            ),
          ],
        ),
        if (action != null) ...[
          const Spacer(),
          action!,
        ],
      ],
    );
  }
}
