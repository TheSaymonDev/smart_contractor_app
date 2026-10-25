import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';

class AppTextField extends StatelessWidget {
  final String? label;
  final Widget? labelWidget;
  final String hint;
  final IconData? icon;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? suffixText;
  final int maxLines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final bool readOnly;
  final bool isRequired;
  final TextStyle? textStyle;
  final Color? fillColor;
  final double borderRadius;

  const AppTextField({
    super.key,
    this.label,
    this.labelWidget,
    required this.hint,
    this.icon,
    this.prefixIcon,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
    this.suffixText,
    this.maxLines = 1,
    this.onTap,
    this.onChanged,
    this.validator,
    this.readOnly = false,
    this.isRequired = false,
    this.textStyle,
    this.fillColor,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelWidget != null) ...[
          labelWidget!,
          SizedBox(height: 6.h),
        ] else if (label != null) ...[
          RichText(
            text: TextSpan(
              text: label,
              style: AppTextStyles.mediumBlackBold,
              children: isRequired
                  ? [
                      TextSpan(
                        text: ' *',
                        style: AppTextStyles.mediumBlackBold.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ]
                  : [],
            ),
          ),
          SizedBox(height: 6.h),
        ],

        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          maxLines: maxLines,
          readOnly: readOnly,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          style: textStyle ?? AppTextStyles.mediumBlackBold,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.mediumGrey,
            prefixIcon: prefixIcon ??
                (icon != null
                    ? Icon(
                        icon,
                        color: AppColors.textSecondary,
                        size: 20.sp,
                      )
                    : null),
            suffixIcon: suffixIcon,
            suffixText: suffixText,
            suffixStyle: AppTextStyles.mediumBlackBold,
            filled: true,
            fillColor: fillColor ?? Colors.white,
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 12.w),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: const BorderSide(color: AppColors.border, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: const BorderSide(
                color: AppColors.primary,
                width: 1.5,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide: const BorderSide(color: AppColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius.r),
              borderSide:
                  const BorderSide(color: AppColors.error, width: 1.5),
            ),
          ),
        ),
      ],
    );
  }
}
