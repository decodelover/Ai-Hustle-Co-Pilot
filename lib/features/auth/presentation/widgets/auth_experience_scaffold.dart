/// Shared light-first shell for onboarding-adjacent authentication screens.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_brand_rail.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/brand_identity_header.dart';
import 'package:flutter/material.dart';

/// Presents the compact mobile auth composition and a composed wide layout.
///
/// This widget owns the public auth rhythm so login, registration, recovery,
/// and verification screens feel like one product rather than five templates.
class AuthExperienceScaffold extends StatelessWidget {
  /// Creates a shared auth shell.
  const AuthExperienceScaffold({
    required this.title,
    required this.subtitle,
    required this.child,
    super.key,
    this.kicker,
    this.onBack,
    this.headerAction,
  });

  /// Primary screen heading.
  final String title;

  /// Supporting screen copy.
  final String subtitle;

  /// Optional small context label above the heading.
  final String? kicker;

  /// Form or status content.
  final Widget child;

  /// Optional back action for nested auth routes.
  final VoidCallback? onBack;

  /// Optional action rendered opposite the brand mark.
  final Widget? headerAction;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final background = isDark ? AppColors.darkBackground : AppColors.background;

    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth >= 880) {
              return Row(
                children: [
                  const Expanded(flex: 5, child: AuthBrandRail()),
                  Expanded(
                    flex: 6,
                    child: _WideAuthContent(
                      title: title,
                      subtitle: subtitle,
                      kicker: kicker,
                      onBack: onBack,
                      headerAction: headerAction,
                      child: child,
                    ),
                  ),
                ],
              );
            }

            return SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.space20,
                AppSpacing.space16,
                AppSpacing.space20,
                AppSpacing.space32,
              ),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _AuthHeader(onBack: onBack, headerAction: headerAction),
                      const SizedBox(height: AppSpacing.space32),
                      _AuthHeading(
                        title: title,
                        subtitle: subtitle,
                        kicker: kicker,
                      ),
                      const SizedBox(height: AppSpacing.space24),
                      child,
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({required this.onBack, required this.headerAction});

  final VoidCallback? onBack;
  final Widget? headerAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BrandIdentityHeader(
            onBack: onBack,
            onDarkSurface: false,
            showTagline: false,
            compact: true,
          ),
        ),
        ?headerAction,
      ],
    );
  }
}

class _WideAuthContent extends StatelessWidget {
  const _WideAuthContent({
    required this.title,
    required this.subtitle,
    required this.kicker,
    required this.child,
    required this.onBack,
    required this.headerAction,
  });

  final String title;
  final String subtitle;
  final String? kicker;
  final Widget child;
  final VoidCallback? onBack;
  final Widget? headerAction;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SingleChildScrollView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space48,
        vertical: AppSpacing.space32,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _AuthHeader(onBack: onBack, headerAction: headerAction),
              const SizedBox(height: AppSpacing.space40),
              _AuthHeading(title: title, subtitle: subtitle, kicker: kicker),
              const SizedBox(height: AppSpacing.space24),
              DecoratedBox(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.surface,
                  borderRadius: AppRadius.borderLarge,
                  border: Border.all(
                    color: isDark
                        ? AppColors.darkOutlineVariant
                        : AppColors.outline,
                  ),
                  boxShadow: isDark ? AppShadows.darkSm : AppShadows.lightSm,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.space32),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthHeading extends StatelessWidget {
  const _AuthHeading({
    required this.title,
    required this.subtitle,
    this.kicker,
  });

  final String title;
  final String subtitle;
  final String? kicker;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (kicker != null) ...[
          Text(
            kicker!.toUpperCase(),
            style: theme.textTheme.labelSmall?.copyWith(
              color: isDark ? AppColors.darkSecondary : AppColors.secondary,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppSpacing.space8),
        ],
        Text(
          title,
          style: theme.textTheme.headlineLarge?.copyWith(
            color: isDark ? AppColors.darkOnSurface : AppColors.primaryText,
            fontSize: 28,
            fontWeight: FontWeight.w800,
            height: 1.12,
            letterSpacing: -0.8,
          ),
        ),
        const SizedBox(height: AppSpacing.space8),
        Text(
          subtitle,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: isDark
                ? AppColors.darkOnSurfaceVariant
                : AppColors.secondaryText,
            height: 1.45,
          ),
        ),
      ],
    );
  }
}
