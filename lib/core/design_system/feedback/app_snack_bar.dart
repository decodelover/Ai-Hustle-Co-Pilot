/// Reusable AppSnackBar utility providing static helpers for success, error,
/// warning, and info notifications via ScaffoldMessenger.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 SnackBar notification helper.
abstract class AppSnackBar {
  /// Displays a green success SnackBar notification.
  static void showSuccess(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      message: message,
      bgLight: AppColors.success,
      bgDark: AppColors.darkSuccess,
      fgLight: AppColors.onSuccess,
      fgDark: AppColors.darkOnSuccess,
      icon: Icons.check_circle_outline_rounded,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Displays a red error/failure SnackBar notification.
  static void showError(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      message: message,
      bgLight: AppColors.danger,
      bgDark: AppColors.darkDanger,
      fgLight: AppColors.onDanger,
      fgDark: AppColors.darkOnDanger,
      icon: Icons.error_outline_rounded,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Displays an amber warning SnackBar notification.
  static void showWarning(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      message: message,
      bgLight: AppColors.warning,
      bgDark: AppColors.darkWarning,
      fgLight: AppColors.onWarning,
      fgDark: AppColors.darkOnWarning,
      icon: Icons.warning_amber_rounded,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  /// Displays a blue info SnackBar notification.
  static void showInfo(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    _show(
      context,
      message: message,
      bgLight: AppColors.info,
      bgDark: AppColors.darkInfo,
      fgLight: AppColors.onInfo,
      fgDark: AppColors.darkOnInfo,
      icon: Icons.info_outline_rounded,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }

  static void _show(
    BuildContext context, {
    required String message,
    required Color bgLight,
    required Color bgDark,
    required Color fgLight,
    required Color fgDark,
    required IconData icon,
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? bgDark : bgLight;
    final fg = isDark ? fgDark : fgLight;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          elevation: 6.0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: bg,
          shape: const RoundedRectangleBorder(
            borderRadius: AppRadius.borderMedium,
          ),
          margin: const EdgeInsets.all(AppSpacing.space16),
          content: Row(
            children: [
              Icon(icon, size: 20.0, color: fg),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Text(
                  message,
                  style: TextStyle(
                    color: fg,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          action: actionLabel != null
              ? SnackBarAction(
                  label: actionLabel,
                  textColor: fg,
                  onPressed: onAction ?? () {},
                )
              : null,
        ),
      );
  }
}
