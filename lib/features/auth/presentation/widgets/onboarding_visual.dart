/// Animated, token-driven onboarding illustration.
library;

import 'dart:math' as math;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Renders a lightweight cinematic orbit around a feature symbol.
class OnboardingVisual extends StatefulWidget {
  /// Creates an onboarding visual.
  const OnboardingVisual({required this.icon, super.key});

  /// Center feature symbol.
  final IconData icon;

  @override
  State<OnboardingVisual> createState() => _OnboardingVisualState();
}

class _OnboardingVisualState extends State<OnboardingVisual>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0.12;
    } else if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'Animated AI workflow illustration',
      child: AspectRatio(
        aspectRatio: 1,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            return CustomPaint(
              painter: _OrbitPainter(progress: _controller.value),
              child: Center(
                child: Transform.translate(
                  offset: Offset(
                    0,
                    math.sin(_controller.value * math.pi * 2) * 5,
                  ),
                  child: Container(
                    width: 112,
                    height: 112,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [AppColors.secondary, AppColors.primary],
                      ),
                      borderRadius: AppRadius.borderXLarge,
                      border: Border.all(
                        color: AppColors.onPrimary.withValues(alpha: 0.28),
                      ),
                      boxShadow: AppShadows.darkAiGlow,
                    ),
                    child: Icon(
                      widget.icon,
                      size: 48,
                      color: AppColors.onPrimary,
                    ),
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

class _OrbitPainter extends CustomPainter {
  const _OrbitPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = size.shortestSide * 0.37;
    final orbit = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = AppColors.onPrimary.withValues(alpha: 0.16);
    canvas
      ..drawCircle(center, radius, orbit)
      ..drawCircle(center, radius * 0.72, orbit);

    for (var index = 0; index < 3; index++) {
      final angle = (progress + index / 3) * math.pi * 2;
      final point = Offset(
        center.dx + math.cos(angle) * radius,
        center.dy + math.sin(angle) * radius,
      );
      final dot = Paint()
        ..color = index == 0
            ? AppColors.accentCoral
            : AppColors.onPrimary.withValues(alpha: 0.72);
      canvas.drawCircle(point, index == 0 ? 6 : 4, dot);
    }
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) =>
      progress != oldDelegate.progress;
}
