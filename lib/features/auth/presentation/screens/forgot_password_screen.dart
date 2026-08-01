/// Password recovery experience connected to the existing auth controller.
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
      kicker: 'Reset access',
      title: _isSubmittedSuccess ? 'Check your inbox' : 'Forgot Password?',
      subtitle: _isSubmittedSuccess
          ? 'We sent a secure reset link to your email address.'
          : 'Enter your email and we’ll help you get back in.',
      onBack: () => context.goNamed(RouteNames.login),
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
                    text: 'Send reset link',
                    height: 52,
                    isLoading: isLoading,
                    onPressed: _onResetSubmitted,
                  ),
                  const SizedBox(height: AppSpacing.space8),
                  TextButton(
                    onPressed: isLoading
                        ? null
                        : () => context.goNamed(RouteNames.login),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.primary,
                      minimumSize: const Size(48, 48),
                    ),
                    child: const Text('Back to Sign In'),
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: (isDark ? AppColors.darkSuccess : AppColors.success)
                  .withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mark_email_read_rounded,
              color: isDark ? AppColors.darkSuccess : AppColors.success,
              size: 34,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.space20),
        Text(
          'We sent a secure password reset link to $email. Check your inbox to continue.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: AppSpacing.space24),
        AppButton(
          text: 'Return to Sign In',
          height: 52,
          onPressed: () => context.goNamed(RouteNames.login),
        ),
      ],
    );
  }
}
