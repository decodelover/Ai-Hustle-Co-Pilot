/// AI recommendations panel with accessible feedback controls.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/insight_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Recommendation cards based on available dashboard insight data.
class AiInsightsPanel extends StatelessWidget {
  /// Creates an [AiInsightsPanel].
  const AiInsightsPanel({
    required this.insights,
    required this.onDismiss,
    required this.onToggleFavorite,
    super.key,
  });

  /// Insight models.
  final List<InsightCardModel> insights;

  /// Dismiss callback.
  final ValueChanged<String> onDismiss;

  /// Favorite callback.
  final ValueChanged<String> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            title: 'AI guidance',
            subtitle: 'Suggestions grounded in your workspace activity.',
          ),
          const SizedBox(height: AppSpacing.space16),
          if (insights.isEmpty)
            const _InsightsEmptyState()
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: insights.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.space12),
              itemBuilder: (context, index) {
                final insight = insights[index];
                return _InsightRow(
                  insight: insight,
                  onDismiss: () => onDismiss(insight.id),
                  onToggleFavorite: () => onToggleFavorite(insight.id),
                  onAction: () => context.go(
                    insight.targetRoute ?? RoutePaths.aiStudio,
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _InsightRow extends StatelessWidget {
  const _InsightRow({
    required this.insight,
    required this.onDismiss,
    required this.onToggleFavorite,
    required this.onAction,
  });

  final InsightCardModel insight;
  final VoidCallback onDismiss;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.borderMedium,
        border: Border.all(color: AppColors.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
              const SizedBox(width: AppSpacing.space8),
              Expanded(child: Text(insight.title, style: theme.textTheme.titleSmall)),
              IconButton(
                tooltip: insight.isFavorite ? 'Remove saved insight' : 'Save insight',
                onPressed: onToggleFavorite,
                icon: Icon(
                  insight.isFavorite
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                ),
              ),
              IconButton(
                tooltip: 'Dismiss insight',
                onPressed: onDismiss,
                icon: const Icon(Icons.close_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            insight.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          OutlinedButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.arrow_forward_rounded, size: 17),
            label: Text(insight.actionLabel),
          ),
        ],
      ),
    );
  }
}

class _InsightsEmptyState extends StatelessWidget {
  const _InsightsEmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.space16),
      child: Row(
        children: [
          Icon(Icons.lightbulb_outline_rounded, color: AppColors.secondary),
          SizedBox(width: AppSpacing.space12),
          Expanded(child: Text('No new guidance right now. Keep working and we’ll surface the next useful step.')),
        ],
      ),
    );
  }
}
