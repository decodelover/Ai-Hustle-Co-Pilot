/// Production-ready Email OTP Verification screen.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured 6-digit OTP Email Verification screen.
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

    ref.read(verifyOtpControllerProvider.notifier).verifyOtp(
          email: widget.email,
          token: code,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    ref
      ..listen<AsyncValue<void>>(
        verifyOtpControllerProvider,
        (previous, next) {
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
        },
      )
      ..listen<AsyncValue<void>>(
        resendVerificationControllerProvider,
        (previous, next) {
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
        },
      );

    final verifyState = ref.watch(verifyOtpControllerProvider);
    final resendState = ref.watch(resendVerificationControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: ResponsivePageContainer(
          child: AnimatedPage(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space24),
              child: Column(
                children: [
                  // Top Back Action
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => context.goNamed(RouteNames.login),
                      icon: const Icon(Icons.arrow_back_rounded),
                    ),
                  ),

                  const Spacer(),

                  // ── Verification Graphic Badge ──────────────────────
                  Container(
                    width: 88.0,
                    height: 88.0,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkPrimary.withValues(alpha: 0.15)
                          : AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_unread_rounded,
                      size: 44.0,
                      color: isDark ? AppColors.darkPrimary : AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.space24),

                  Text(
                    'Confirm Your Email OTP',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
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

                  const SizedBox(height: AppSpacing.space32),

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
                  AppButton(
                    text: 'Confirm & Verify',
                    isLoading: verifyState.isLoading,
                    onPressed: _handleVerify,
                  ),

                  const SizedBox(height: AppSpacing.space16),

                  // ── Resend OTP Button ────────────────────────────────
                  AppButton(
                    text: 'Resend OTP Code',
                    variant: AppButtonVariant.ghost,
                    isLoading: resendState.isLoading,
                    onPressed: () {
                      ref
                          .read(resendVerificationControllerProvider.notifier)
                          .resendVerification(email: widget.email);
                    },
                  ),

                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
