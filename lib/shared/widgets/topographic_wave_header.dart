/// Reusable Topographic Wave Header component — Master Design System V2.0.
///
/// Features smooth organic contour/topographic line patterns over a primary dark blue
/// gradient (#0D1B2A -> #152A4D) with an organic curved bezier divider.
library;

import 'dart:math' as math;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Topographic contour line painter drawing elegant brand wave patterns.
class TopographicWavePainter extends CustomPainter {
  /// Creates a [TopographicWavePainter].
  const TopographicWavePainter({
    this.lineColor = AppColors.secondary,
    this.bottomCurveColor = Colors.white,
    this.showBottomCurve = true,
    this.motionProgress = 1,
    this.curveTop = 0.72,
    this.curveDip = 0.96,
  });

  /// Color for contour lines.
  final Color lineColor;

  /// Color of the bottom transitioning curve.
  final Color bottomCurveColor;

  /// Whether to draw the bottom organic curve transition into white surface.
  final bool showBottomCurve;

  /// Finite entrance-motion progress for the contour pattern and curve.
  final double motionProgress;

  /// Fraction of the header where the white surface begins at the left edge.
  final double curveTop;

  /// Fraction of the header reached by the deepest point of the curve.
  final double curveDip;

  @override
  void paint(Canvas canvas, Size size) {
    // ── 1. Base Dark Blue Gradient Fill ────────────────────────────────────
    final rect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppColors.primaryDarkBlue,
          AppColors.primaryBlue,
          AppColors.deepNavy,
        ],
        stops: [0.0, 0.65, 1.0],
      ).createShader(rect);

    canvas.drawRect(rect, bgPaint);

    // ── 2. Topographic / Contour Line Overlay ──────────────────────────────
    final linePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6
      ..color = lineColor.withValues(alpha: 0.12);

    final linePaintGlow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withValues(alpha: 0.08);

    final drift = (0.5 - (motionProgress - 0.5).abs()) * size.width * 0.035;

    // Contour Line 1
    final path1 = Path()
      ..moveTo(-size.width * 0.2 + drift, size.height * 0.25)
      ..cubicTo(
        size.width * 0.2 + drift,
        size.height * 0.05,
        size.width * 0.6 + drift,
        size.height * 0.45,
        size.width * 1.2 + drift,
        size.height * 0.2,
      );
    canvas.drawPath(path1, linePaint);

    // Contour Line 2
    final path2 = Path()
      ..moveTo(-size.width * 0.1 - drift, size.height * 0.45)
      ..cubicTo(
        size.width * 0.3 - drift,
        size.height * 0.2,
        size.width * 0.75 - drift,
        size.height * 0.65,
        size.width * 1.15 - drift,
        size.height * 0.38,
      );
    canvas.drawPath(path2, linePaintGlow);

    // Contour Line 3
    final path3 = Path()
      ..moveTo(-size.width * 0.15 + drift, size.height * 0.65)
      ..cubicTo(
        size.width * 0.25 + drift,
        size.height * 0.4,
        size.width * 0.7 + drift,
        size.height * 0.8,
        size.width * 1.1 + drift,
        size.height * 0.55,
      );
    canvas.drawPath(path3, linePaint);

    // Contour Line 4
    final path4 = Path()
      ..moveTo(size.width * 0.1 - drift, size.height * 0.1)
      ..cubicTo(
        size.width * 0.5 - drift,
        size.height * 0.35,
        size.width * 0.85 - drift,
        size.height * 0.15,
        size.width * 1.25 - drift,
        size.height * 0.45,
      );
    canvas.drawPath(path4, linePaintGlow);

    // Contour Line 5 (Subtle background loop)
    final path5 = Path()
      ..moveTo(-size.width * 0.05 + drift, size.height * 0.8)
      ..cubicTo(
        size.width * 0.35 + drift,
        size.height * 0.55,
        size.width * 0.65 + drift,
        size.height * 0.9,
        size.width * 1.05 + drift,
        size.height * 0.7,
      );
    canvas.drawPath(path5, linePaint);

    // ── 3. Bottom Organic Bezier Curve Transition ──────────────────────────
    if (showBottomCurve) {
      final curveMotion =
          math.sin(motionProgress * math.pi) * size.height * 0.018;
      final leftY = size.height * curveTop + curveMotion;
      final dipY = size.height * curveDip - curveMotion;
      final rightY = size.height * (curveTop + 0.04) + curveMotion;
      final curvePath = Path()
        ..moveTo(0, leftY)
        ..cubicTo(
          size.width * 0.18,
          leftY - size.height * 0.09,
          size.width * 0.34,
          leftY - size.height * 0.04,
          size.width * 0.52,
          dipY - size.height * 0.06,
        )
        ..cubicTo(
          size.width * 0.72,
          dipY + size.height * 0.04,
          size.width * 0.86,
          dipY - size.height * 0.08,
          size.width,
          rightY,
        )
        ..lineTo(size.width, size.height)
        ..lineTo(0, size.height)
        ..close();

      final curvePaint = Paint()..color = bottomCurveColor;
      canvas.drawPath(curvePath, curvePaint);
    }
  }

  @override
  bool shouldRepaint(covariant TopographicWavePainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.bottomCurveColor != bottomCurveColor ||
        oldDelegate.showBottomCurve != showBottomCurve ||
        oldDelegate.motionProgress != motionProgress ||
        oldDelegate.curveTop != curveTop ||
        oldDelegate.curveDip != curveDip;
  }
}

/// Reusable Topographic Header widget taking height and custom child.
class WaveHeaderWidget extends StatelessWidget {
  /// Creates a [WaveHeaderWidget].
  const WaveHeaderWidget({
    super.key,
    this.height = 280.0,
    this.bottomCurveColor = AppColors.background,
    this.showBottomCurve = true,
    this.motionProgress = 1,
    this.curveTop = 0.72,
    this.curveDip = 0.96,
    this.child,
  });

  /// Total height of the header.
  final double height;

  /// Background color of the transitioning surface below.
  final Color bottomCurveColor;

  /// Whether to draw the organic bottom curve transition.
  final bool showBottomCurve;

  /// Finite animation progress used by the contour treatment.
  final double motionProgress;

  /// Fraction where the white surface begins on the left edge.
  final double curveTop;

  /// Fraction reached by the deepest part of the white curve.
  final double curveDip;

  /// Optional child overlay content inside the header.
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: CustomPaint(
        painter: TopographicWavePainter(
          bottomCurveColor: bottomCurveColor,
          showBottomCurve: showBottomCurve,
          motionProgress: motionProgress,
          curveTop: curveTop,
          curveDip: curveDip,
        ),
        child: child,
      ),
    );
  }
}
