/// Production-ready Email OTP Verification screen.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/shared/widgets/topographic_wave_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured 6-digit OTP Email Verification screen conforming to Master Design System V2.0.
class EmailVerificationScreen extends ConsumerStatefulWidget {
  /// Creates an [EmailVerificationScreen].
  const EmailVerificationScreen({
    super.key,
    this.email = 'your registered email address',
  });

  /// User's registered email address.
  final String email;

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _handleVerify() {
    final code = _otpController.text.trim();
    if (code.length < 6) {
      AppSnackBar.showError(
        context,
        message: 'Please enter the 6-digit OTP code sent to your email.',
      );
      return;
    }

    ref
        .read(verifyOtpControllerProvider.notifier)
        .verifyOtp(email: widget.email, token: code);
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    ref
      ..listen<AsyncValue<void>>(verifyOtpControllerProvider, (previous, next) {
        next.whenOrNull(
          error: (error, stackTrace) {
            AppSnackBar.showError(
              context,
              message: error.toString().replaceAll('Exception:', '').trim(),
            );
          },
          data: (_) {
            if (previous?.isLoading == true) {
              AppSnackBar.showSuccess(
                context,
                message: 'Email confirmed successfully!',
              );
              context.goNamed(RouteNames.verificationSuccess);
            }
          },
        );
      })
      ..listen<AsyncValue<void>>(resendVerificationControllerProvider, (
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
              AppSnackBar.showSuccess(
                context,
                message: 'New 6-digit OTP sent to your email!',
              );
            }
          },
        );
      });

    final verifyState = ref.watch(verifyOtpControllerProvider);
    final resendState = ref.watch(resendVerificationControllerProvider);
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
                        onPressed: () => context.goNamed(RouteNames.login),
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
                  child: Column(
                    children: [
                      // ── Verification Graphic Badge ──────────────────────
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF0D1B2A,
                          ).withValues(alpha: 0.08),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.mark_email_unread_rounded,
                          size: 40.0,
                          color: Color(0xFF0D1B2A),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.space20),

                      Text(
                        'Confirm Your Email OTP',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppColors.darkOnSurface
                              : AppColors.onSurface,
                        ),
                      ),

                      const SizedBox(height: AppSpacing.space8),

                      Text(
                        'We sent a 6-digit confirmation code to ${widget.email}.\nEnter the OTP code below to confirm your account.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark
                              ? AppColors.darkOnSurfaceVariant
                              : AppColors.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 28.0),

                      // ── 6-Digit OTP Code Input Field ─────────────────────
                      AuthInputField(
                        label: 'OTP Code',
                        hintText: 'Enter 6-Digit OTP (e.g. 123456)',
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        onSubmitted: (_) => _handleVerify(),
                      ),

                      const SizedBox(height: AppSpacing.space24),

                      // ── Primary Verify Button ────────────────────────────
                      SizedBox(
                        height: 56.0,
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: verifyState.isLoading
                              ? null
                              : _handleVerify,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D1B2A),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(28.0),
                            ),
                          ),
                          child: verifyState.isLoading
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  'Confirm & Verify',
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.space16),

                      // ── Resend OTP Button ────────────────────────────────
                      AppButton(
                        text: 'Resend OTP Code',
                        variant: AppButtonVariant.ghost,
                        isLoading: resendState.isLoading,
                        onPressed: () {
                          ref
                              .read(
                                resendVerificationControllerProvider.notifier,
                              )
                              .resendVerification(email: widget.email);
                        },
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
