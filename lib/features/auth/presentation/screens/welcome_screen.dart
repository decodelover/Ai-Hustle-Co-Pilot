/// Premium Welcome onboarding screen with AppAuthBackground ambient glow & live carousel.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/app_auth_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hero welcome & animated onboarding screen.
class WelcomeScreen extends StatefulWidget {
  /// Creates a [WelcomeScreen].
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final PageController _pageController;
  Timer? _autoAdvanceTimer;
  int _currentPage = 0;

  final List<({String title, String subtitle, IconData icon, Color color})>
      _features = [
    (
      title: 'Smart Matching Engine',
      subtitle: 'Real-time high-paying opportunity discovery tailored to your skills',
      icon: Icons.psychology_rounded,
      color: AppColors.primary,
    ),
    (
      title: 'AI Proposal Writer',
      subtitle: 'Generate winning, highly tailored client applications in seconds',
      icon: Icons.auto_awesome_rounded,
      color: AppColors.secondary,
    ),
    (
      title: 'Workflow Automation',
      subtitle: 'Automate contracts, client follow-ups, and invoice reminders effortlessly',
      icon: Icons.bolt_rounded,
      color: AppColors.success,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    _pageController = PageController();

    _autoAdvanceTimer = Timer.periodic(const Duration(milliseconds: 3500), (_) {
      if (_pageController.hasClients) {
        final nextPage = (_currentPage + 1) % _features.length;
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOutCubic,
        );
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _pageController.dispose();
    _autoAdvanceTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    final isDark = context.isDarkMode;

    return AppAuthBackground(
      child: ResponsivePageContainer(
        child: AnimatedPage(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space24,
              vertical: AppSpacing.space16,
            ),
            child: Column(
              children: [
                const Spacer(),

                // ── Animated Pulsing Hero Badge ────────────────────────
                AnimatedBuilder(
                  animation: _pulseController,
                  builder: (context, child) {
                    final scale = 1.0 + (_pulseController.value * 0.08);
                    final glowOpacity = 0.35 + (_pulseController.value * 0.35);

                    return Transform.scale(
                      scale: scale,
                      child: Container(
                        width: 92.0,
                        height: 92.0,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              isDark ? AppColors.darkPrimary : AppColors.primary,
                              isDark ? AppColors.darkSecondary : AppColors.secondary,
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withValues(
                                alpha: glowOpacity,
                              ),
                              blurRadius: 36.0,
                              spreadRadius: 10.0,
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            size: 46.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: AppSpacing.space24),

                // ── Title & Subtitle ──────────────────────────────────
                Text(
                  'Supercharge Your Freelance Career',
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.space8),
                Text(
                  'AI-powered opportunity discovery, proposal generation, and workflow automation.',
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: AppSpacing.space24),

                // ── Live Animated Value Proposition Carousel ────────────
                SizedBox(
                  height: 140,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemCount: _features.length,
                    itemBuilder: (context, index) {
                      final feature = _features[index];

                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4.0),
                        padding: const EdgeInsets.all(AppSpacing.space16),
                        decoration: BoxDecoration(
                          color: isDark
                              ? const Color(0xFF1E1E2E).withValues(alpha: 0.85)
                              : Colors.white.withValues(alpha: 0.90),
                          borderRadius: BorderRadius.circular(AppRadius.lg),
                          border: Border.all(
                            color: (isDark
                                    ? AppColors.darkOutline
                                    : AppColors.outline)
                                .withValues(alpha: 0.6),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(
                                alpha: isDark ? 0.3 : 0.06,
                              ),
                              blurRadius: 16.0,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                color: feature.color.withValues(alpha: 0.15),
                                borderRadius:
                                    BorderRadius.circular(AppRadius.md),
                              ),
                              child: Icon(
                                feature.icon,
                                size: 24,
                                color: feature.color,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.space16),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feature.title,
                                    style: textTheme.titleMedium?.copyWith(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(height: AppSpacing.space4),
                                  Text(
                                    feature.subtitle,
                                    style: textTheme.bodySmall?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppSpacing.space12),

                // ── Carousel Indicator Dots ────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(_features.length, (index) {
                    final isSelected = index == _currentPage;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      width: isSelected ? 24.0 : 8.0,
                      height: 8.0,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(AppRadius.full),
                      ),
                    );
                  }),
                ),

                const Spacer(),

                // ── Action CTA Buttons ────────────────────────────────
                AppButton(
                  text: 'Sign In',
                  onPressed: () => context.pushNamed(RouteNames.login),
                ),
                const SizedBox(height: AppSpacing.space12),
                AppButton(
                  text: 'Create Account',
                  variant: AppButtonVariant.outlined,
                  onPressed: () => context.pushNamed(RouteNames.register),
                ),
                const SizedBox(height: AppSpacing.space16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
