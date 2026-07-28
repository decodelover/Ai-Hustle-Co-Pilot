/// Reusable Analytics Card component for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/design_system/components/cards/app_base_card.dart';
import 'package:ai_hustle_copilot/core/design_system/components/common/app_status_pill.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Analytics metric card displaying key metrics, trend percentages, and visual summary.
class AppAnalyticsCard extends StatelessWidget {
  const AppAnalyticsCard({
    required this.title,
    required this.value,
    required this.trendPercentage,
    super.key,
    this.subtitle = 'vs. last month',
    this.isPositiveTrend = true,
    this.icon,
    this.onTap,
  });

  final String title;
  final String value;
  final String trendPercentage;
  final String subtitle;
  final bool isPositiveTrend;
  final IconData? icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBaseCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTypography.titleSmall.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              if (icon != null)
                Icon(
                  icon,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            value,
            style: AppTypography.headlineMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              AppStatusPill(
                label: trendPercentage,
                type: isPositiveTrend
                    ? AppStatusPillType.success
                    : AppStatusPillType.error,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  subtitle,
                  style: AppTypography.labelSmall.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
