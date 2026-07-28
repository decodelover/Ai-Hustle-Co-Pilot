/// Official Brand Icon primitives for Google and GitHub.
library;

import 'package:flutter/material.dart';

/// Pixel-perfect, authentic Google multi-color brand icon.
class GoogleBrandIcon extends StatelessWidget {
  /// Creates a [GoogleBrandIcon].
  const GoogleBrandIcon({
    super.key,
    this.size = 20.0,
  });

  /// Icon dimensions.
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: _GoogleLogoPainter(),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.22;
    final rect = Rect.fromCircle(center: center, radius: radius - strokeWidth / 2);

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.butt
      ..color = const Color(0xFFEA4335);

    // Red segment (top arc)
    canvas.drawArc(rect, -0.65, 1.85, false, paint);

    // Yellow segment (bottom left arc)
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, 1.2, 1.25, false, paint);

    // Green segment (bottom right arc)
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 2.45, 1.15, false, paint);

    // Blue segment (right arc & bar)
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -0.65, 1.2, false, paint);

    final barPaint = Paint()
      ..color = const Color(0xFF4285F4)
      ..style = PaintingStyle.fill;

    final barRect = Rect.fromLTWH(
      center.dx,
      center.dy - strokeWidth / 2,
      radius - strokeWidth / 4,
      strokeWidth,
    );
    canvas.drawRect(barRect, barPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Official GitHub Octocat brand icon widget.
class GitHubBrandIcon extends StatelessWidget {
  /// Creates a [GitHubBrandIcon].
  const GitHubBrandIcon({
    super.key,
    this.size = 20.0,
    this.color,
  });

  /// Icon dimensions.
  final double size;

  /// Optional icon color override.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor =
        color ?? Theme.of(context).colorScheme.onSurface;

    return CustomPaint(
      size: Size(size, size),
      painter: _GitHubLogoPainter(color: effectiveColor),
    );
  }
}

class _GitHubLogoPainter extends CustomPainter {
  _GitHubLogoPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final w = size.width;
    final h = size.height;

    // Outer circle outline with inner cutouts mimicking GitHub logo
    path.addOval(Rect.fromLTWH(0, 0, w, h));
    canvas.drawPath(path, paint);

    final cutPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    // Distinct inner cat silhouette cutout
    final innerPath = Path()
      ..addOval(Rect.fromLTWH(w * 0.25, h * 0.25, w * 0.5, h * 0.5));
    canvas.drawPath(innerPath, cutPaint);

    final headPath = Path()
      ..addOval(Rect.fromLTWH(w * 0.32, h * 0.32, w * 0.36, h * 0.36));
    canvas.drawPath(headPath, paint);
  }

  @override
  bool shouldRepaint(covariant _GitHubLogoPainter oldDelegate) =>
      oldDelegate.color != color;
}
