/// Pixel-perfect Sign In Screen matching Master Design System V2.0 specs.
///
/// Features top #0D1B2A topographic wave header with organic curve divider,
/// white background card (#FFFFFF), filled inputs (#F8FAFC, radius 16), Remember Me,
/// Forgot Password link, #0D1B2A 24px rounded Login pill button, social login,
/// and footer toggle to Sign Up.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured Login screen conforming strictly to Master Design System V2.0.
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = true;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInSubmitted() {
    setState(() {
      _emailError = _emailController.text.trim().isEmpty
          ? 'Email address is required'
          : null;
      _passwordError = _passwordController.text.isEmpty
          ? 'Password is required'
          : null;
    });

    if (_emailError != null || _passwordError != null) return;

    ref.read(signInControllerProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      signInControllerProvider,
      (previous, next) {
        next.whenOrNull(
          error: (error, stackTrace) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(error.toString().replaceAll('Exception:', '').trim()),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          },
          data: (_) {
            if (previous?.isLoading == true) {
              context.goNamed(RouteNames.dashboard);
            }
          },
        );
      },
    );

    final signInState = ref.watch(signInControllerProvider);
    final isLoading = signInState.isLoading;
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.28 < 200 ? 200.0 : screenHeight * 0.28;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Top Header: Dark Blue Wave Header (#0D1B2A) ─────────────────
            WaveHeaderWidget(
              height: headerHeight,
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 16.0,
                  ),
                  child: Row(
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
                ),
              ),
            ),

            // ── Main Content Section: White Surface (#FFFFFF) ───────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Heading Title: Sign in (Heading Large 24 / 32 SemiBold)
                      const Text(
                        'Sign in',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 26.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),

                      const SizedBox(height: 24.0),

                      // Email Input (#F8FAFC filled, radius 16)
                      AuthInputField(
                        label: 'Email',
                        hintText: 'demo@email.com',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        errorText: _emailError,
                        isDisabled: isLoading,
                      ),

                      const SizedBox(height: 18.0),

                      // Password Input (#F8FAFC filled, radius 16)
                      AuthInputField(
                        label: 'Password',
                        hintText: 'Enter your password',
                        isPassword: true,
                        controller: _passwordController,
                        errorText: _passwordError,
                        isDisabled: isLoading,
                        onSubmitted: (_) => _onSignInSubmitted(),
                      ),

                      const SizedBox(height: 16.0),

                      // Remember Me & Forgot Password
                      Wrap(
                        alignment: WrapAlignment.spaceBetween,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          RememberMeWidget(
                            value: _rememberMe,
                            onChanged: (val) {
                              if (val != null) {
                                setState(() => _rememberMe = val);
                              }
                            },
                          ),
                          GestureDetector(
                            onTap: () => context.pushNamed(
                              RouteNames.forgotPassword,
                            ),
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(
                                color: Color(0xFF3A5FA0),
                                fontSize: 13.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 28.0),

                      // Primary Action Button: #0D1B2A Rounded Pill Button (Height 56)
                      SizedBox(
                        height: 56.0,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _onSignInSubmitted,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D1B2A),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text('Login'),
                        ),
                      ),

                      const SizedBox(height: 12.0),

                      // Or Divider
                      const OrDividerWidget(),

                      // Social Login Buttons
                      SocialLoginButtons(
                        isLoading: isLoading,
                        onFacebookPressed: () {},
                        onGooglePressed: () {},
                        onApplePressed: () {},
                      ),

                      const SizedBox(height: 24.0),

                      // Footer Link: Don't have an Account ? Sign up
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            "Don't have an Account ? ",
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pushNamed(RouteNames.register),
                            child: const Text(
                              'Sign up',
                              style: TextStyle(
                                color: Color(0xFF0D1B2A),
                                fontSize: 14.0,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 24.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
