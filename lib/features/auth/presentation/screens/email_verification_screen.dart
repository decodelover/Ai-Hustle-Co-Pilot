/// Email OTP confirmation experience connected to the existing auth flow.
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
        message: 'Please enter the 6-digit code sent to your email.',
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
                message: 'New verification code sent to your email.',
              );
            }
          },
        );
      });

    final verifyState = ref.watch(verifyOtpControllerProvider);
    final resendState = ref.watch(resendVerificationControllerProvider);
    final canResend = _secondsRemaining == 0 && !resendState.isLoading;

    return AuthExperienceScaffold(
      kicker: 'Almost there',
      title: 'Confirm your email',
      subtitle: 'Enter the 6-digit code sent to ${widget.email}.',
      onBack: () => context.goNamed(RouteNames.login),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _VerificationNotice(
            email: widget.email,
            secondsRemaining: _secondsRemaining,
          ),
          const SizedBox(height: AppSpacing.space20),
          AuthInputField(
            label: 'Verification code',
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
            text: 'Verify email',
            height: 52,
            isLoading: verifyState.isLoading,
            onPressed: _handleVerify,
          ),
          const SizedBox(height: AppSpacing.space8),
          TextButton(
            onPressed: canResend ? _resend : null,
            style: TextButton.styleFrom(
              foregroundColor: AppColors.primary,
              disabledForegroundColor: AppColors.secondaryText,
              minimumSize: const Size(48, 48),
            ),
            child: Text(
              resendState.isLoading
                  ? 'Sending new code…'
                  : canResend
                  ? 'Resend code'
                  : 'Resend code in ${_secondsRemaining}s',
            ),
          ),
        ],
      ),
    );
  }
}

class _VerificationNotice extends StatelessWidget {
  const _VerificationNotice({
    required this.email,
    required this.secondsRemaining,
  });

  final String email;
  final int secondsRemaining;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final color = isDark ? AppColors.darkSecondary : AppColors.secondary;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.space16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: AppRadius.borderMedium,
        border: Border.all(color: color.withValues(alpha: 0.12)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.mark_email_unread_outlined, color: color, size: 20),
          const SizedBox(width: AppSpacing.space12),
          Expanded(
            child: Text.rich(
              TextSpan(
                text: 'Check ',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(height: 1.45),
                children: [
                  TextSpan(
                    text: email,
                    style: const TextStyle(fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text:
                        '. The code expires in ${secondsRemaining.toString().padLeft(2, '0')}s.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
