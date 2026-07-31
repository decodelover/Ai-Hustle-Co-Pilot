/// Reusable Topographic Wave Header component — Master Design System V2.0.
///
/// Features smooth organic contour/topographic line patterns over a primary dark blue
/// gradient (#0D1B2A -> #152A4D) with an organic curved bezier divider.
library;

import 'package:flutter/material.dart';

/// Topographic contour line painter drawing elegant brand wave patterns.
class TopographicWavePainter extends CustomPainter {
  /// Creates a [TopographicWavePainter].
  const TopographicWavePainter({
    this.lineColor = const Color(0xFF3A5FA0),
    this.bottomCurveColor = Colors.white,
    this.showBottomCurve = true,
  });

  /// Color for contour lines.
  final Color lineColor;

  /// Color of the bottom transitioning curve.
  final Color bottomCurveColor;

  /// Whether to draw the bottom organic curve transition into white surface.
  final bool showBottomCurve;

  @override
  void paint(Canvas canvas, Size size) {
    // ── 1. Base Dark Blue Gradient Fill ────────────────────────────────────
    final rect = Offset.zero & size;
    final bgPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF0D1B2A),
          Color(0xFF152A4D),
          Color(0xFF0A1624),
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

    // Contour Line 1
    final path1 = Path()
      ..moveTo(-size.width * 0.2, size.height * 0.25)
      ..cubicTo(
        size.width * 0.2,
        size.height * 0.05,
        size.width * 0.6,
        size.height * 0.45,
        size.width * 1.2,
        size.height * 0.2,
      );
    canvas.drawPath(path1, linePaint);

    // Contour Line 2
    final path2 = Path()
      ..moveTo(-size.width * 0.1, size.height * 0.45)
      ..cubicTo(
        size.width * 0.3,
        size.height * 0.2,
        size.width * 0.75,
        size.height * 0.65,
        size.width * 1.15,
        size.height * 0.38,
      );
    canvas.drawPath(path2, linePaintGlow);

    // Contour Line 3
    final path3 = Path()
      ..moveTo(-size.width * 0.15, size.height * 0.65)
      ..cubicTo(
        size.width * 0.25,
        size.height * 0.4,
        size.width * 0.7,
        size.height * 0.8,
        size.width * 1.1,
        size.height * 0.55,
      );
    canvas.drawPath(path3, linePaint);

    // Contour Line 4
    final path4 = Path()
      ..moveTo(size.width * 0.1, size.height * 0.1)
      ..cubicTo(
        size.width * 0.5,
        size.height * 0.35,
        size.width * 0.85,
        size.height * 0.15,
        size.width * 1.25,
        size.height * 0.45,
      );
    canvas.drawPath(path4, linePaintGlow);

    // Contour Line 5 (Subtle background loop)
    final path5 = Path()
      ..moveTo(-size.width * 0.05, size.height * 0.8)
      ..cubicTo(
        size.width * 0.35,
        size.height * 0.55,
        size.width * 0.65,
        size.height * 0.9,
        size.width * 1.05,
        size.height * 0.7,
      );
    canvas.drawPath(path5, linePaint);

    // ── 3. Bottom Organic Bezier Curve Transition ──────────────────────────
    if (showBottomCurve) {
      final curvePath = Path()
        ..moveTo(0, size.height)
        ..lineTo(0, size.height * 0.92)
        ..cubicTo(
          size.width * 0.3,
          size.height * 0.98,
          size.width * 0.7,
          size.height * 0.88,
          size.width,
          size.height * 0.94,
        )
        ..lineTo(size.width, size.height)
        ..close();

      final curvePaint = Paint()..color = bottomCurveColor;
      canvas.drawPath(curvePath, curvePaint);
    }
  }

  @override
  bool shouldRepaint(covariant TopographicWavePainter oldDelegate) {
    return oldDelegate.lineColor != lineColor ||
        oldDelegate.bottomCurveColor != bottomCurveColor ||
        oldDelegate.showBottomCurve != showBottomCurve;
  }
}

/// Reusable Topographic Header widget taking height and custom child.
class WaveHeaderWidget extends StatelessWidget {
  /// Creates a [WaveHeaderWidget].
  const WaveHeaderWidget({
    super.key,
    this.height = 280.0,
    this.bottomCurveColor = const Color(0xFFFAFAFA),
    this.showBottomCurve = true,
    this.child,
  });

  /// Total height of the header.
  final double height;

  /// Background color of the transitioning surface below.
  final Color bottomCurveColor;

  /// Whether to draw the organic bottom curve transition.
  final bool showBottomCurve;

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
        ),
        child: child,
      ),
    );
  }
}
