/// Personalized dashboard header for the command center.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/material.dart';

/// Header displaying the current user, workspace, and useful context.
class DashboardHeaderWidget extends StatelessWidget {
  /// Creates a [DashboardHeaderWidget].
  const DashboardHeaderWidget({
    required this.userName,
    required this.workspaceName,
    required this.productivityScore,
    required this.creditsRemaining,
    required this.onNewProjectPressed,
    required this.onRefreshPressed,
    super.key,
  });

  /// Active user display name.
  final String userName;

  /// Active workspace name.
  final String workspaceName;

  /// Current productivity score.
  final int productivityScore;

  /// Remaining AI credits.
  final int creditsRemaining;

  /// Primary creation callback.
  final VoidCallback onNewProjectPressed;

  /// Refresh callback.
  final VoidCallback onRefreshPressed;

  String get _greeting {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  String get _initials {
    final words = userName.trim().split(RegExp(r'\s+'));
    if (words.isEmpty || words.first.isEmpty) return 'AH';
    if (words.length == 1) return words.first.substring(0, 1).toUpperCase();
    return '${words.first.substring(0, 1)}${words.last.substring(0, 1)}'
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompact = MediaQuery.sizeOf(context).width < 600;
    return DashboardSurface(
      tone: DashboardSurfaceTone.navy,
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.onPrimary.withValues(alpha: 0.14),
                child: Text(
                  _initials,
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppColors.onPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workspaceName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.72),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    Text(
                      'Your freelance command center',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.onPrimary.withValues(alpha: 0.52),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                tooltip: 'Refresh dashboard',
                onPressed: onRefreshPressed,
                icon: const Icon(
                  Icons.refresh_rounded,
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space24),
          Text(
            '$_greeting, $userName.',
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            'Let’s turn today’s opportunities into progress.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.onPrimary.withValues(alpha: 0.68),
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          Wrap(
            spacing: AppSpacing.space8,
            runSpacing: AppSpacing.space8,
            children: [
              if (productivityScore > 0)
                _HeaderStat(
                  icon: Icons.auto_awesome_rounded,
                  label: 'AI score',
                  value: '$productivityScore/100',
                ),
              if (creditsRemaining > 0)
                _HeaderStat(
                  icon: Icons.bolt_rounded,
                  label: 'Credits left',
                  value: '$creditsRemaining',
                ),
              SizedBox(
                height: 48,
                child: FilledButton.icon(
                  onPressed: onNewProjectPressed,
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColors.onPrimary,
                    foregroundColor: AppColors.primaryDarkBlue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.borderPill,
                    ),
                  ),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(isCompact ? 'New' : 'New Project'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({required this.icon, required this.label, required this.value});

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space12),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.10),
        borderRadius: AppRadius.borderMedium,
        border: Border.all(color: AppColors.onPrimary.withValues(alpha: 0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 18, color: AppColors.onPrimary),
          const SizedBox(width: AppSpacing.space8),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.onPrimary.withValues(alpha: 0.58),
                ),
              ),
              Text(
                value,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.onPrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
