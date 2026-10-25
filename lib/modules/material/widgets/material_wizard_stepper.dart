import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';
import 'package:smart_contractor_app/core/utils/app_text_styles.dart';

class MaterialWizardStepper extends StatelessWidget {
  final int currentStep;

  const MaterialWizardStepper({
    super.key,
    required this.currentStep,
  });

  @override
  Widget build(BuildContext context) {
    final steps = [
      {'step': 1, 'label': 'বাছুন'},
      {'step': 2, 'label': 'তালিকা'},
      {'step': 3, 'label': 'তথ্য'},
      {'step': 4, 'label': 'PDF'},
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 20.w),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(steps.length, (index) {
          final stepNum = steps[index]['step'] as int;
          final label = steps[index]['label'] as String;

          final bool isPassed = currentStep > stepNum;
          final bool isCurrent = currentStep == stepNum;

          return Expanded(
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Step Number Circle Badge
                    Container(
                      width: 28.w,
                      height: 28.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isPassed
                            ? const Color(0xFFE8F8F0)
                            : (isCurrent
                                ? AppColors.primary
                                : const Color(0xFFEFF3F8)),
                        border: Border.all(
                          color: isPassed
                              ? const Color(0xFF079455)
                              : (isCurrent
                                  ? AppColors.primary
                                  : AppColors.border),
                          width: 1.5,
                        ),
                      ),
                      child: isPassed
                          ? Icon(
                              Icons.check_rounded,
                              size: 16.sp,
                              color: const Color(0xFF079455),
                            )
                          : Text(
                              '$stepNum',
                              style: AppTextStyles.custom(
                                size: 13.sp,
                                color: isCurrent
                                    ? Colors.white
                                    : AppColors.textSecondary,
                                weight: FontWeight.w700,
                              ),
                            ),
                    ),

                    SizedBox(height: 4.h),

                    // Label
                    Text(
                      label,
                      style: AppTextStyles.custom(
                        size: 11.sp,
                        color: isCurrent
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        weight: isCurrent ? FontWeight.w700 : FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                // Connecting Line
                if (index < steps.length - 1)
                  Expanded(
                    child: Container(
                      height: 2.h,
                      margin: EdgeInsets.only(bottom: 16.h, left: 4.w, right: 4.w),
                      color: isPassed ? const Color(0xFF079455) : AppColors.border,
                    ),
                  ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
