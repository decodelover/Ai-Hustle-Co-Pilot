/// Welcome surface introducing the product before authentication.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
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

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppMotion.slow,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: AppMotion.decelerateCurve,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: AppMotion.decelerateCurve,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _animationController.value = 1;
    } else if (!_animationController.isAnimating &&
        _animationController.value == 0) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToLogin() => context.pushNamed(RouteNames.login);

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBrandBackground(
        variant: AppBrandBackgroundVariant.welcome,
        headerHeight: 334,
        header: Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.space24,
            AppSpacing.space16,
            AppSpacing.space24,
            AppSpacing.space24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const _BrandMark(),
                  const SizedBox(width: AppSpacing.space12),
                  Text(
                    'AI Hustle Co-Pilot',
                    style: textTheme.titleLarge?.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Text(
                'Turn your next opportunity\ninto forward motion.',
                style: textTheme.displaySmall?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                  height: 1.12,
                ),
              ),
              const SizedBox(height: AppSpacing.space12),
              Text(
                'A calm workspace for finding work, creating stronger proposals, and staying on top of every client detail.',
                style: textTheme.bodyLarge?.copyWith(
                  color: AppColors.onPrimary.withValues(alpha: 0.76),
                  height: 1.45,
                ),
              ),
            ],
          ),
        ),
        child: SafeArea(
          top: false,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(
                  AppSpacing.space24,
                  AppSpacing.space32,
                  AppSpacing.space24,
                  bottomInset + AppSpacing.space24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome',
                      style: textTheme.displayMedium?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    Text(
                      'Discover legitimate opportunities, use AI to move faster, and build a freelance practice you can be proud of.',
                      style: textTheme.bodyLarge?.copyWith(
                        color: AppColors.secondaryText,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space24),
                    const _ValueRow(
                      icon: Icons.explore_outlined,
                      title: 'Find the right work',
                      description: 'See opportunities that fit your strengths.',
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    const _ValueRow(
                      icon: Icons.edit_note_rounded,
                      title: 'Create with confidence',
                      description: 'Draft proposals, documents, and follow-ups with AI support.',
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    const _ValueRow(
                      icon: Icons.track_changes_rounded,
                      title: 'Keep momentum',
                      description: 'Organize projects and know what to do next.',
                    ),
                    const SizedBox(height: AppSpacing.space32),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: Semantics(
                        button: true,
                        label: 'Get started with AI Hustle Co-Pilot',
                        child: FilledButton.icon(
                          onPressed: _navigateToLogin,
                          icon: const Icon(Icons.arrow_forward_rounded),
                          label: const Text('Get Started'),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    Center(
                      child: TextButton(
                        onPressed: _navigateToLogin,
                        child: const Text('Already have an account? Sign in'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.onPrimary.withValues(alpha: 0.18)),
      ),
      child: const Icon(
        Icons.auto_awesome_rounded,
        color: AppColors.onPrimary,
        size: 20,
      ),
    );
  }
}

class _ValueRow extends StatelessWidget {
  const _ValueRow({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, color: AppColors.primary, size: 22),
        ),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: textTheme.titleMedium),
              const SizedBox(height: AppSpacing.space4),
              Text(
                description,
                style: textTheme.bodyMedium?.copyWith(
                  color: AppColors.secondaryText,
                  height: 1.35,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
