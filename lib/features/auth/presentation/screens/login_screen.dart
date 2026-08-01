/// Sign-in experience connected to the existing auth controller.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_experience_scaffold.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_footer_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured sign-in screen.
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submit() {
    setState(() {
      _emailError = _emailController.text.trim().isEmpty
          ? 'Email address is required'
          : null;
      _passwordError = _passwordController.text.isEmpty
          ? 'Password is required'
          : null;
    });
    if (_emailError != null || _passwordError != null) return;

    ref
        .read(signInControllerProvider.notifier)
        .signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<void>>(signInControllerProvider, (previous, next) {
      next.whenOrNull(
        error: (error, stackTrace) => AppSnackBar.showError(
          context,
          message: error.toString().replaceAll('Exception:', '').trim(),
        ),
        data: (_) {
          if (previous?.isLoading == true) {
            context.goNamed(RouteNames.dashboard);
          }
        },
      );
    });

    final isLoading = ref.watch(signInControllerProvider).isLoading;
    return AuthExperienceScaffold(
      kicker: 'Sign in to continue',
      title: 'Welcome Back!',
      subtitle: 'Log in to your Co-Pilot',
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
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
              hintText: 'Enter your password',
              isPassword: true,
              controller: _passwordController,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              errorText: _passwordError,
              isDisabled: isLoading,
              onSubmitted: (_) => _submit(),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: isLoading
                    ? null
                    : () => context.pushNamed(RouteNames.forgotPassword),
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  minimumSize: const Size(48, 44),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text('Forgot Password?'),
              ),
            ),
            const SizedBox(height: AppSpacing.space8),
            AppButton(
              text: 'Sign in',
              height: 52,
              isLoading: isLoading,
              onPressed: _submit,
            ),
            const OrDividerWidget(),
            SocialLoginButtons(isLoading: isLoading),
            const SizedBox(height: AppSpacing.space20),
            AuthFooterWidget(
              promptText: "Don't have an account?",
              actionText: 'Sign Up',
              onActionPressed: () {
                if (!isLoading) context.pushNamed(RouteNames.register);
              },
            ),
          ],
        ),
      ),
    );
  }
}
