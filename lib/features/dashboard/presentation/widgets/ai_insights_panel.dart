/// Interactive AI recommendation cards panel.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_button.dart';
import 'package:ai_hustle_copilot/core/design_system/components/cards/app_card.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/insight_card_model.dart';
import 'package:flutter/material.dart';

/// Reusable AI insights panel offering recommendations and productivity suggestions.
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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return AppCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.auto_awesome,
                size: 20,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  'AI Recommendations & Tips',
                  style: textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),

          if (insights.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Text(
                  'No new recommendations at this time.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: insights.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final insight = insights[index];

                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              insight.title,
                              style: textTheme.labelLarge?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                iconSize: 16,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () => onToggleFavorite(insight.id),
                                icon: Icon(
                                  insight.isFavorite
                                      ? Icons.bookmark
                                      : Icons.bookmark_border,
                                  color: insight.isFavorite
                                      ? AppColors.primary
                                      : colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              IconButton(
                                iconSize: 16,
                                constraints: const BoxConstraints(),
                                padding: EdgeInsets.zero,
                                onPressed: () => onDismiss(insight.id),
                                icon: const Icon(Icons.close),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        insight.description,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      AppButton(
                        text: insight.actionLabel,
                        variant: AppButtonVariant.secondary,
                        icon: Icons.bolt_outlined,
                        onPressed: () {},
                      ),
                    ],
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
