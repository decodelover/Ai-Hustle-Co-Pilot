/// Enterprise ambient background system for AI Hustle Co-Pilot authentication.
/// Features animated glowing mesh orbs, grid matrix overlays, and dark/light adaptive gradients.
library;

import 'dart:math' as math;
import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Animated high-tech ambient background wrapper.
class AppAuthBackground extends StatefulWidget {
  /// Creates an [AppAuthBackground].
  const AppAuthBackground({
    required this.child,
    super.key,
  });

  /// Page content child widget.
  final Widget child;

  @override
  State<AppAuthBackground> createState() => _AppAuthBackgroundState();
}

class _AppAuthBackgroundState extends State<AppAuthBackground>
    with SingleTickerProviderStateMixin {
  late final AnimationController _meshController;

  @override
  void initState() {
    super.initState();
    _meshController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _meshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          // ── 1. Base Gradient Canvas ─────────────────────────────────
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: isDark
                      ? const [
                          Color(0xFF0D0E1A),
                          Color(0xFF131527),
                          Color(0xFF0A0B14),
                        ]
                      : const [
                          Color(0xFFF8F9FE),
                          Color(0xFFF0F3FD),
                          Color(0xFFE9ECFA),
                        ],
                ),
              ),
            ),
          ),

          // ── 2. Live Floating Mesh Orbs Painter ─────────────────────
          AnimatedBuilder(
            animation: _meshController,
            builder: (context, child) {
              return CustomPaint(
                size: Size.infinite,
                painter: _AmbientMeshPainter(
                  progress: _meshController.value,
                  isDark: isDark,
                ),
              );
            },
          ),

          // ── 3. High-Tech Grid Dot Matrix Overlay ───────────────────
          CustomPaint(
            size: Size.infinite,
            painter: _GridDotPainter(isDark: isDark),
          ),

          // ── 4. Main Page Content ───────────────────────────────────
          SafeArea(
            child: widget.child,
          ),
        ],
      ),
    );
  }
}

/// CustomPainter for floating gradient mesh orbs.
class _AmbientMeshPainter extends CustomPainter {
  _AmbientMeshPainter({
    required this.progress,
    required this.isDark,
  });

  final double progress;
  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final angle = progress * 2 * math.pi;

    // Orb 1: Top Left Violet Glow
    final orb1Center = Offset(
      w * 0.2 + math.sin(angle) * 35.0,
      h * 0.15 + math.cos(angle) * 35.0,
    );
    final orb1Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          (isDark ? const Color(0xFF6366F1) : const Color(0xFF818CF8))
              .withValues(alpha: isDark ? 0.35 : 0.25),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: orb1Center, radius: w * 0.65));
    canvas.drawCircle(orb1Center, w * 0.65, orb1Paint);

    // Orb 2: Bottom Right Indigo Accent Glow
    final orb2Center = Offset(
      w * 0.8 - math.cos(angle) * 40.0,
      h * 0.75 - math.sin(angle) * 40.0,
    );
    final orb2Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          (isDark ? const Color(0xFF8B5CF6) : const Color(0xFFA78BFA))
              .withValues(alpha: isDark ? 0.30 : 0.20),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: orb2Center, radius: w * 0.75));
    canvas.drawCircle(orb2Center, w * 0.75, orb2Paint);

    // Orb 3: Center Emerald Highlight Accent Glow
    final orb3Center = Offset(
      w * 0.5 + math.sin(angle * 1.5) * 25.0,
      h * 0.45 + math.cos(angle * 1.5) * 25.0,
    );
    final orb3Paint = Paint()
      ..shader = RadialGradient(
        colors: [
          (isDark ? const Color(0xFF10B981) : const Color(0xFF34D399))
              .withValues(alpha: isDark ? 0.15 : 0.10),
          Colors.transparent,
        ],
      ).createShader(Rect.fromCircle(center: orb3Center, radius: w * 0.45));
    canvas.drawCircle(orb3Center, w * 0.45, orb3Paint);
  }

  @override
  bool shouldRepaint(covariant _AmbientMeshPainter oldDelegate) =>
      oldDelegate.progress != progress || oldDelegate.isDark != isDark;
}

/// CustomPainter drawing a subtle high-tech dot matrix grid overlay.
class _GridDotPainter extends CustomPainter {
  _GridDotPainter({required this.isDark});

  final bool isDark;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = (isDark ? Colors.white : const Color(0xFF1E1B4B))
          .withValues(alpha: isDark ? 0.04 : 0.03)
      ..strokeWidth = 1.0;

    const step = 28.0;
    for (double x = 0; x < size.width; x += step) {
      for (double y = 0; y < size.height; y += step) {
        canvas.drawCircle(Offset(x, y), 1.2, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _GridDotPainter oldDelegate) =>
      oldDelegate.isDark != isDark;
}
