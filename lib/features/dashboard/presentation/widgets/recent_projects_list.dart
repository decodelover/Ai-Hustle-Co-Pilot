/// Active work preview backed by the dashboard project data.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/recent_project_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Project progress and status preview.
class RecentProjectsList extends StatelessWidget {
  /// Creates a [RecentProjectsList].
  const RecentProjectsList({required this.projects, super.key});

  /// Active project list.
  final List<RecentProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardSectionHeader(
            title: 'Active work',
            subtitle: 'Projects that need your attention next.',
            actionLabel: projects.isEmpty ? null : 'View all',
            onAction: projects.isEmpty
                ? null
                : () => context.go(RoutePaths.projects),
          ),
          const SizedBox(height: AppSpacing.space16),
          if (projects.isEmpty)
            const _ProjectsEmptyState()
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.space12),
              itemBuilder: (context, index) => _ProjectRow(projects[index]),
            ),
        ],
      ),
    );
  }
}

class _ProjectRow extends StatelessWidget {
  const _ProjectRow(this.project);

  final RecentProjectModel project;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = project.status == ProjectStatus.review
        ? AppColors.warning
        : AppColors.primary;
    final percentage = (project.progress * 100).round();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: const BoxDecoration(
        color: AppColors.surfaceVariant,
        borderRadius: AppRadius.borderMedium,
        border: Border.fromBorderSide(BorderSide(color: AppColors.outline)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  project.title,
                  style: theme.textTheme.titleMedium,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.space8),
              if (project.aiUsageScore > 0)
                Text(
                  '${project.aiUsageScore}% AI',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.w700,
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            project.clientName,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.secondaryText,
            ),
          ),
          const SizedBox(height: AppSpacing.space12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: AppRadius.borderPill,
                  child: LinearProgressIndicator(
                    value: project.progress,
                    minHeight: 7,
                    backgroundColor: AppColors.outline,
                    valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Text('$percentage%', style: theme.textTheme.labelMedium),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProjectsEmptyState extends StatelessWidget {
  const _ProjectsEmptyState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.space16),
      child: Row(
        children: [
          Icon(Icons.folder_open_outlined, color: AppColors.secondary),
          SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text(
              'No active work yet. Start by exploring an opportunity or creating a project.',
            ),
          ),
        ],
      ),
    );
  }
}
