import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'HindSiliguri';

  // Font sizes
  static double get smallSize => 12.sp;
  static double get mediumSize => 16.sp;
  static double get largeSize => 20.sp;

  // Common text style builder
  static TextStyle _style({
    required double size,
    required Color color,
    FontWeight weight = FontWeight.w400,
    double height = 1.2,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  // =========================
  // Small
  // =========================

  static TextStyle get smallBlack => _style(
    size: smallSize,
    color: AppColors.textPrimary,
  );

  static TextStyle get smallGrey => _style(
    size: smallSize,
    color: AppColors.textSecondary,
  );

  static TextStyle get smallBlackBold => _style(
    size: smallSize,
    color: AppColors.textPrimary,
    weight: FontWeight.w700,
  );

  static TextStyle get smallGreyBold => _style(
    size: smallSize,
    color: AppColors.textSecondary,
    weight: FontWeight.w700,
  );

  // =========================
  // Medium
  // =========================

  static TextStyle get mediumBlack => _style(
    size: mediumSize,
    color: AppColors.textPrimary,
  );

  static TextStyle get mediumGrey => _style(
    size: mediumSize,
    color: AppColors.textSecondary,
  );

  static TextStyle get mediumBlackBold => _style(
    size: mediumSize,
    color: AppColors.textPrimary,
    weight: FontWeight.w700,
  );

  static TextStyle get mediumGreyBold => _style(
    size: mediumSize,
    color: AppColors.textSecondary,
    weight: FontWeight.w700,
  );

  // =========================
  // Large
  // =========================

  static TextStyle get largeBlack => _style(
    size: largeSize,
    color: AppColors.textPrimary,
  );

  static TextStyle get largeGrey => _style(
    size: largeSize,
    color: AppColors.textSecondary,
  );

  static TextStyle get largeBlackBold => _style(
    size: largeSize,
    color: AppColors.textPrimary,
    weight: FontWeight.w700,
  );

  static TextStyle get largeGreyBold => _style(
    size: largeSize,
    color: AppColors.textSecondary,
    weight: FontWeight.w700,
  );
}