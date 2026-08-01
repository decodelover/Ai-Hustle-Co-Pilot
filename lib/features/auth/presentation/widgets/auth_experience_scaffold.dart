/// Responsive public-facing shell for onboarding and authentication.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_brand_panel.dart';
import 'package:ai_hustle_copilot/shared/widgets/app_brand_background.dart';
import 'package:flutter/material.dart';

/// Combines the cinematic brand story and a focused authentication surface.
class AuthExperienceScaffold extends StatelessWidget {
  /// Creates an authentication experience shell.
  const AuthExperienceScaffold({
    required this.eyebrow,
    required this.headline,
    required this.description,
    required this.formTitle,
    required this.formDescription,
    required this.child,
    super.key,
    this.icon = Icons.auto_awesome_rounded,
    this.onBack,
  });

  /// Short contextual label above the brand story.
  final String eyebrow;

  /// Main brand story headline.
  final String headline;

  /// Supporting brand story copy.
  final String description;

  /// Form surface heading.
  final String formTitle;

  /// Form surface supporting copy.
  final String formDescription;

  /// Form or status content.
  final Widget child;

  /// Symbol used by the atmospheric visual.
  final IconData icon;

  /// Optional back action.
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBrandBackground(
        variant: AppBrandBackgroundVariant.shell,
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 840;
              if (isWide) {
                return Row(
                  children: [
                    Expanded(
                      flex: constraints.maxWidth >= 1280 ? 5 : 4,
                      child: AuthBrandPanel(
                        eyebrow: eyebrow,
                        headline: headline,
                        description: description,
                        icon: icon,
                        onBack: onBack,
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: _FormViewport(
                        title: formTitle,
                        description: formDescription,
                        child: child,
                      ),
                    ),
                  ],
                );
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: AppSpacing.space24),
                child: Column(
                  children: [
                    SizedBox(
                      height:
                          248 +
                          (MediaQuery.textScalerOf(context).scale(1) - 1).clamp(
                                0,
                                1,
                              ) *
                              72,
                      child: AuthBrandPanel(
                        eyebrow: eyebrow,
                        headline: headline,
                        description: description,
                        icon: icon,
                        onBack: onBack,
                        compact: true,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -20),
                      child: _FormCard(
                        title: formTitle,
                        description: formDescription,
                        child: child,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _FormViewport extends StatelessWidget {
  const _FormViewport({
    required this.title,
    required this.description,
    required this.child,
  });

  final String title;
  final String description;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return ColoredBox(
      color: isDark ? AppColors.darkBackground : AppColors.background,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.space40),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 500),
            child: _FormCard(
              title: title,
              description: description,
              elevated: false,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}

class _FormCard extends StatelessWidget {
  const _FormCard({
    required this.title,
    required this.description,
    required this.child,
    this.elevated = true,
  });

  final String title;
  final String description;
  final Widget child;
  final bool elevated;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      width: double.infinity,
      margin: elevated
          ? const EdgeInsets.symmetric(horizontal: AppSpacing.space16)
          : EdgeInsets.zero,
      padding: EdgeInsets.all(elevated ? AppSpacing.space24 : 0),
      decoration: elevated
          ? BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.surface,
              borderRadius: AppRadius.borderXLarge,
              border: Border.all(
                color: isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.outlineVariant,
              ),
              boxShadow: isDark ? AppShadows.darkMd : AppShadows.lightMd,
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: -0.6,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
          Text(
            description,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark
                  ? AppColors.darkOnSurfaceVariant
                  : AppColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.space24),
          child,
        ],
      ),
    );
  }
}
