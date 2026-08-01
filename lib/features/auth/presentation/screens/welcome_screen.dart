/// Mobile-first onboarding experience for AI Hustle Co-Pilot.
library;

import 'dart:math' as math;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/brand_identity_header.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/onboarding_visual.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Welcomes new users with a focused product story and one clear next step.
class WelcomeScreen extends StatelessWidget {
  /// Creates a [WelcomeScreen].
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final heroHeight = math.max(350.0, math.min(410.0, size.height * 0.53));

    return Scaffold(
      backgroundColor: isDark
          ? AppColors.darkBackground
          : AppColors.surfaceVariant,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              SizedBox(
                height: heroHeight,
                child: _OnboardingHero(
                  onSkip: () => context.pushNamed(RouteNames.login),
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -42),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space16,
                  ),
                  child: _OnboardingSheet(
                    onGetStarted: () => context.pushNamed(RouteNames.login),
                    onSignIn: () => context.pushNamed(RouteNames.login),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.space8),
            ],
          ),
        ),
      ),
    );
  }
}

class _OnboardingHero extends StatelessWidget {
  const _OnboardingHero({required this.onSkip});

  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _OnboardingHeroPainter(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.space20,
          AppSpacing.space16,
          AppSpacing.space20,
          AppSpacing.space32,
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: BrandIdentityHeader(showTagline: false, compact: true),
                ),
                TextButton(
                  onPressed: onSkip,
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.onPrimary,
                    minimumSize: const Size(48, 48),
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: Text(
                    'Skip',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: AppColors.onPrimary.withValues(alpha: 0.78),
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              'Welcome to AI\nHustle Co-Pilot!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.onPrimary,
                fontSize: 27,
                fontWeight: FontWeight.w800,
                height: 1.12,
                letterSpacing: -0.75,
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            Text(
              'Accelerate your hustle.\nScale smarter.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.onPrimary.withValues(alpha: 0.68),
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSheet extends StatelessWidget {
  const _OnboardingSheet({required this.onGetStarted, required this.onSignIn});

  final VoidCallback onGetStarted;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? AppColors.darkOnSurface : AppColors.primaryText;
    final secondaryColor = isDark
        ? AppColors.darkOnSurfaceVariant
        : AppColors.secondaryText;

    return Container(
      width: double.infinity,
      constraints: const BoxConstraints(maxWidth: 430),
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.space20,
        AppSpacing.space20,
        AppSpacing.space20,
        AppSpacing.space16,
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        borderRadius: AppRadius.borderXXLarge,
        border: Border.all(
          color: isDark ? AppColors.darkOutlineVariant : AppColors.outline,
        ),
        boxShadow: isDark ? AppShadows.darkLg : AppShadows.lightLg,
      ),
      child: Column(
        children: [
          const SizedBox(width: 280, child: OnboardingVisual()),
          const SizedBox(height: AppSpacing.space12),
          Text(
            'Set up your profile, define your goals,\nand start growing.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: textColor,
              fontWeight: FontWeight.w600,
              height: 1.45,
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          AppButton(text: 'Get Started', height: 52, onPressed: onGetStarted),
          const SizedBox(height: AppSpacing.space16),
          const _OnboardingIndicator(),
          const SizedBox(height: AppSpacing.space8),
          TextButton(
            onPressed: onSignIn,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              minimumSize: const Size(48, 40),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Text.rich(
              TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: secondaryColor, fontSize: 12),
                children: const [
                  TextSpan(
                    text: 'Sign in',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardingIndicator extends StatelessWidget {
  const _OnboardingIndicator();

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Onboarding step 1 of 4',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          4,
          (index) => Container(
            width: index == 0 ? 18 : 5,
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 3),
            decoration: BoxDecoration(
              color: index == 0 ? AppColors.primary : AppColors.outlineVariant,
              borderRadius: AppRadius.borderPill,
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingHeroPainter extends CustomPainter {
  const _OnboardingHeroPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = AppColors.primaryDarkBlue,
    );

    final contour = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.onPrimary.withValues(alpha: 0.08);
    for (var index = 0; index < 10; index++) {
      final path = Path();
      final y = size.height * 0.1 + index * 34;
      path
        ..moveTo(-100, y)
        ..cubicTo(
          size.width * 0.18,
          y - 58,
          size.width * 0.7,
          y + 70,
          size.width + 120,
          y - 24,
        );
      canvas.drawPath(path, contour);
    }

    final glow = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.secondary.withValues(alpha: 0.25),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.82, size.height * 0.22),
              radius: size.width * 0.62,
            ),
          );
    canvas.drawCircle(
      Offset(size.width * 0.82, size.height * 0.22),
      size.width * 0.62,
      glow,
    );
  }

  @override
  bool shouldRepaint(covariant _OnboardingHeroPainter oldDelegate) => false;
}
