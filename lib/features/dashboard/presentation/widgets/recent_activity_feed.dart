/// Restrained activity timeline for recent workspace changes.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/activity_feed_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/material.dart';

/// Recent activity feed.
class RecentActivityFeed extends StatelessWidget {
  /// Creates a [RecentActivityFeed].
  const RecentActivityFeed({required this.activities, super.key});

  /// Activity entries.
  final List<ActivityFeedModel> activities;

  @override
  Widget build(BuildContext context) {
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            title: 'Recent activity',
            subtitle: 'A quiet record of what changed.',
          ),
          const SizedBox(height: AppSpacing.space16),
          if (activities.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.space16),
              child: Text('Your latest activity will appear here.'),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              separatorBuilder: (context, index) =>
                  const Divider(height: AppSpacing.space24),
              itemBuilder: (context, index) => _ActivityRow(activities[index]),
            ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow(this.activity);

  final ActivityFeedModel activity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: AppRadius.borderMedium,
          ),
          child: Icon(activity.icon, color: AppColors.primary, size: 19),
        ),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(activity.title, style: theme.textTheme.titleSmall),
              const SizedBox(height: AppSpacing.space4),
              Text(
                activity.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.secondaryText,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
