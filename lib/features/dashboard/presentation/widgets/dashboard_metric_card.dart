/// Compact, accessible metric card for the dashboard overview.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:flutter/material.dart';

/// Reusable KPI card displaying a metric and its change indicator.
class DashboardMetricCard extends StatelessWidget {
  /// Creates a [DashboardMetricCard].
  const DashboardMetricCard({required this.model, this.onTap, super.key});

  /// Injected metric model.
  final DashboardMetricCardModel model;

  /// Optional tap handler.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final trendColor = model.isPositiveTrend
        ? AppColors.success
        : AppColors.danger;
    final iconColor = model.accentColor ?? AppColors.primary;

    return Semantics(
      label: '${model.title}: ${model.value}',
      button: onTap != null,
      child: Material(
        color: AppColors.surface,
        elevation: 1,
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderLarge,
          side: BorderSide(color: AppColors.outline),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: AppRadius.borderLarge,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: iconColor.withValues(alpha: 0.10),
                        borderRadius: AppRadius.borderMedium,
                      ),
                      child: Icon(model.icon, color: iconColor, size: 20),
                    ),
                    if (model.trendPercentage != 0)
                      _TrendPill(
                        value: model.trendPercentage,
                        color: trendColor,
                        positive: model.isPositiveTrend,
                      ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space12),
                Text(
                  model.title,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.secondaryText,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.space4),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    model.value,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                if (model.subtitle != null) ...[
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    model.subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TrendPill extends StatelessWidget {
  const _TrendPill({
    required this.value,
    required this.color,
    required this.positive,
  });

  final double value;
  final Color color;
  final bool positive;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: AppRadius.borderPill,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            positive ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
            size: 12,
            color: color,
          ),
          const SizedBox(width: 2),
          Text(
            '${value.abs().toStringAsFixed(1)}%',
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
