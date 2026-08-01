/// Personalized premium welcome hero for the command center.
library;

import 'dart:math' as math;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Hero displaying user, workspace, date, plan, and productivity status.
class DashboardHeaderWidget extends StatelessWidget {
  /// Creates a [DashboardHeaderWidget].
  const DashboardHeaderWidget({
    required this.userName,
    required this.workspaceName,
    required this.productivityScore,
    required this.creditsRemaining,
    required this.onNewProjectPressed,
    required this.onRefreshPressed,
    super.key,
  });

  final String userName;
  final String workspaceName;
  final int productivityScore;
  final int creditsRemaining;
  final VoidCallback onNewProjectPressed;
  final VoidCallback onRefreshPressed;

  String get _greeting => DateTime.now().hour < 12
      ? 'Good morning'
      : DateTime.now().hour < 17
      ? 'Good afternoon'
      : 'Good evening';
  String get _dateLabel {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    final now = DateTime.now();
    return '${days[now.weekday - 1]}, ${months[now.month - 1]} ${now.day}';
  }

  String get _initials {
    final words = userName.trim().split(RegExp(r'\s+'));
    if (words.isEmpty || words.first.isEmpty || userName == 'there') {
      return 'AH';
    }
    return words.length == 1
        ? words.first[0].toUpperCase()
        : '${words.first[0]}${words.last[0]}'.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final compact = MediaQuery.sizeOf(context).width < 600;
    final identity = _HeroIdentity(
      initials: _initials,
      workspaceName: workspaceName,
      dateLabel: _dateLabel,
      isPro: creditsRemaining > 0,
      onRefresh: onRefreshPressed,
    );
    final welcome = _HeroWelcome(greeting: _greeting, userName: userName);
    final score = _HeroScore(
      score: productivityScore,
      credits: creditsRemaining,
    );
    final action = _HeroAction(onPressed: onNewProjectPressed);
    return Semantics(
      container: true,
      label:
          'Welcome to $workspaceName. Productivity score $productivityScore out of 100.',
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: AppRadius.borderXLarge,
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primaryDarkBlue, AppColors.primaryBlue],
          ),
          border: Border.all(color: AppColors.onPrimary, width: 0.5),
          boxShadow: [
            BoxShadow(
              color: AppColors.primaryDarkBlue.withValues(alpha: 0.24),
              offset: const Offset(0, 16),
              blurRadius: 40,
              spreadRadius: -18,
            ),
          ],
        ),
        child: Stack(
          children: [
            const Positioned.fill(
              child: CustomPaint(painter: _HeroContourPainter()),
            ),
            Positioned(
              right: -80,
              top: -100,
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.secondary.withValues(alpha: 0.28),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(
                compact ? AppSpacing.space20 : AppSpacing.space32,
              ),
              child: compact
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        identity,
                        const SizedBox(height: AppSpacing.space32),
                        welcome,
                        const SizedBox(height: AppSpacing.space24),
                        score,
                        const SizedBox(height: AppSpacing.space16),
                        action,
                      ],
                    )
                  : Column(
                      children: [
                        identity,
                        const SizedBox(height: AppSpacing.space32),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(flex: 6, child: welcome),
                            const SizedBox(width: AppSpacing.space32),
                            Expanded(flex: 4, child: score),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.space24),
                        Align(alignment: Alignment.centerLeft, child: action),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroIdentity extends StatelessWidget {
  const _HeroIdentity({
    required this.initials,
    required this.workspaceName,
    required this.dateLabel,
    required this.isPro,
    required this.onRefresh,
  });
  final String initials;
  final String workspaceName;
  final String dateLabel;
  final bool isPro;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          width: AppSpacing.space48,
          height: AppSpacing.space48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.onPrimary.withValues(alpha: 0.10),
            borderRadius: AppRadius.borderMedium,
            border: Border.all(
              color: AppColors.onPrimary.withValues(alpha: 0.16),
            ),
          ),
          child: Text(
            initials,
            style: text.titleMedium?.copyWith(
              color: AppColors.onPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.space12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                workspaceName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.titleMedium?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.space4),
              Text(
                dateLabel,
                style: text.bodySmall?.copyWith(
                  color: AppColors.onPrimary.withValues(alpha: 0.64),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.space12,
            vertical: AppSpacing.space8,
          ),
          decoration: BoxDecoration(
            color: AppColors.onPrimary.withValues(alpha: 0.10),
            borderRadius: AppRadius.borderPill,
            border: Border.all(
              color: AppColors.onPrimary.withValues(alpha: 0.14),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                CupertinoIcons.sparkles,
                size: 14,
                color: AppColors.onPrimary,
              ),
              const SizedBox(width: AppSpacing.space4),
              Text(
                isPro ? 'PRO' : 'STARTER',
                style: text.labelSmall?.copyWith(
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Refresh dashboard',
          onPressed: onRefresh,
          icon: const Icon(
            CupertinoIcons.refresh,
            color: AppColors.onPrimary,
            size: 20,
          ),
        ),
      ],
    );
  }
}

class _HeroWelcome extends StatelessWidget {
  const _HeroWelcome({required this.greeting, required this.userName});
  final String greeting;
  final String userName;
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$greeting, $userName.',
          style: text.displaySmall?.copyWith(
            color: AppColors.onPrimary,
            fontWeight: FontWeight.w700,
            height: 1.12,
            letterSpacing: -0.7,
          ),
        ),
        const SizedBox(height: AppSpacing.space12),
        Text(
          'Your AI workspace is ready. Pick one clear move and turn todayâ€™s momentum into meaningful progress.',
          style: text.bodyLarge?.copyWith(
            color: AppColors.onPrimary.withValues(alpha: 0.70),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}

class _HeroScore extends StatelessWidget {
  const _HeroScore({required this.score, required this.credits});
  final int score;
  final int credits;
  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final value = score.clamp(0, 100);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.08),
        borderRadius: AppRadius.borderLarge,
        border: Border.all(color: AppColors.onPrimary.withValues(alpha: 0.14)),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 70,
            height: 70,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: value / 100),
              duration: AppMotion.slow,
              curve: AppMotion.decelerateCurve,
              builder: (context, progress, child) => Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 6,
                    strokeCap: StrokeCap.round,
                    backgroundColor: AppColors.onPrimary.withValues(
                      alpha: 0.10,
                    ),
                    valueColor: const AlwaysStoppedAnimation(
                      AppColors.accentCoral,
                    ),
                  ),
                  Text(
                    '$value/100',
                    style: text.labelLarge?.copyWith(
                      color: AppColors.onPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.space16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AI Productivity Score',
                  style: text.titleSmall?.copyWith(
                    color: AppColors.onPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: AppSpacing.space4),
                Text(
                  value == 0
                      ? 'Build your first signal'
                      : 'Your focus is trending upward',
                  style: text.bodySmall?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.60),
                  ),
                ),
                if (credits > 0) ...[
                  const SizedBox(height: AppSpacing.space8),
                  Text(
                    '$credits AI credits available',
                    style: text.labelSmall?.copyWith(
                      color: AppColors.onPrimary.withValues(alpha: 0.82),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroAction extends StatelessWidget {
  const _HeroAction({required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed,
    style: FilledButton.styleFrom(
      minimumSize: const Size(0, AppSpacing.minTouchTarget),
      backgroundColor: AppColors.onPrimary,
      foregroundColor: AppColors.primaryDarkBlue,
      shape: const RoundedRectangleBorder(borderRadius: AppRadius.borderPill),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space20),
    ),
    icon: const Icon(CupertinoIcons.add, size: 18),
    label: const Text('New Project'),
  );
}

class _HeroContourPainter extends CustomPainter {
  const _HeroContourPainter();
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.onPrimary.withValues(alpha: 0.055)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    for (var index = 0; index < 9; index++) {
      final path = Path();
      final base = size.height * (0.16 + index * 0.095);
      path.moveTo(-20, base);
      for (var x = -20.0; x <= size.width + 20; x += 12) {
        path.lineTo(
          x,
          base +
              math.sin((x / size.width * math.pi * 3) + index * 0.7) *
                  (12 + index * 1.5),
        );
      }
      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
