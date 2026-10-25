import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;

  final double? width;
  final double? height;

  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  final Color backgroundColor;
  final Color borderColor;

  final double borderRadius;
  final double borderWidth;
  final double elevation;

  final VoidCallback? onTap;

  const AppCard({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.backgroundColor = Colors.white,
    this.borderColor = AppColors.border,
    this.borderRadius = 12,
    this.borderWidth = 1,
    this.elevation = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(borderRadius.r),
      side: BorderSide(
        color: borderColor,
        width: borderWidth,
      ),
    );

    final content = SizedBox(
      width: width,
      height: height,
      child: Padding(
        padding: padding ?? EdgeInsets.all(12.w),
        child: child,
      ),
    );

    final card = Material(
      color: backgroundColor,
      elevation: elevation,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: onTap == null
          ? content
          : InkWell(
        onTap: onTap,
        customBorder: shape,
        child: content,
      ),
    );

    if (margin == null) {
      return card;
    }

    return Padding(
      padding: margin!,
      child: card,
    );
  }
}