/// Pixel-perfect Onboarding (Screen 1) matching master reference design.
///
/// Features animated dark slate gradient background (#3D4655), 3-line bold title,
/// hero AI product illustration container with rounded top corners, and dark
/// glassmorphism capsule navigation bar at the bottom.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Hero Onboarding & Welcome screen.
class WelcomeScreen extends StatefulWidget {
  /// Creates a [WelcomeScreen].
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late final AnimationController _animController;
  late final AnimationController _bgAnimController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _bgAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat(reverse: true);

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    _bgAnimController.dispose();
    super.dispose();
  }

  void _navigateToNext() {
    context.pushNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;
    final bottomPadding = mediaQuery.padding.bottom;

    return Scaffold(
      body: AnimatedBuilder(
        animation: _bgAnimController,
        builder: (context, child) {
          final t = _bgAnimController.value;
          final beginAlign = Alignment(-0.2 + (t * 0.4), -1.0);
          final endAlign = Alignment(0.2 - (t * 0.4), 1.0);

          final c1 = Color.lerp(
            const Color(0xFF4A5568),
            const Color(0xFF3B485A),
            t,
          )!;

          final c2 = Color.lerp(
            const Color(0xFF3D4655),
            const Color(0xFF2E3848),
            t,
          )!;

          final c3 = Color.lerp(
            const Color(0xFF2B323E),
            const Color(0xFF1E2530),
            t,
          )!;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: beginAlign,
                end: endAlign,
                colors: [c1, c2, c3],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: child,
          );
        },
        child: SafeArea(
          bottom: false,
          child: SlideTransition(
            position: _slideAnim,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: topPadding > 0 ? 8.0 : 16.0),

                        // ── Top Left: App Title ─────────────────────────────
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0),
                          child: Text(
                            'AI Hustle Co-Pilot',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ),

                        const SizedBox(height: 36.0),

                        // ── Main Heading: Exactly 3 Lines ───────────────────
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.0),
                          child: Text(
                            'Build\nYour AI\nBusiness',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 38.0,
                              fontWeight: FontWeight.w700,
                              height: 1.12,
                              letterSpacing: -0.8,
                            ),
                          ),
                        ),

                        const SizedBox(height: 24.0),

                        // ── Center/Lower Hero Tech Graphic Illustration ──────
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFF262D38),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(36.0),
                                topRight: Radius.circular(36.0),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.35),
                                  blurRadius: 32.0,
                                  offset: const Offset(0, -10),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(36.0),
                                topRight: Radius.circular(36.0),
                              ),
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: CustomPaint(
                                      painter: _HeroIllustrationPainter(),
                                    ),
                                  ),
                                  // Subtle gradient overlay at bottom of hero
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    bottom: 0,
                                    height: 160,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Colors.transparent,
                                            const Color(0xFF212731)
                                                .withValues(alpha: 0.95),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ── Bottom Navigation Capsule ─────────────────────────────
                  Positioned(
                    left: 24.0,
                    right: 24.0,
                    bottom: (bottomPadding > 0 ? bottomPadding : 24.0) + 12.0,
                    child: Container(
                      height: 72.0,
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF323B49).withValues(alpha: 0.92),
                        borderRadius: BorderRadius.circular(40.0),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.12),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.4),
                            blurRadius: 24.0,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // Left: Circular Back Button
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => context.pushNamed(RouteNames.login),
                              customBorder: const CircleBorder(),
                              child: Container(
                                width: 44.0,
                                height: 44.0,
                                decoration: BoxDecoration(
                                  color: Colors.white.withValues(alpha: 0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.arrow_back_rounded,
                                  color: Colors.white70,
                                  size: 20.0,
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          // Center: Large White Circular Play Button
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _navigateToNext,
                              customBorder: const CircleBorder(),
                              child: Container(
                                width: 54.0,
                                height: 54.0,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.white.withValues(alpha: 0.25),
                                      blurRadius: 16.0,
                                      spreadRadius: 2.0,
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.play_arrow_rounded,
                                    color: Color(0xFF2B323E),
                                    size: 30.0,
                                  ),
                                ),
                              ),
                            ),
                          ),

                          const Spacer(),

                          // Right: Start >>> Text Button
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () => context.pushNamed(RouteNames.register),
                              borderRadius: BorderRadius.circular(20.0),
                              child: const Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.0,
                                  vertical: 8.0,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      'Start',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      '>>>',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 13.0,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: -1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Custom Painter for the premium AI product graphic in lower half of screen 1.
class _HeroIllustrationPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.5, size.height * 0.45);
    final baseRadius = size.width * 0.42;

    // Glowing subtle outer radial ring
    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFF4A566A).withValues(alpha: 0.4),
          const Color(0xFF262D38).withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius * 1.3));

    canvas.drawCircle(center, baseRadius * 1.3, glowPaint);

    // Dark sleek metallic device disc body
    final bodyPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF384353),
          Color(0xFF1E242E),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: baseRadius));

    canvas.drawCircle(center, baseRadius, bodyPaint);

    // Inner concentric ring
    final ringPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0
      ..color = Colors.white.withValues(alpha: 0.12);

    canvas.drawCircle(center, baseRadius * 0.72, ringPaint);

    // Top sensor/turret dome
    final sensorCenter = Offset(center.dx + baseRadius * 0.3, center.dy - baseRadius * 0.25);
    final sensorPaint = Paint()
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF4E5B70),
          Color(0xFF1B212A),
        ],
      ).createShader(Rect.fromCircle(center: sensorCenter, radius: baseRadius * 0.28));

    canvas.drawCircle(sensorCenter, baseRadius * 0.28, sensorPaint);

    final sensorBorder = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = const Color(0xFF3D82F7).withValues(alpha: 0.4);

    canvas.drawCircle(sensorCenter, baseRadius * 0.28, sensorBorder);

    // Small status LED indicators
    final ledPaint = Paint()
      ..color = const Color(0xFF3D82F7)
      ..style = PaintingStyle.fill;

    final whiteLedPaint = Paint()
      ..color = Colors.white70
      ..style = PaintingStyle.fill;

    canvas
      ..drawCircle(
        Offset(sensorCenter.dx - 8, sensorCenter.dy - 6),
        3.0,
        ledPaint,
      )
      ..drawCircle(
        Offset(sensorCenter.dx + 8, sensorCenter.dy - 6),
        3.0,
        whiteLedPaint,
      );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
