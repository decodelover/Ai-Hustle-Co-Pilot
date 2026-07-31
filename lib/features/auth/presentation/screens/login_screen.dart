/// Sign-in screen connected to the shared onboarding brand system.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_footer_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/brand_identity_header.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:ai_hustle_copilot/shared/widgets/app_brand_background.dart';
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
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.toString().replaceAll('Exception:', '').trim(),
              ),
              backgroundColor: AppColors.danger,
            ),
          );
        },
        data: (_) {
          if (previous?.isLoading == true) {
            context.goNamed(RouteNames.dashboard);
          }
        },
      );
    });

    final isLoading = ref.watch(signInControllerProvider).isLoading;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBrandBackground(
        header: const BrandIdentityHeader(),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 24, 28, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Sign in',
                      style: textTheme.headlineLarge?.copyWith(
                        color: AppColors.primaryText,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    Container(
                      width: 54,
                      height: 3,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(3),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    Text(
                      'Pick up where you left off and keep your freelance work moving.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondaryText,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space24),
                    AuthInputField(
                      label: 'Email',
                      hintText: 'you@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      errorText: _emailError,
                      isDisabled: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.space20),
                    AuthInputField(
                      label: 'Password',
                      hintText: 'Enter your password',
                      isPassword: true,
                      controller: _passwordController,
                      errorText: _passwordError,
                      isDisabled: isLoading,
                      onSubmitted: (_) => _submit(),
                    ),
                    const SizedBox(height: AppSpacing.space8),
                    Row(
                      children: [
                        Expanded(
                          child: RememberMeWidget(
                            value: _rememberMe,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => _rememberMe = value);
                              }
                            },
                          ),
                        ),
                        TextButton(
                          onPressed: isLoading
                              ? null
                              : () => context.pushNamed(
                                  RouteNames.forgotPassword,
                                ),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.primary,
                            minimumSize: const Size(48, 48),
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('Forgot Password?'),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: isLoading ? null : _submit,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.onPrimary,
                          disabledBackgroundColor: AppColors.primary.withValues(
                            alpha: 0.45,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: AppColors.onPrimary,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text('Login'),
                      ),
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
            ),
          ),
        ),
      ),
    );
  }
}
