/// Cinematic, swipeable onboarding experience.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/brand_identity_header.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/onboarding_visual.dart';
import 'package:ai_hustle_copilot/shared/widgets/app_brand_background.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hero onboarding screen for new and returning users.
class WelcomeScreen extends StatefulWidget {
  /// Creates a [WelcomeScreen].
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  static const _pages = [
    _OnboardingStory(
      eyebrow: 'Welcome',
      title: 'Find work that fits your edge.',
      description:
          'Surface better opportunities, understand the brief, and decide where your energy pays off.',
      icon: Icons.explore_rounded,
    ),
    _OnboardingStory(
      eyebrow: 'Create',
      title: 'Turn good thinking into polished work.',
      description:
          'Use your AI co-pilot to shape proposals, documents, and follow-ups without losing your voice.',
      icon: Icons.auto_awesome_rounded,
    ),
    _OnboardingStory(
      eyebrow: 'Momentum',
      title: 'Run the whole hustle from one calm place.',
      description:
          'See what matters now, keep every client detail close, and build a rhythm that compounds.',
      icon: Icons.trending_up_rounded,
    ),
  ];

  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _continue() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: AppMotion.medium,
        curve: AppMotion.decelerateCurve,
      );
    } else {
      context.pushNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
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
          child: SafeArea(
            child: Column(
              children: [
                Row(
                  children: [
                    const Expanded(child: BrandIdentityHeader()),
                    TextButton(
                      onPressed: () => context.pushNamed(RouteNames.login),
                      child: const Text(
                        'Skip',
                        style: TextStyle(color: AppColors.onPrimary),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.space16),
                  ],
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _pages.length,
                    onPageChanged: (index) {
                      setState(() => _currentPage = index);
                    },
                    itemBuilder: (context, index) =>
                        _StoryPage(story: _pages[index], pageIndex: index),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.space24,
                    AppSpacing.space8,
                    AppSpacing.space24,
                    AppSpacing.space24,
                  ),
                  child: Column(
                    children: [
                      _PageIndicator(
                        count: _pages.length,
                        current: _currentPage,
                      ),
                      const SizedBox(height: AppSpacing.space24),
                      AppButton(
                        text: _currentPage == _pages.length - 1
                            ? 'Sign in'
                            : 'Continue',
                        height: 56,
                        variant: AppButtonVariant.secondary,
                        trailingIcon: Icons.arrow_forward_rounded,
                        onPressed: _continue,
                      ),
                      if (_currentPage == _pages.length - 1) ...[
                        const SizedBox(height: AppSpacing.space8),
                        AppButton(
                          text: 'Create account',
                          variant: AppButtonVariant.ghost,
                          onPressed: () =>
                              context.pushNamed(RouteNames.register),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StoryPage extends StatelessWidget {
  const _StoryPage({required this.story, required this.pageIndex});

  final _OnboardingStory story;
  final int pageIndex;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth >= 760;
        final visual = ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: isWide ? 430 : 300,
            maxHeight: isWide ? 430 : 300,
          ),
          child: OnboardingVisual(
            key: ValueKey('onboarding-visual-$pageIndex'),
            icon: story.icon,
          ),
        );
        final copy = _StoryCopy(story: story);

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: isWide ? AppSpacing.space64 : AppSpacing.space24,
            vertical: AppSpacing.space16,
          ),
          child: isWide
              ? Row(
                  children: [
                    Expanded(child: Center(child: visual)),
                    const SizedBox(width: AppSpacing.space48),
                    Expanded(child: copy),
                  ],
                )
              : Column(
                  children: [
                    Expanded(child: Center(child: visual)),
                    copy,
                  ],
                ),
        );
      },
    );
  }
}

class _StoryCopy extends StatelessWidget {
  const _StoryCopy({required this.story});

  final _OnboardingStory story;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          story.eyebrow,
          style: textTheme.labelLarge?.copyWith(
            color: AppColors.accentCoral,
            letterSpacing: 1.6,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        Text(
          story.title,
          style: textTheme.displaySmall?.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w800,
            height: 1.05,
          ),
        ),
        const SizedBox(height: AppSpacing.space16),
        Text(
          story.description,
          style: textTheme.bodyLarge?.copyWith(
            color: AppColors.onPrimary.withValues(alpha: 0.72),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Page ${current + 1} of $count',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(
          count,
          (index) => AnimatedContainer(
            duration: AppMotion.fast,
            width: index == current ? 28 : 8,
            height: 8,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: index == current
                  ? AppColors.accentCoral
                  : AppColors.onPrimary.withValues(alpha: 0.24),
              borderRadius: AppRadius.borderPill,
            ),
          ),
        ),
      ),
    );
  }
}

class _OnboardingStory {
  const _OnboardingStory({
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.icon,
  });

  final String eyebrow;
  final String title;
  final String description;
  final IconData icon;
}
