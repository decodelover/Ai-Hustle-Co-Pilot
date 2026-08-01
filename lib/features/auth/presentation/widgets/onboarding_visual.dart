/// Premium vector illustration for the onboarding action sheet.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Renders a lightweight workflow scene without requiring a raster asset.
class OnboardingVisual extends StatelessWidget {
  /// Creates an onboarding workflow visual.
  const OnboardingVisual({super.key, this.icon = Icons.auto_awesome_rounded});

  /// Symbol shown at the centre of the workflow.
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      image: true,
      label: 'Illustration of an AI-assisted freelance workflow',
      child: AspectRatio(
        aspectRatio: 1.42,
        child: Stack(
          fit: StackFit.expand,
          children: [
            const CustomPaint(painter: _WorkflowPainter()),
            Center(
              child: Container(
                width: 54,
                height: 54,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x263A5FA0),
                      blurRadius: 12,
                      offset: Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.background.withValues(alpha: 0.92),
                    width: 3,
                  ),
                ),
                child: Icon(icon, color: AppColors.onPrimary, size: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkflowPainter extends CustomPainter {
  const _WorkflowPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;
    final board = Rect.fromLTWH(w * 0.17, h * 0.14, w * 0.66, h * 0.62);

    final ambient = Paint()..color = const Color(0xFFEAF2FB);
    canvas
      ..drawCircle(Offset(w * 0.18, h * 0.32), w * 0.12, ambient)
      ..drawCircle(Offset(w * 0.86, h * 0.68), w * 0.14, ambient);

    final boardPaint = Paint()..color = const Color(0xFFF8FAFC);
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(board, const Radius.circular(18)),
        boardPaint,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(board, const Radius.circular(18)),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = const Color(0xFFDCE7F2),
      );

    final connector = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..color = AppColors.secondary.withValues(alpha: 0.5);
    final center = Offset(w * 0.5, h * 0.46);
    for (final target in [
      Offset(w * 0.3, h * 0.31),
      Offset(w * 0.7, h * 0.31),
      Offset(w * 0.3, h * 0.65),
      Offset(w * 0.7, h * 0.65),
    ]) {
      canvas
        ..drawLine(center, target, connector)
        ..drawCircle(target, 3.5, Paint()..color = AppColors.accentCoral);
    }

    _drawNote(canvas, Offset(w * 0.23, h * 0.22), w * 0.16, h * 0.12);
    _drawNote(canvas, Offset(w * 0.61, h * 0.22), w * 0.17, h * 0.12);
    _drawNote(canvas, Offset(w * 0.23, h * 0.57), w * 0.16, h * 0.12);
    _drawNote(canvas, Offset(w * 0.61, h * 0.57), w * 0.17, h * 0.12);

    _drawPerson(canvas, Offset(w * 0.08, h * 0.61), const Color(0xFF6D8EC7));
    _drawPerson(canvas, Offset(w * 0.82, h * 0.2), const Color(0xFFB2C6E6));
    _drawPerson(canvas, Offset(w * 0.79, h * 0.72), const Color(0xFF7EA6A0));

    final spark = Paint()..color = const Color(0xFFF5C870);
    canvas
      ..drawCircle(Offset(w * 0.86, h * 0.12), 4, spark)
      ..drawCircle(Offset(w * 0.12, h * 0.18), 3, spark);
  }

  void _drawNote(Canvas canvas, Offset origin, double width, double height) {
    final rect = Rect.fromLTWH(origin.dx, origin.dy, width, height);
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(7)),
      Paint()..color = const Color(0xFFDCE8F7),
    );
    final line = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..color = AppColors.secondary.withValues(alpha: 0.6);
    canvas
      ..drawLine(
        Offset(origin.dx + width * 0.2, origin.dy + height * 0.35),
        Offset(origin.dx + width * 0.78, origin.dy + height * 0.35),
        line,
      )
      ..drawLine(
        Offset(origin.dx + width * 0.2, origin.dy + height * 0.64),
        Offset(origin.dx + width * 0.58, origin.dy + height * 0.64),
        line,
      );
  }

  void _drawPerson(Canvas canvas, Offset origin, Color color) {
    final head = Paint()..color = const Color(0xFFF5C8A4);
    final body = Paint()..color = color;
    canvas
      ..drawCircle(Offset(origin.dx + 10, origin.dy + 8), 6, head)
      ..drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(origin.dx + 3, origin.dy + 15, 15, 23),
          const Radius.circular(7),
        ),
        body,
      )
      ..drawLine(
        Offset(origin.dx + 6, origin.dy + 37),
        Offset(origin.dx + 3, origin.dy + 46),
        Paint()
          ..color = color
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round,
      )
      ..drawLine(
        Offset(origin.dx + 15, origin.dy + 37),
        Offset(origin.dx + 18, origin.dy + 46),
        Paint()
          ..color = color
          ..strokeWidth = 3
          ..strokeCap = StrokeCap.round,
      );
  }

  @override
  bool shouldRepaint(covariant _WorkflowPainter oldDelegate) => false;
}
