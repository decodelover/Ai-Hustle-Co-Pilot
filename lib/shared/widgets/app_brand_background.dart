/// Shared navy background used across onboarding, authentication, and the shell.
library;

import 'dart:math' as math;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';

/// The presentation context that determines the amount of navy depth shown.
enum AppBrandBackgroundVariant { welcome, authentication, shell }

/// A quiet, reusable brand canvas for the product's public and private surfaces.
///
/// The component owns the topographic treatment and the restrained ambient
/// motion so screens cannot drift into separate background implementations.
class AppBrandBackground extends StatefulWidget {
  /// Creates a shared brand background.
  const AppBrandBackground({
    required this.child,
    this.variant = AppBrandBackgroundVariant.authentication,
    this.header,
    this.headerHeight,
    super.key,
  });

  /// Content rendered above the background.
  final Widget child;

  /// Visual context for the background.
  final AppBrandBackgroundVariant variant;

  /// Optional content rendered inside the navy header on public screens.
  final Widget? header;

  /// Optional fixed header height. If omitted, a responsive value is used.
  final double? headerHeight;

  @override
  State<AppBrandBackground> createState() => _AppBrandBackgroundState();
}

class _AppBrandBackgroundState extends State<AppBrandBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ambientController;

  @override
  void initState() {
    super.initState();
    _ambientController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.of(context).disableAnimations) {
      _ambientController
        ..stop()
        ..value = 0;
    } else if (!_ambientController.isAnimating) {
      _ambientController.forward();
    }
  }

  @override
  void dispose() {
    _ambientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final height = _resolveHeaderHeight(constraints.maxHeight);
        final isPublicSurface =
            widget.variant != AppBrandBackgroundVariant.shell;

        return Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(
              color: Theme.of(context).brightness == Brightness.dark
                  ? AppColors.darkBackground
                  : AppColors.background,
            ),
            AnimatedBuilder(
              animation: _ambientController,
              builder: (context, _) {
                return CustomPaint(
                  painter: _AmbientNavyPainter(
                    progress: _ambientController.value,
                    isShell: !isPublicSurface,
                  ),
                );
              },
            ),
            if (isPublicSurface)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: height,
                child: AnimatedBuilder(
                  animation: _ambientController,
                  builder: (context, _) => WaveHeaderWidget(
                    height: height,
                    motionProgress: _ambientController.value,
                    curveTop:
                        widget.variant == AppBrandBackgroundVariant.welcome
                        ? 0.70
                        : 0.72,
                    curveDip: 0.82,
                    child: widget.header == null
                        ? null
                        : SafeArea(child: widget.header!),
                  ),
                ),
              )
            else
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 224,
                child: WaveHeaderWidget(height: 224, showBottomCurve: false),
              ),
            if (isPublicSurface)
              Positioned(
                top: height * 0.74,
                left: 0,
                right: 0,
                bottom: 0,
                child: widget.child,
              )
            else
              Positioned.fill(child: widget.child),
          ],
        );
      },
    );
  }

  double _resolveHeaderHeight(double maxHeight) {
    if (widget.variant == AppBrandBackgroundVariant.shell) {
      return widget.headerHeight ?? 224;
    }

    final isWelcome = widget.variant == AppBrandBackgroundVariant.welcome;
    final targetRatio = isWelcome ? 0.62 : 0.55;
    final minimumHeight = isWelcome ? 360.0 : 320.0;
    final requestedHeight = widget.headerHeight ?? maxHeight * targetRatio;

    return math.min(maxHeight * 0.72, math.max(minimumHeight, requestedHeight));
  }
}

class _AmbientNavyPainter extends CustomPainter {
  const _AmbientNavyPainter({required this.progress, required this.isShell});

  final double progress;
  final bool isShell;

  @override
  void paint(Canvas canvas, Size size) {
    final travel = math.sin(progress * math.pi) * 22;
    final topCenter = Offset(size.width * 0.2 + travel, isShell ? 96 : 88);
    final bottomCenter = Offset(
      size.width * 0.82 - travel,
      isShell ? 176 : size.height * 0.18,
    );

    _drawGlow(canvas, topCenter, size.width * 0.46, AppColors.secondary);
    _drawGlow(canvas, bottomCenter, size.width * 0.38, AppColors.primaryBlue);
  }

  void _drawGlow(Canvas canvas, Offset center, double radius, Color color) {
    final paint = Paint()
      ..shader = RadialGradient(
        colors: [color.withValues(alpha: 0.18), Colors.transparent],
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant _AmbientNavyPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isShell != isShell;
}
