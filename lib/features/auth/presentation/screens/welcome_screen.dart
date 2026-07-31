/// Pixel-perfect Onboarding (Screen 1) matching Master Design System V2.0.
///
/// Features top ~45% dark blue section (#0D1B2A) with subtle topographic contour wave pattern
/// and organic curve divider transitioning smoothly into a white section (#FFFFFF) below.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
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
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.05),
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
    super.dispose();
  }

  void _navigateToNext() {
    context.pushNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final headerHeight = screenHeight * 0.46;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // ── Top Section: 45% Topographic Wave Header (#0D1B2A) ───────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: WaveHeaderWidget(
              height: headerHeight,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Top Brand Header Row
                      Row(
                        children: [
                          Container(
                            width: 36.0,
                            height: 36.0,
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.12),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.rocket_launch_rounded,
                              color: Colors.white,
                              size: 20.0,
                            ),
                          ),
                          const SizedBox(width: 12.0),
                          const Text(
                            'AI Hustle Co-Pilot',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.3,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Bottom Section: White Card (#FFFFFF) with Clean Content ────────
          Positioned(
            top: headerHeight - 32.0,
            left: 0,
            right: 0,
            bottom: 0,
            child: SlideTransition(
              position: _slideAnim,
              child: FadeTransition(
                opacity: _fadeAnim,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 28.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),

                      // Large Heading: Display 40 Bold
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 40.0,
                          fontWeight: FontWeight.w700,
                          height: 1.15,
                          letterSpacing: -0.8,
                        ),
                      ),

                      const SizedBox(height: 14.0),

                      // Short Description: Body Medium 14 / 20 Regular
                      const Text(
                        'Supercharge your freelance business with AI co-pilots, automated proposals, client workflows, and intelligent assistants.',
                        style: TextStyle(
                          color: Color(0xFF6B7280),
                          fontSize: 15.0,
                          fontWeight: FontWeight.w400,
                          height: 1.45,
                        ),
                      ),

                      const Spacer(flex: 2),

                      // Primary Continue Button Row
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 56.0,
                          child: ElevatedButton(
                            onPressed: _navigateToNext,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0D1B2A),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 28.0,
                                vertical: 14.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28.0),
                              ),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Continue',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: -0.1,
                                  ),
                                ),
                                SizedBox(width: 10.0),
                                Icon(
                                  Icons.arrow_forward_rounded,
                                  size: 20.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: mediaQuery.padding.bottom > 0
                            ? mediaQuery.padding.bottom + 12.0
                            : 32.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
