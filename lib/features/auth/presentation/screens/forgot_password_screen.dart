/// Production-ready Forgot Password screen.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured Password Recovery screen conforming strictly to Master Design System V2.0.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  /// Creates a [ForgotPasswordScreen].
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  String? _emailError;
  bool _isSubmittedSuccess = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _onResetSubmitted() {
    setState(() {
      _emailError = _emailController.text.trim().isEmpty
          ? 'Email address is required'
          : null;
    });

    if (_emailError != null) return;

    ref
        .read(resetPasswordControllerProvider.notifier)
        .resetPassword(email: _emailController.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(resetPasswordControllerProvider, (
      previous,
      next,
    ) {
      next.whenOrNull(
        error: (error, stackTrace) {
          AppSnackBar.showError(
            context,
            message: error.toString().replaceAll('Exception:', '').trim(),
          );
        },
        data: (_) {
          if (previous?.isLoading == true) {
            setState(() => _isSubmittedSuccess = true);
          }
        },
      );
    });

    final resetState = ref.watch(resetPasswordControllerProvider);
    final isLoading = resetState.isLoading;
    final screenHeight = MediaQuery.of(context).size.height;
    final headerHeight = screenHeight * 0.28 < 200
        ? 200.0
        : screenHeight * 0.28;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top Dark Blue Wave Header
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

            Padding(
              padding: const EdgeInsets.all(AppSpacing.space24),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 440),
                  child: _isSubmittedSuccess
                      ? AppSuccessState(
                          title: 'Reset Link Sent!',
                          message:
                              'We sent a password recovery email to ${_emailController.text.trim()}. Please check your inbox.',
                          actionLabel: 'Return to Sign In',
                          onAction: () => context.goNamed(RouteNames.login),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              'Reset Password',
                              style: TextStyle(
                                color: Color(0xFF111827),
                                fontSize: 26.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.4,
                              ),
                            ),

                            const SizedBox(height: 8.0),

                            const Text(
                              'Enter your account email and we will send a password reset link.',
                              style: TextStyle(
                                color: Color(0xFF6B7280),
                                fontSize: 14.0,
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

                            const SizedBox(height: 24.0),

                            // Send Reset Link Primary Button
                            SizedBox(
                              height: 56.0,
                              child: ElevatedButton(
                                onPressed: isLoading ? null : _onResetSubmitted,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0D1B2A),
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
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
                                    : const Text(
                                        'Send Reset Link',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),

                            const SizedBox(height: 12.0),

                            AppButton(
                              text: 'Back to Sign In',
                              variant: AppButtonVariant.ghost,
                              onPressed: () =>
                                  context.goNamed(RouteNames.login),
                            ),
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
