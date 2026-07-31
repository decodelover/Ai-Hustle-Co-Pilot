/// Reusable Status Pill component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/theme/theme_extensions.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

enum AppStatusPillType { pending, inProgress, success, error, info }

/// Reusable status pill widget for application states (Pending, Active, Done, Failed).
class AppStatusPill extends StatelessWidget {
  const AppStatusPill({
    required this.label,
    super.key,
    this.type = AppStatusPillType.info,
    this.customColor,
  });

  final String label;
  final AppStatusPillType type;
  final Color? customColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customExt =
        theme.extension<AppCustomThemeExtension>() ??
        AppCustomThemeExtension.light;

    final statusColor =
        customColor ??
        switch (type) {
          AppStatusPillType.pending => customExt.statusPending,
          AppStatusPillType.inProgress => customExt.statusInProgress,
          AppStatusPillType.success => customExt.statusCompleted,
          AppStatusPillType.error => customExt.statusRejected,
          AppStatusPillType.info => theme.colorScheme.primary,
        };

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: statusColor.withValues(alpha: 0.12),
        borderRadius: AppRadius.borderRadiusFull,
        border: Border.all(color: statusColor.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: statusColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            label,
            style: AppTypography.labelSmall.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
