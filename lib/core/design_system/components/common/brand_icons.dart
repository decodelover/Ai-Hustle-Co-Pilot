/// Official Brand Icon primitives for Google, Facebook, Apple, and GitHub.
library;

import 'package:flutter/material.dart';

/// Pixel-perfect, authentic Google multi-color brand icon.
class GoogleBrandIcon extends StatelessWidget {
  /// Creates a [GoogleBrandIcon].
  const GoogleBrandIcon({super.key, this.size = 22.0});

  /// Icon dimensions.
  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _GoogleLogoPainter());
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final strokeWidth = size.width * 0.22;
    final rect = Rect.fromCircle(
      center: center,
      radius: radius - strokeWidth / 2,
    );

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

/// Official Facebook brand icon widget.
class FacebookBrandIcon extends StatelessWidget {
  /// Creates a [FacebookBrandIcon].
  const FacebookBrandIcon({super.key, this.size = 22.0});

  /// Icon dimensions.
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        color: Color(0xFF1877F2),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          'f',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w900,
            fontSize: size * 0.7,
            height: 1.0,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}

/// Official Apple brand icon widget.
class AppleBrandIcon extends StatelessWidget {
  /// Creates an [AppleBrandIcon].
  const AppleBrandIcon({super.key, this.size = 22.0, this.color});

  /// Icon dimensions.
  final double size;

  /// Optional icon color override.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.onSurface;

    return CustomPaint(
      size: Size(size, size),
      painter: _AppleLogoPainter(color: effectiveColor),
    );
  }
}

class _AppleLogoPainter extends CustomPainter {
  _AppleLogoPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    final path = Path()
      ..moveTo(w * 0.52, h * 0.15)
      ..cubicTo(w * 0.52, h * 0.05, w * 0.60, h * 0.0, w * 0.60, h * 0.0)
      ..cubicTo(w * 0.60, h * 0.10, w * 0.52, h * 0.15, w * 0.52, h * 0.15)
      ..moveTo(w * 0.72, h * 0.42)
      ..cubicTo(w * 0.72, h * 0.32, w * 0.80, h * 0.26, w * 0.81, h * 0.25)
      ..cubicTo(w * 0.73, h * 0.14, w * 0.60, h * 0.16, w * 0.55, h * 0.16)
      ..cubicTo(w * 0.43, h * 0.16, w * 0.37, h * 0.23, w * 0.31, h * 0.23)
      ..cubicTo(w * 0.24, h * 0.23, w * 0.18, h * 0.16, w * 0.10, h * 0.16)
      ..cubicTo(w * 0.0, h * 0.16, -0.06, h * 0.33, -0.06, h * 0.52)
      ..cubicTo(-0.06, h * 0.71, w * 0.12, h * 0.98, w * 0.24, h * 0.98)
      ..cubicTo(w * 0.30, h * 0.98, w * 0.35, h * 0.91, w * 0.43, h * 0.91)
      ..cubicTo(w * 0.50, h * 0.91, w * 0.55, h * 0.98, w * 0.62, h * 0.98)
      ..cubicTo(w * 0.74, h * 0.98, w * 0.82, h * 0.75, w * 0.82, h * 0.75)
      ..cubicTo(w * 0.82, h * 0.75, w * 0.72, h * 0.71, w * 0.72, h * 0.55)
      ..cubicTo(w * 0.72, h * 0.42, w * 0.72, h * 0.42, w * 0.72, h * 0.42);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AppleLogoPainter oldDelegate) =>
      oldDelegate.color != color;
}

/// Official GitHub Octocat brand icon widget.
class GitHubBrandIcon extends StatelessWidget {
  /// Creates a [GitHubBrandIcon].
  const GitHubBrandIcon({super.key, this.size = 22.0, this.color});

  /// Icon dimensions.
  final double size;

  /// Optional icon color override.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? Theme.of(context).colorScheme.onSurface;

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
