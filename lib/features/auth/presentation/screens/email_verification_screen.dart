/// Responsive email OTP verification experience.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_experience_scaffold.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured six-digit OTP email verification screen.
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
  final _otpController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 60;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    _timer?.cancel();
    _secondsRemaining = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_secondsRemaining <= 1) {
        timer.cancel();
        setState(() => _secondsRemaining = 0);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
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

  void _resend() {
    ref
        .read(resendVerificationControllerProvider.notifier)
        .resendVerification(email: widget.email);
    _startCountdown();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ref
      ..listen<AsyncValue<void>>(verifyOtpControllerProvider, (previous, next) {
        next.whenOrNull(
          error: (error, stackTrace) => AppSnackBar.showError(
            context,
            message: error.toString().replaceAll('Exception:', '').trim(),
          ),
          data: (_) {
            if (previous?.isLoading == true) {
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
          error: (error, stackTrace) => AppSnackBar.showError(
            context,
            message: error.toString().replaceAll('Exception:', '').trim(),
          ),
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
    final canResend = _secondsRemaining == 0 && !resendState.isLoading;
    return AuthExperienceScaffold(
      eyebrow: 'One last step',
      headline: 'Secure the workspace you are building.',
      description:
          'A short verification keeps your projects, client details, and momentum connected to you.',
      formTitle: 'Confirm Your Email OTP',
      formDescription:
          'We sent a 6-digit confirmation code to ${widget.email}.',
      icon: Icons.mark_email_unread_rounded,
      onBack: () => context.goNamed(RouteNames.login),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.space16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.08),
              borderRadius: AppRadius.borderMedium,
            ),
            child: const Row(
              children: [
                Icon(Icons.shield_outlined, color: AppColors.primary),
                SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Text(
                    'Enter the code from your email. It expires for your protection.',
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.space20),
          AuthInputField(
            label: 'OTP Code',
            hintText: '123456',
            controller: _otpController,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.oneTimeCode],
            maxLength: 6,
            isDisabled: verifyState.isLoading,
            onSubmitted: (_) => _handleVerify(),
          ),
          const SizedBox(height: AppSpacing.space24),
          AppButton(
            text: verifyState.isLoading ? 'Checking code' : 'Confirm & Verify',
            height: 56,
            isLoading: verifyState.isLoading,
            onPressed: _handleVerify,
            trailingIcon: Icons.verified_user_outlined,
          ),
          const SizedBox(height: AppSpacing.space12),
          AppButton(
            text: resendState.isLoading
                ? 'Sending new code'
                : 'Resend OTP Code',
            variant: AppButtonVariant.ghost,
            isLoading: resendState.isLoading,
            isDisabled: !canResend,
            onPressed: _resend,
          ),
          if (!canResend && !resendState.isLoading)
            Text(
              'Available again in ${_secondsRemaining}s',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
        ],
      ),
    );
  }
}
