/// Responsive sign-in experience connected to the existing auth controller.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_experience_scaffold.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_footer_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/remember_me_widget.dart';
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
  bool _rememberMe = true;
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
      eyebrow: 'Welcome back',
      headline: 'Your next win is already in motion.',
      description:
          'Return to one calm workspace for opportunities, proposals, clients, and the next best action.',
      formTitle: 'Sign in',
      formDescription:
          'Pick up where you left off and keep your freelance work moving.',
      icon: Icons.track_changes_rounded,
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
            const SizedBox(height: AppSpacing.space20),
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
            const SizedBox(height: AppSpacing.space8),
            LayoutBuilder(
              builder: (context, constraints) {
                final useColumn =
                    constraints.maxWidth < 340 ||
                    MediaQuery.textScalerOf(context).scale(1) > 1.3;
                final remember = RememberMeWidget(
                  value: _rememberMe,
                  onChanged: (value) {
                    if (value != null) setState(() => _rememberMe = value);
                  },
                );
                final forgot = TextButton(
                  onPressed: isLoading
                      ? null
                      : () => context.pushNamed(RouteNames.forgotPassword),
                  child: const Text('Forgot Password?'),
                );
                if (useColumn) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      remember,
                      Align(child: forgot),
                    ],
                  );
                }
                return Row(
                  children: [
                    Expanded(child: remember),
                    forgot,
                  ],
                );
              },
            ),
            const SizedBox(height: AppSpacing.space16),
            AppButton(
              text: 'Login',
              height: 56,
              isLoading: isLoading,
              onPressed: _submit,
              trailingIcon: Icons.arrow_forward_rounded,
            ),
            const SizedBox(height: AppSpacing.space24),
            const OrDividerWidget(),
            const SizedBox(height: AppSpacing.space20),
            SocialLoginButtons(isLoading: isLoading),
            const SizedBox(height: AppSpacing.space8),
            Text(
              'Social sign-in becomes available when a provider is connected.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.space20),
            AuthFooterWidget(
              promptText: "Don't have an account?",
              actionText: 'Sign up',
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
