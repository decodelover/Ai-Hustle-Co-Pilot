/// Enterprise AuthHeaderWidget for brand identity, animated logo, and title.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Reusable authentication header widget featuring AI logo badge, gradient glow,
/// headline, and descriptive subtitle.
class AuthHeaderWidget extends StatelessWidget {
  /// Creates an [AuthHeaderWidget].
  const AuthHeaderWidget({
    required this.title,
    required this.subtitle,
    super.key,
    this.logoSize = 64.0,
  });

  /// Header title string.
  final String title;

  /// Header subtitle description string.
  final String subtitle;

  /// Logo dimension square size.
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return ScaleIn(
      child: FadeIn(
        child: Column(
          children: [
            // ── Animated AI Logo Badge ──────────────────────────────
            Container(
              width: logoSize,
              height: logoSize,
              decoration: BoxDecoration(
                borderRadius: AppRadius.borderXLarge,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    isDark ? AppColors.darkPrimary : AppColors.primary,
                    isDark ? AppColors.darkSecondary : AppColors.secondary,
                  ],
                ),
                boxShadow: isDark ? AppShadows.darkAiGlow : AppShadows.lightAiGlow,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 32.0,
                color: AppColors.onPrimary,
              ),
            ),
            const SizedBox(height: AppSpacing.space24),

            // ── Headline Title ──────────────────────────────────────
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),

            // ── Subtitle Description ────────────────────────────────
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark
                    ? AppColors.darkOnSurfaceVariant
                    : AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
