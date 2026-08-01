/// Rich recent-project previews backed by dashboard project data.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/recent_project_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Project progress, status, ownership, and AI health preview.
class RecentProjectsList extends StatelessWidget {
  /// Creates a [RecentProjectsList].
  const RecentProjectsList({required this.projects, super.key});

  final List<RecentProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return DashboardSurface(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardSectionHeader(
            eyebrow: 'Workspace',
            title: 'Recent projects',
            subtitle: 'The work carrying your momentum forward.',
            actionLabel: projects.isEmpty ? null : 'View all',
            onAction: projects.isEmpty
                ? null
                : () => context.go(RoutePaths.projects),
          ),
          const SizedBox(height: AppSpacing.space20),
          if (projects.isEmpty)
            const _ProjectsEmptyState()
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: projects.length,
              separatorBuilder: (_, _) =>
                  const SizedBox(height: AppSpacing.space12),
              itemBuilder: (context, index) => _ProjectCard(
                project: projects[index],
                index: index,
                onTap: () => context.go(RoutePaths.projects),
              ),
            ),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.project,
    required this.index,
    required this.onTap,
  });
  final RecentProjectModel project;
  final int index;
  final VoidCallback onTap;

  String get _statusLabel => switch (project.status) {
    ProjectStatus.inProgress => 'In progress',
    ProjectStatus.review => 'In review',
    ProjectStatus.completed => 'Complete',
    ProjectStatus.archived => 'Archived',
  };

  Color get _statusColor => switch (project.status) {
    ProjectStatus.inProgress => AppColors.secondary,
    ProjectStatus.review => AppColors.warning,
    ProjectStatus.completed => AppColors.success,
    ProjectStatus.archived => AppColors.onSurfaceVariant,
  };

  String get _activityLabel {
    final difference = DateTime.now().difference(project.lastUpdated);
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes.clamp(1, 59)}m ago';
    }
    if (difference.inHours < 24) return '${difference.inHours}h ago';
    if (difference.inDays < 7) return '${difference.inDays}d ago';
    return '${(difference.inDays / 7).floor()}w ago';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final percentage = (project.progress.clamp(0, 1) * 100).round();
    return DashboardSurface(
      tone: DashboardSurfaceTone.subtle,
      onTap: onTap,
      semanticLabel:
          '${project.title}, $_statusLabel, $percentage percent complete',
      padding: const EdgeInsets.all(AppSpacing.space12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProjectCover(index: index, title: project.title),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        project.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    Icon(
                      CupertinoIcons.chevron_forward,
                      size: 14,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  project.clientName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.space12),
                Row(
                  children: [
                    _StatusDot(color: _statusColor),
                    const SizedBox(width: AppSpacing.space4),
                    Text(
                      _statusLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space12),
                    Icon(
                      CupertinoIcons.clock,
                      size: 13,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    const SizedBox(width: AppSpacing.space4),
                    Text(
                      _activityLabel,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.space12),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: AppRadius.borderPill,
                        child: LinearProgressIndicator(
                          value: project.progress.clamp(0, 1),
                          minHeight: 6,
                          backgroundColor: AppColors.outline,
                          valueColor: AlwaysStoppedAnimation(_statusColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space8),
                    Text(
                      '$percentage%',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                if (project.aiUsageScore > 0 || project.tags.isNotEmpty) ...[
                  const SizedBox(height: AppSpacing.space12),
                  Wrap(
                    spacing: AppSpacing.space8,
                    runSpacing: AppSpacing.space4,
                    children: [
                      if (project.aiUsageScore > 0)
                        _MetaChip(
                          icon: CupertinoIcons.sparkles,
                          label: 'AI health ${project.aiUsageScore}%',
                          color: AppColors.success,
                        ),
                      ...project.tags
                          .take(2)
                          .map(
                            (tag) => _MetaChip(
                              icon: CupertinoIcons.tag,
                              label: tag,
                              color: AppColors.secondary,
                            ),
                          ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectCover extends StatelessWidget {
  const _ProjectCover({required this.index, required this.title});
  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 64,
      height: 82,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderMedium,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: index.isEven
              ? const [AppColors.primaryDarkBlue, AppColors.secondary]
              : const [AppColors.primaryBlue, AppColors.primaryDarkBlue],
        ),
      ),
      child: Text(
        title.isEmpty ? 'P' : title[0].toUpperCase(),
        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
          color: AppColors.onPrimary,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _StatusDot extends StatelessWidget {
  const _StatusDot({required this.color});
  final Color color;
  @override
  Widget build(BuildContext context) => Container(
    width: 7,
    height: 7,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
  );
}

class _MetaChip extends StatelessWidget {
  const _MetaChip({
    required this.icon,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(
      horizontal: AppSpacing.space8,
      vertical: AppSpacing.space4,
    ),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: AppRadius.borderPill,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: AppSpacing.space4),
        Text(
          label,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(color: color),
        ),
      ],
    ),
  );
}

class _ProjectsEmptyState extends StatelessWidget {
  const _ProjectsEmptyState();
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: AppSpacing.space24),
    child: Column(
      children: [
        const Icon(
          CupertinoIcons.folder_open,
          color: AppColors.secondary,
          size: 32,
        ),
        const SizedBox(height: AppSpacing.space12),
        Text(
          'No active projects yet',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.space4),
        Text(
          'Create a project to bring documents, tasks, and AI context together.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    ),
  );
}
