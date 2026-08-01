/// Premium AI recommendations panel with actionable workspace intelligence.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/insight_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Recommendation callouts based on available dashboard insight data.
class AiInsightsPanel extends StatelessWidget {
  /// Creates an [AiInsightsPanel].
  const AiInsightsPanel({
    required this.insights,
    required this.onDismiss,
    required this.onToggleFavorite,
    super.key,
  });

  final List<InsightCardModel> insights;
  final ValueChanged<String> onDismiss;
  final ValueChanged<String> onToggleFavorite;

  @override
  Widget build(BuildContext context) {
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            eyebrow: 'AI intelligence',
            title: 'Insights for you',
            subtitle: 'Prioritized recommendations grounded in your workspace.',
          ),
          const SizedBox(height: AppSpacing.space20),
          if (insights.isEmpty)
            const _InsightsEmptyState()
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: insights.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.space12),
              itemBuilder: (context, index) {
                final insight = insights[index];
                return _InsightCard(
                  insight: insight,
                  onDismiss: () => onDismiss(insight.id),
                  onToggleFavorite: () => onToggleFavorite(insight.id),
                  onAction: () =>
                      context.go(insight.targetRoute ?? RoutePaths.aiStudio),
                );
              },
            ),
        ],
      ),
    );
  }
}

class _InsightCard extends StatelessWidget {
  const _InsightCard({
    required this.insight,
    required this.onDismiss,
    required this.onToggleFavorite,
    required this.onAction,
  });

  final InsightCardModel insight;
  final VoidCallback onDismiss;
  final VoidCallback onToggleFavorite;
  final VoidCallback onAction;

  String get _typeLabel => switch (insight.type) {
    InsightType.recommendation => 'Recommendation',
    InsightType.productivityTip => 'Productivity tip',
    InsightType.usageAlert => 'Usage alert',
    InsightType.automationSuggestion => 'Automation',
  };

  IconData get _icon => switch (insight.type) {
    InsightType.recommendation => CupertinoIcons.lightbulb,
    InsightType.productivityTip => CupertinoIcons.bolt,
    InsightType.usageAlert => CupertinoIcons.exclamationmark_circle,
    InsightType.automationSuggestion => CupertinoIcons.wand_stars,
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = insight.priority == InsightPriority.high
        ? AppColors.accentCoral
        : AppColors.secondary;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            accent.withValues(alpha: 0.10),
            accent.withValues(alpha: 0.025),
          ],
        ),
        borderRadius: AppRadius.borderLarge,
        border: Border.all(color: accent.withValues(alpha: 0.16)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: AppRadius.borderMedium,
                ),
                child: Icon(_icon, color: accent, size: 17),
              ),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text(
                  _typeLabel.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: accent,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.8,
                  ),
                ),
              ),
              _InsightIconButton(
                tooltip: insight.isFavorite
                    ? 'Remove saved insight'
                    : 'Save insight',
                icon: insight.isFavorite
                    ? CupertinoIcons.bookmark_fill
                    : CupertinoIcons.bookmark,
                onPressed: onToggleFavorite,
              ),
              _InsightIconButton(
                tooltip: 'Dismiss insight',
                icon: CupertinoIcons.xmark,
                onPressed: onDismiss,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space12),
          Text(
            insight.title,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            insight.description,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          Row(
            children: [
              if (insight.impactScore > 0) ...[
                const Icon(
                  CupertinoIcons.arrow_up_right,
                  size: 14,
                  color: AppColors.success,
                ),
                const SizedBox(width: AppSpacing.space4),
                Text(
                  '${insight.impactScore}% potential impact',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              const Spacer(),
              TextButton.icon(
                onPressed: onAction,
                iconAlignment: IconAlignment.end,
                icon: const Icon(CupertinoIcons.arrow_right, size: 14),
                label: Text(insight.actionLabel),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InsightIconButton extends StatelessWidget {
  const _InsightIconButton({
    required this.tooltip,
    required this.icon,
    required this.onPressed,
  });
  final String tooltip;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: tooltip,
    visualDensity: VisualDensity.compact,
    onPressed: onPressed,
    icon: Icon(icon, size: 17),
  );
}

class _InsightsEmptyState extends StatelessWidget {
  const _InsightsEmptyState();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.space20),
    child: Row(
      children: [
        const Icon(CupertinoIcons.sparkles, color: AppColors.secondary),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Text(
            'You’re all caught up. New recommendations will appear as your workspace evolves.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    ),
  );
}
