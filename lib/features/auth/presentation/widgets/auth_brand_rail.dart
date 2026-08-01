/// Wide-screen brand rail for the shared public authentication shell.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/brand_identity_header.dart';
import 'package:flutter/material.dart';

/// Provides a calm navy product story beside wide auth forms.
class AuthBrandRail extends StatelessWidget {
  /// Creates the wide auth brand rail.
  const AuthBrandRail({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: const _AuthRailPainter(),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BrandIdentityHeader(showTagline: false),
            const Spacer(),
            Text(
              'Your work deserves\na smarter starting point.',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                color: AppColors.onPrimary,
                fontWeight: FontWeight.w800,
                height: 1.08,
                letterSpacing: -1.2,
              ),
            ),
            const SizedBox(height: AppSpacing.space16),
            Text(
              'Discover better opportunities, shape sharper proposals, and keep every next move close.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.onPrimary.withValues(alpha: 0.72),
                height: 1.5,
              ),
            ),
            const SizedBox(height: AppSpacing.space32),
            const _RailTag(),
          ],
        ),
      ),
    );
  }
}

class _RailTag extends StatelessWidget {
  const _RailTag();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space12,
        vertical: AppSpacing.space8,
      ),
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.08),
        borderRadius: AppRadius.borderPill,
        border: Border.all(color: AppColors.onPrimary.withValues(alpha: 0.16)),
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.accentCoral,
            size: 16,
          ),
          SizedBox(width: AppSpacing.space8),
          Text(
            'Built for your next win',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthRailPainter extends CustomPainter {
  const _AuthRailPainter();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      Offset.zero & size,
      Paint()..color = AppColors.primaryDarkBlue,
    );
    final line = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = AppColors.onPrimary.withValues(alpha: 0.07);
    for (var index = 0; index < 9; index++) {
      final path = Path();
      final y = size.height * 0.13 + index * 72;
      path
        ..moveTo(-80, y)
        ..cubicTo(
          size.width * 0.2,
          y - 80,
          size.width * 0.68,
          y + 90,
          size.width + 100,
          y - 30,
        );
      canvas.drawPath(path, line);
    }
    final glow = Paint()
      ..shader =
          RadialGradient(
            colors: [
              AppColors.secondary.withValues(alpha: 0.26),
              Colors.transparent,
            ],
          ).createShader(
            Rect.fromCircle(
              center: Offset(size.width * 0.78, size.height * 0.18),
              radius: size.width * 0.6,
            ),
          );
    canvas.drawCircle(
      Offset(size.width * 0.78, size.height * 0.18),
      size.width * 0.6,
      glow,
    );
  }

  @override
  bool shouldRepaint(covariant _AuthRailPainter oldDelegate) => false;
}
