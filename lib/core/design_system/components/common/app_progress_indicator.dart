/// Reusable Progress Indicator component for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Progress bar indicator displaying linear completion percentage.
class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    required this.progress,
    super.key,
    this.label,
    this.height = 8.0,
    this.color,
    this.backgroundColor,
    this.showPercentage = true,
  });

  /// Progress value between 0.0 and 1.0.
  final double progress;
  final String? label;
  final double height;
  final Color? color;
  final Color? backgroundColor;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final activeColor = color ?? theme.colorScheme.primary;
    final trackColor =
        backgroundColor ?? theme.colorScheme.surfaceContainerHighest;
    final percentageInt = (progress * 100).clamp(0, 100).toInt();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null || showPercentage) ...[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (label != null)
                Text(
                  label!,
                  style: AppTypography.labelMedium.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              if (showPercentage)
                Text(
                  '$percentageInt%',
                  style: AppTypography.labelSmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
        ],
        ClipRRect(
          borderRadius: AppRadius.borderRadiusFull,
          child: LinearProgressIndicator(
            value: progress.clamp(0.0, 1.0),
            minHeight: height,
            backgroundColor: trackColor,
            valueColor: AlwaysStoppedAnimation<Color>(activeColor),
          ),
        ),
      ],
    );
  }
}
