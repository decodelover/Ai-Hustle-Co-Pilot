/// Full-screen Splash screen displayed during app initialization.
///
/// Features AI logo glow animation, scale & fade entrance,
/// theme-aware background, and automatic auth-state-driven navigation.
library;

import 'package:ai_hustle_copilot/core/constants/app_constants.dart';
import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/domain/auth_state.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/onboarding_visual.dart';
import 'package:ai_hustle_copilot/shared/widgets/app_brand_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-screen splash with branding, animations, and auto-navigation.
class SplashScreen extends ConsumerStatefulWidget {
  /// Creates the splash screen.
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateAfterInitialization();
  }

  Future<void> _navigateAfterInitialization() async {
    await Future<void>.delayed(AppConstants.splashDuration);
    if (!mounted) return;

    if (GoRouter.maybeOf(context) == null) return;

    final authState = ref.read(authStateProvider);
    final currentState = authState.valueOrNull;

    if (currentState is Authenticated) {
      context.goNamed(RouteNames.dashboard);
    } else {
      context.goNamed(RouteNames.welcome);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBrandBackground(
        variant: AppBrandBackgroundVariant.shell,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.primaryDarkBlue, AppColors.primaryBlue],
            ),
          ),
          child: Center(
            child: ScaleIn(
              duration: AppMotion.slow,
              child: FadeIn(
                duration: AppMotion.slow,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 340),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(width: 220, child: OnboardingVisual()),
                      const SizedBox(height: AppSpacing.space16),
                      Text(
                        'AI Hustle',
                        style: theme.textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.onPrimary,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        'CO-PILOT',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.accentCoral,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 3.0,
                        ),
                      ),
                      const SizedBox(height: AppSpacing.space32),
                      const AppLoadingIndicator(color: AppColors.onPrimary),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
