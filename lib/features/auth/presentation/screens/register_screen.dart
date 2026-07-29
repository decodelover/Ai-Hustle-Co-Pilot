/// Pixel-perfect Create Account Screen (Screen 3) matching master reference design.
///
/// Features top left circular white back button with tiny shadow, centered blue
/// app title (#3D82F7), white card with radius 32, inputs for Name, Email, and
/// Password, terms agreement checkbox, blue pill submit button (#3D82F7, radius 28),
/// and horizontal social login row (Facebook, Google, Apple).
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/terms_checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured Register screen conforming strictly to master design reference.
class RegisterScreen extends ConsumerStatefulWidget {
  /// Creates a [RegisterScreen].
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _agreeToTerms = true;
  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignUpSubmitted() {
    setState(() {
      _nameError = _nameController.text.trim().isEmpty
          ? 'Full name is required'
          : null;
      _emailError = _emailController.text.trim().isEmpty
          ? 'Email address is required'
          : null;
      _passwordError = _passwordController.text.length < 6
          ? 'Password must be at least 6 characters'
          : null;
    });

    if (_nameError != null || _emailError != null || _passwordError != null) {
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms of Service.'),
          backgroundColor: Color(0xFFDC2626),
        ),
      );
      return;
    }

    ref.read(signUpControllerProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _nameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(
      signUpControllerProvider,
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
              context.goNamed(RouteNames.verifyEmail);
            }
          },
        );
      },
    );

    final signUpState = ref.watch(signUpControllerProvider);
    final isLoading = signUpState.isLoading;

    return Scaffold(
      backgroundColor: const Color(0xFFF4F5F8),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 12.0,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: Column(
                children: [
                  // ── Top Navigation Bar ────────────────────────────────────
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => context.pop(),
                            customBorder: const CircleBorder(),
                            child: Container(
                              width: 40.0,
                              height: 40.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.06),
                                    blurRadius: 10.0,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.chevron_left_rounded,
                                color: Color(0xFF555555),
                                size: 26.0,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Text(
                        'AI Hustle Co-Pilot',
                        style: TextStyle(
                          color: Color(0xFF3D82F7),
                          fontSize: 22.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20.0),

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
                          'Create an Account?',
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 22.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        const SizedBox(height: 24.0),

                        // ── Name Input ───────────────────────────────────────
                        AuthInputField(
                          label: 'Name',
                          hintText: 'Johan orindo',
                          controller: _nameController,
                          errorText: _nameError,
                          isDisabled: isLoading,
                        ),

                        const SizedBox(height: 18.0),

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

                        // ── Terms Agreement Checkbox ─────────────────────────
                        TermsCheckboxWidget(
                          value: _agreeToTerms,
                          onChanged: (val) {
                            if (val != null) {
                              setState(() => _agreeToTerms = val);
                            }
                          },
                        ),

                        const SizedBox(height: 24.0),

                        // ── Primary Action Button: Blue Pill ──────────────────
                        SizedBox(
                          height: 56.0,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : _onSignUpSubmitted,
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
                                : const Text('Create account'),
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

                  const SizedBox(height: 20.0),

                  // ── Footer Prompt: Toggle to Login ─────────────────────────
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 14.0,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => context.pushNamed(RouteNames.login),
                        child: const Text(
                          'Sign In',
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
