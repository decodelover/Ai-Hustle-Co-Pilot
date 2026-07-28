/// Real-time PasswordStrengthWidget calculating length, numbers, and special characters.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Rating categories for password strength evaluation.
enum PasswordStrength {
  /// Weak password rating.
  weak,

  /// Fair password rating.
  fair,

  /// Good password rating.
  good,

  /// Strong password rating.
  strong,
}

/// Reusable password strength indicator widget with animated segment progress bars.
class PasswordStrengthWidget extends StatelessWidget {
  /// Creates a [PasswordStrengthWidget].
  const PasswordStrengthWidget({
    required this.password,
    super.key,
  });

  /// Password string to evaluate.
  final String password;

  /// Evaluates current password strength score (0 to 4).
  PasswordStrength get strength {
    if (password.isEmpty) return PasswordStrength.weak;

    var score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (RegExp('[A-Z]').hasMatch(password) && RegExp('[a-z]').hasMatch(password)) score++;
    if (RegExp('[0-9]').hasMatch(password) && RegExp(r'[@$!%*?&]').hasMatch(password)) score++;

    switch (score) {
      case 0:
      case 1:
        return PasswordStrength.weak;
      case 2:
        return PasswordStrength.fair;
      case 3:
        return PasswordStrength.good;
      case 4:
      default:
        return PasswordStrength.strong;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (password.isEmpty) return const SizedBox.shrink();

    final theme = context.theme;
    final isDark = context.isDarkMode;

    final (label, color, fillCount) = switch (strength) {
      PasswordStrength.weak => (
          'Weak password',
          isDark ? AppColors.darkDanger : AppColors.danger,
          1
        ),
      PasswordStrength.fair => (
          'Fair password',
          isDark ? AppColors.darkWarning : AppColors.warning,
          2
        ),
      PasswordStrength.good => (
          'Good password',
          isDark ? AppColors.darkPrimary : AppColors.primary,
          3
        ),
      PasswordStrength.strong => (
          'Strong password',
          isDark ? AppColors.darkSuccess : AppColors.success,
          4
        ),
    };

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSpacing.space8),
        Row(
          children: List.generate(
            4,
            (index) => Expanded(
              child: Container(
                height: 4.0,
                margin: EdgeInsets.only(
                  right: index < 3 ? AppSpacing.space4 : 0.0,
                ),
                decoration: BoxDecoration(
                  color: index < fillCount
                      ? color
                      : (isDark
                          ? AppColors.darkOutlineVariant
                          : AppColors.outlineVariant),
                  borderRadius: AppRadius.borderPill,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: color,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
