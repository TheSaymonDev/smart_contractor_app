import 'package:flutter/material.dart';
import 'package:smart_contractor_app/core/utils/app_colors.dart';

class AppMessage {
  AppMessage._();

  static void success(BuildContext context, String message) {
    _show(context, message, AppColors.success, Icons.check_circle_outline);
  }

  static void error(BuildContext context, String message) {
    _show(context, message, AppColors.error, Icons.error_outline);
  }

  static void _show(
    BuildContext context,
    String message,
    Color accent,
    IconData icon,
  ) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();
    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          accent.withValues(alpha: 0.10),
          AppColors.surface,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: const Duration(seconds: 5),
        showCloseIcon: true,
        closeIconColor: AppColors.textPrimary,
        content: Row(
          children: [
            Icon(icon, color: accent),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(color: AppColors.textPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
