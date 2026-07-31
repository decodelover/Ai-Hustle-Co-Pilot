/// Pixel-perfect Create Account Screen matching Master Design System V2.0 specs.
///
/// Features top #0D1B2A topographic wave header with organic curve divider,
/// white background card (#FFFFFF), filled inputs (#F8FAFC, radius 16), terms checkbox,
/// #0D1B2A 24px rounded Create account pill button, social login, and footer toggle to Sign In.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/terms_checkbox_widget.dart';
import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured Register screen conforming strictly to Master Design System V2.0.
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
          backgroundColor: Color(0xFFEF4444),
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
                content: Text(error.toString().replaceAll('Exception:', '').trim()),
                backgroundColor: const Color(0xFFEF4444),
              ),
            );
          },
          data: (_) {
            if (previous?.isLoading == true) {
              context.goNamed(
                RouteNames.verifyEmail,
                extra: _emailController.text.trim(),
              );
            }
          },
        );
      },
    );

    final signUpState = ref.watch(signUpControllerProvider);
    final isLoading = signUpState.isLoading;
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.26 < 190 ? 190.0 : screenHeight * 0.26;

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
                      IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: 22.0,
                        ),
                      ),
                      const SizedBox(width: 8.0),
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
                      // Heading Title: Create an Account
                      const Text(
                        'Create an Account',
                        style: TextStyle(
                          color: Color(0xFF111827),
                          fontSize: 26.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.4,
                        ),
                      ),

                      const SizedBox(height: 24.0),

                      // Name Input (#F8FAFC filled, radius 16)
                      AuthInputField(
                        label: 'Name',
                        hintText: 'Johan Orindo',
                        controller: _nameController,
                        errorText: _nameError,
                        isDisabled: isLoading,
                      ),

                      const SizedBox(height: 18.0),

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
                        hintText: '••••••••',
                        isPassword: true,
                        controller: _passwordController,
                        errorText: _passwordError,
                        isDisabled: isLoading,
                      ),

                      const SizedBox(height: 16.0),

                      // Terms Agreement Checkbox
                      TermsCheckboxWidget(
                        value: _agreeToTerms,
                        onChanged: (val) {
                          if (val != null) {
                            setState(() => _agreeToTerms = val);
                          }
                        },
                      ),

                      const SizedBox(height: 24.0),

                      // Primary Action Button: #0D1B2A Rounded Pill Button (Height 56)
                      SizedBox(
                        height: 56.0,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _onSignUpSubmitted,
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
                              : const Text('Create account'),
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

                      const SizedBox(height: 20.0),

                      // Footer Link: Already have an account? Sign In
                      Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          const Text(
                            'Already have an account? ',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 14.0,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => context.pushNamed(RouteNames.login),
                            child: const Text(
                              'Sign In',
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
