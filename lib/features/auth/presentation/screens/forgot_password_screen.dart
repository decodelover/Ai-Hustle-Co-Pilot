/// Responsive password recovery experience.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_experience_scaffold.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured password recovery screen.
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
        error: (error, stackTrace) => AppSnackBar.showError(
          context,
          message: error.toString().replaceAll('Exception:', '').trim(),
        ),
        data: (_) {
          if (previous?.isLoading == true) {
            setState(() => _isSubmittedSuccess = true);
          }
        },
      );
    });

    final isLoading = ref.watch(resetPasswordControllerProvider).isLoading;
    return AuthExperienceScaffold(
      eyebrow: 'Recovery',
      headline: 'A quick reset. No lost momentum.',
      description:
          'We will send a secure recovery link so you can get back to your workspace with confidence.',
      formTitle: _isSubmittedSuccess ? 'Reset Link Sent!' : 'Reset Password',
      formDescription: _isSubmittedSuccess
          ? 'Your next step is waiting in your inbox.'
          : 'Enter your account email and we will send a password reset link.',
      icon: _isSubmittedSuccess
          ? Icons.mark_email_read_rounded
          : Icons.lock_reset_rounded,
      onBack: context.pop,
      child: AnimatedSwitcher(
        duration: AppMotion.medium,
        child: _isSubmittedSuccess
            ? _RecoverySuccess(
                key: const ValueKey('recovery-success'),
                email: _emailController.text.trim(),
              )
            : Column(
                key: const ValueKey('recovery-form'),
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  AuthInputField(
                    label: 'Email',
                    hintText: 'you@example.com',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    autofillHints: const [AutofillHints.email],
                    errorText: _emailError,
                    isDisabled: isLoading,
                    onSubmitted: (_) => _onResetSubmitted(),
                  ),
                  const SizedBox(height: AppSpacing.space24),
                  AppButton(
                    text: 'Send Reset Link',
                    height: 56,
                    isLoading: isLoading,
                    onPressed: _onResetSubmitted,
                    trailingIcon: Icons.arrow_forward_rounded,
                  ),
                  const SizedBox(height: AppSpacing.space12),
                  AppButton(
                    text: 'Back to Sign In',
                    variant: AppButtonVariant.ghost,
                    onPressed: () => context.goNamed(RouteNames.login),
                  ),
                ],
              ),
      ),
    );
  }
}

class _RecoverySuccess extends StatelessWidget {
  const _RecoverySuccess({required this.email, super.key});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Icon(
          Icons.check_circle_rounded,
          size: 72,
          color: AppColors.success,
        ),
        const SizedBox(height: AppSpacing.space16),
        Text(
          'We sent a password recovery email to $email. Check your inbox and follow the secure link.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.space24),
        AppButton(
          text: 'Return to Sign In',
          onPressed: () => context.goNamed(RouteNames.login),
        ),
      ],
    );
  }
}
