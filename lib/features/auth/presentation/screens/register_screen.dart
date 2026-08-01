/// Account creation experience connected to the existing auth controller.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_experience_scaffold.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_footer_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/password_strength_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/terms_checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured create-account screen.
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
  final _confirmController = TextEditingController();
  bool _agreeToTerms = true;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  void _submit() {
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
      _confirmError = _confirmController.text != _passwordController.text
          ? 'Passwords do not match'
          : null;
    });
    if ([
      _nameError,
      _emailError,
      _passwordError,
      _confirmError,
    ].any((error) => error != null)) {
      return;
    }
    if (!_agreeToTerms) {
      AppSnackBar.showError(
        context,
        message: 'Please accept the Terms of Service and Privacy Policy.',
      );
      return;
    }

    ref
        .read(signUpControllerProvider.notifier)
        .signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _nameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signUpControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) => AppSnackBar.showError(
          context,
          message: error.toString().replaceAll('Exception:', '').trim(),
        ),
        data: (_) {
          if (previous?.isLoading == true) {
            context.goNamed(
              RouteNames.verifyEmail,
              extra: _emailController.text.trim(),
            );
          }
        },
      );
    });

    final isLoading = ref.watch(signUpControllerProvider).isLoading;
    return AuthExperienceScaffold(
      kicker: 'Create your workspace',
      title: 'Create your account',
      subtitle: 'Start your journey with AI Hustle Co-Pilot',
      onBack: context.pop,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AuthInputField(
              label: 'Full name',
              hintText: 'Your full name',
              controller: _nameController,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              errorText: _nameError,
              isDisabled: isLoading,
            ),
            const SizedBox(height: AppSpacing.space16),
            AuthInputField(
              label: 'Email',
              hintText: 'you@example.com',
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              errorText: _emailError,
              isDisabled: isLoading,
            ),
            const SizedBox(height: AppSpacing.space16),
            AuthInputField(
              label: 'Password',
              hintText: 'At least 6 characters',
              controller: _passwordController,
              isPassword: true,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.newPassword],
              errorText: _passwordError,
              isDisabled: isLoading,
              onChanged: (_) => setState(() {}),
            ),
            PasswordStrengthWidget(password: _passwordController.text),
            const SizedBox(height: AppSpacing.space16),
            AuthInputField(
              label: 'Confirm password',
              hintText: 'Re-enter your password',
              controller: _confirmController,
              isPassword: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.newPassword],
              errorText: _confirmError,
              isDisabled: isLoading,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: AppSpacing.space12),
            TermsCheckboxWidget(
              value: _agreeToTerms,
              onChanged: (value) {
                if (!isLoading) setState(() => _agreeToTerms = value ?? false);
              },
            ),
            const SizedBox(height: AppSpacing.space20),
            AppButton(
              text: 'Sign Up',
              height: 52,
              isLoading: isLoading,
              onPressed: _submit,
            ),
            const OrDividerWidget(label: 'Or Sign Up With'),
            SocialLoginButtons(isLoading: isLoading),
            const SizedBox(height: AppSpacing.space20),
            AuthFooterWidget(
              promptText: 'Already have an account?',
              actionText: 'Sign in',
              onActionPressed: () {
                if (!isLoading) context.pushNamed(RouteNames.login);
              },
            ),
          ],
        ),
      ),
    );
  }
}
