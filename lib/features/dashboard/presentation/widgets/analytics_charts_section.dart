/// Data-backed progress signal for the dashboard.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/material.dart';

/// Shows a simple progress signal using values already available in state.
class AnalyticsChartsSection extends StatelessWidget {
  /// Creates an [AnalyticsChartsSection].
  const AnalyticsChartsSection({
    required this.selectedTimeframe,
    required this.onTimeframeChanged,
    this.productivityScore,
    this.activeProjects,
    super.key,
  });

  /// Selected timeframe filter.
  final ChartTimeframe selectedTimeframe;

  /// Timeframe change callback.
  final ValueChanged<ChartTimeframe> onTimeframeChanged;

  /// Current score from the dashboard state.
  final int? productivityScore;

  /// Active project count from the dashboard state.
  final int? activeProjects;

  @override
  Widget build(BuildContext context) {
    final scoreValue = (productivityScore ?? 0).clamp(0, 100);
    final score = scoreValue.toDouble();
    final theme = Theme.of(context);
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Progress signal', style: theme.textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      'A quick read from your current workspace data.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownButtonHideUnderline(
                child: DropdownButton<ChartTimeframe>(
                  value: selectedTimeframe,
                  borderRadius: AppRadius.borderMedium,
                  items: const [
                    DropdownMenuItem(
                      value: ChartTimeframe.weekly,
                      child: Text('Week'),
                    ),
                    DropdownMenuItem(
                      value: ChartTimeframe.monthly,
                      child: Text('Month'),
                    ),
                    DropdownMenuItem(
                      value: ChartTimeframe.yearly,
                      child: Text('Year'),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) onTimeframeChanged(value);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space24),
          if (scoreValue == 0)
            Text(
              'Progress data will appear here once your workspace has activity to measure.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.secondaryText,
                height: 1.4,
              ),
            )
          else ...[
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '$scoreValue',
                  style: theme.textTheme.displaySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Text(
                    ' / 100 productivity score',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.secondaryText,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.space12),
            ClipRRect(
              borderRadius: AppRadius.borderPill,
              child: LinearProgressIndicator(
                value: score / 100,
                minHeight: 10,
                backgroundColor: AppColors.primary.withValues(alpha: 0.10),
                valueColor: const AlwaysStoppedAnimation<Color>(
                  AppColors.primary,
                ),
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.space12),
          Text(
            activeProjects == null
                ? 'Keep completing focused work to build your trend.'
                : '$activeProjects active project${activeProjects == 1 ? '' : 's'} are contributing to your workspace momentum.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryText,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}
