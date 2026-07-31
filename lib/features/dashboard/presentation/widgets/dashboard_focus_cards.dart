/// Focus and AI entry cards for the dashboard command center.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/material.dart';

/// Primary contextual action shown near the top of the dashboard.
class PrimaryFocusCard extends StatelessWidget {
  /// Creates a primary focus card.
  const PrimaryFocusCard({
    required this.title,
    required this.description,
    required this.actionLabel,
    required this.onAction,
    this.icon = Icons.arrow_forward_rounded,
    super.key,
  });

  /// Focus title.
  final String title;

  /// Focus explanation.
  final String description;

  /// Action label.
  final String actionLabel;

  /// Action callback.
  final VoidCallback onAction;

  /// Leading icon.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DashboardSurface(
      tone: DashboardSurfaceTone.navy,
      padding: const EdgeInsets.all(AppSpacing.space24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: AppColors.onPrimary.withValues(alpha: 0.12),
                  borderRadius: AppRadius.borderMedium,
                ),
                child: const Icon(
                  Icons.flag_outlined,
                  color: AppColors.onPrimary,
                ),
              ),
              const SizedBox(width: AppSpacing.space12),
              Text(
                'NEXT BEST ACTION',
                style: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.onPrimary.withValues(alpha: 0.62),
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space20),
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.onPrimary.withValues(alpha: 0.72),
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          SizedBox(
            height: 48,
            child: FilledButton.icon(
              onPressed: onAction,
              style: FilledButton.styleFrom(
                backgroundColor: AppColors.onPrimary,
                foregroundColor: AppColors.primaryDarkBlue,
              ),
              icon: Icon(icon, size: 18),
              label: Text(actionLabel),
            ),
          ),
        ],
      ),
    );
  }
}

/// Entry point to the AI workspace with a specific productivity suggestion.
class AiCopilotCard extends StatelessWidget {
  /// Creates an AI Copilot card.
  const AiCopilotCard({
    required this.title,
    required this.description,
    required this.onAction,
    super.key,
  });

  /// Suggested AI action title.
  final String title;

  /// Suggested AI action description.
  final String description;

  /// Launch callback.
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DashboardSurface(
      tone: DashboardSurfaceTone.subtle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
              const SizedBox(width: AppSpacing.space8),
              Expanded(
                child: Text('AI CO-PILOT', style: theme.textTheme.labelLarge),
              ),
              const Icon(Icons.arrow_outward_rounded, size: 18),
            ],
          ),
          const SizedBox(height: AppSpacing.space16),
          Text(title, style: theme.textTheme.titleLarge),
          const SizedBox(height: AppSpacing.space8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.secondaryText,
              height: 1.4,
            ),
          ),
          const SizedBox(height: AppSpacing.space16),
          TextButton.icon(
            onPressed: onAction,
            icon: const Icon(Icons.arrow_forward_rounded, size: 18),
            label: const Text('Open AI Workspace'),
          ),
        ],
      ),
    );
  }
}
