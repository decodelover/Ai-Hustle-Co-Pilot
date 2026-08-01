/// Linear-inspired timeline for recent workspace changes.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/activity_feed_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Recent activity timeline with timestamps and category signals.
class RecentActivityFeed extends StatelessWidget {
  /// Creates a [RecentActivityFeed].
  const RecentActivityFeed({required this.activities, super.key});

  final List<ActivityFeedModel> activities;

  @override
  Widget build(BuildContext context) {
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const DashboardSectionHeader(
            eyebrow: 'Live workspace',
            title: 'Recent activity',
            subtitle: 'Every meaningful change, in one calm timeline.',
          ),
          const SizedBox(height: AppSpacing.space20),
          if (activities.isEmpty)
            const _ActivityEmptyState()
          else
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activities.length,
              itemBuilder: (context, index) => _ActivityRow(
                activity: activities[index],
                isLast: index == activities.length - 1,
              ),
            ),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.activity, required this.isLast});
  final ActivityFeedModel activity;
  final bool isLast;

  IconData get _icon => switch (activity.category) {
    ActivityCategory.aiAction => CupertinoIcons.sparkles,
    ActivityCategory.project => CupertinoIcons.folder,
    ActivityCategory.document => CupertinoIcons.doc_text,
    ActivityCategory.automation => CupertinoIcons.wand_stars,
    ActivityCategory.marketplace => CupertinoIcons.square_grid_2x2,
    ActivityCategory.authentication => CupertinoIcons.person_crop_circle,
    ActivityCategory.system => CupertinoIcons.gear,
  };

  String get _timeLabel {
    final difference = DateTime.now().difference(activity.timestamp);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes.clamp(1, 59)}m';
    }
    if (difference.inHours < 24) return '${difference.inHours}h';
    if (difference.inDays < 7) return '${difference.inDays}d';
    return '${(difference.inDays / 7).floor()}w';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = activity.statusColor ?? AppColors.secondary;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 42,
            child: Column(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.10),
                    borderRadius: AppRadius.borderMedium,
                    border: Border.all(color: color.withValues(alpha: 0.16)),
                  ),
                  child: Icon(_icon, color: color, size: 16),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1,
                      margin: const EdgeInsets.symmetric(
                        vertical: AppSpacing.space4,
                      ),
                      color: theme.colorScheme.outline.withValues(alpha: 0.7),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.space20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          activity.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      Text(
                        _timeLabel,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    activity.description,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivityEmptyState extends StatelessWidget {
  const _ActivityEmptyState();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.space20),
    child: Row(
      children: [
        const Icon(CupertinoIcons.clock, color: AppColors.secondary),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Text(
            'Your timeline will come alive as you create, refine, and ship work.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    ),
  );
}
