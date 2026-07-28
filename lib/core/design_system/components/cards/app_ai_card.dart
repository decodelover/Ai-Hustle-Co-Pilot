/// Reusable AI Feature Card component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_primary_button.dart';
import 'package:ai_hustle_copilot/core/design_system/theme/theme_extensions.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_animation.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Card component with AI gradient accent styling for proposal generators & smart tools.
class AppAiCard extends StatelessWidget {
  const AppAiCard({
    required this.title,
    required this.description,
    super.key,
    this.actionLabel = 'Generate with AI',
    this.onAction,
    this.badgeText = 'AI Powered',
    this.isLoading = false,
  });

  final String title;
  final String description;
  final String actionLabel;
  final VoidCallback? onAction;
  final String badgeText;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final customExt = theme.extension<AppCustomThemeExtension>() ??
        AppCustomThemeExtension.light;

    return Container(
      decoration: BoxDecoration(
        borderRadius: AppRadius.borderRadiusMd,
        gradient: LinearGradient(
          colors: [
            customExt.aiGradientStart.withValues(alpha: 0.5),
            customExt.aiGradientEnd.withValues(alpha: 0.5),
          ],
        ),
      ),
      padding: const EdgeInsets.all(1.5),
      child: Container(
        padding: AppSpacing.paddingAllLg,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppRadius.md - 1.5),
          boxShadow: [
            BoxShadow(
              color: customExt.aiGlowColor,
              blurRadius: 20,
              spreadRadius: -2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AnimatedContainer(
                  duration: AppAnimation.normal,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        customExt.aiGradientStart,
                        customExt.aiGradientEnd,
                      ],
                    ),
                    borderRadius: AppRadius.borderRadiusSm,
                  ),
                  child: const Icon(
                    Icons.auto_awesome,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    title,
                    style: AppTypography.titleMedium.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: customExt.aiGradientStart.withValues(alpha: 0.12),
                    borderRadius: AppRadius.borderRadiusFull,
                    border: Border.all(
                      color: customExt.aiGradientStart.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Text(
                    badgeText,
                    style: AppTypography.labelSmall.copyWith(
                      color: customExt.aiGradientStart,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              description,
              style: AppTypography.bodyMedium.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            if (onAction != null) ...[
              const SizedBox(height: AppSpacing.lg),
              AppPrimaryButton(
                label: actionLabel,
                onPressed: onAction,
                icon: Icons.auto_awesome,
                isLoading: isLoading,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
