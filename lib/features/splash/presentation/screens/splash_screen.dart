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
    final isDark = context.isDarkMode;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkBackground : AppColors.background,
        ),
        child: Center(
          child: ScaleIn(
            duration: AppMotion.slow,
            child: FadeIn(
              duration: AppMotion.slow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 96.0,
                    height: 96.0,
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.borderXLarge,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          isDark ? AppColors.darkPrimary : AppColors.primary,
                          isDark
                              ? AppColors.darkSecondary
                              : AppColors.secondary,
                        ],
                      ),
                      boxShadow: isDark
                          ? AppShadows.darkAiGlow
                          : AppShadows.lightAiGlow,
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      size: 48.0,
                      color: AppColors.onPrimary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space24),
                  Text(
                    'AI Hustle',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: isDark
                          ? AppColors.darkOnSurface
                          : AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space4),
                  Text(
                    'CO-PILOT',
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: isDark ? AppColors.darkPrimary : AppColors.primary,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3.0,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.space48),
                  const AppLoadingIndicator(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
