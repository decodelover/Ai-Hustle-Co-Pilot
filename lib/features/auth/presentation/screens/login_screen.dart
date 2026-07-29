/// Pixel-perfect Sign In Screen (Screen 2) matching master reference design.
///
/// Features centered top app name in #3D82F7 blue, large white card surface
/// with radius 32 & soft Apple shadow, filled inputs (#F4F5F8, radius 16, height 56),
/// remember me & forgot password row, blue pill submit button (#3D82F7, radius 28),
/// and horizontal social login row (Facebook, Google, Apple).
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured Login screen conforming strictly to master design reference.
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _rememberMe = false;
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
                content: Text(error.toString()),
                backgroundColor: const Color(0xFFDC2626),
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

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F8),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 12.0),

                  // ── Top Center: App Name ───────────────────────────────────
                  const Text(
                    'AI Hustle Co-Pilot',
                    style: TextStyle(
                      color: Color(0xFF3D82F7),
                      fontSize: 22.0,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.4,
                    ),
                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 24.0),

                  // ── Main Card Container ───────────────────────────────────
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 24.0,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(28.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Card Heading ─────────────────────────────────────
                        const Text(
                          'Welcome Back!',
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 6.0),
                        const Text(
                          'Continue your AI journey',
                          style: TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 28.0),

                        // ── Email Input ──────────────────────────────────────
                        AuthInputField(
                          label: 'Email',
                          hintText: 'joedoe75@gmail.com',
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          errorText: _emailError,
                          isDisabled: isLoading,
                        ),

                        const SizedBox(height: 18.0),

                        // ── Password Input ───────────────────────────────────
                        AuthInputField(
                          label: 'Password',
                          hintText: '••••••••',
                          isPassword: true,
                          controller: _passwordController,
                          errorText: _passwordError,
                          isDisabled: isLoading,
                        ),

                        const SizedBox(height: 16.0),

                        // ── Remember Me & Forgot Password ────────────────────
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                'Forgot password?',
                                style: TextStyle(
                                  color: Color(0xFF3D82F7),
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 28.0),

                        // ── Primary Action Button: Blue Pill ──────────────────
                        SizedBox(
                          height: 56.0,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _onSignInSubmitted,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF3D82F7),
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

                        const SizedBox(height: 8.0),

                        // ── Divider ──────────────────────────────────────────
                        const OrDividerWidget(),

                        // ── Social Login Buttons ─────────────────────────────
                        SocialLoginButtons(
                          isLoading: isLoading,
                          onFacebookPressed: () {},
                          onGooglePressed: () {},
                          onApplePressed: () {},
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24.0),

                  // ── Footer Prompt: Toggle to Register ──────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 14.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushNamed(RouteNames.register),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                            color: Color(0xFF3D82F7),
                            fontSize: 14.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
