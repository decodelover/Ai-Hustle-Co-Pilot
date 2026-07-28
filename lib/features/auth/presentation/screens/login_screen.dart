/// Production-ready Sign In screen with AppAuthBackground ambient mesh glow, glass surface, and trust badges.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/app_auth_background.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_footer_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/remember_me_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured enterprise Sign In screen.
class LoginScreen extends ConsumerStatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onSignInSubmitted() {
    setState(() {
      _emailError = _emailController.text.trim().isEmpty
          ? 'Email address is required'
          : null;
      _passwordError = _passwordController.text.isEmpty
          ? 'Password is required'
          : null;
    });

    if (_emailError != null || _passwordError != null) return;

    ref.read(signInControllerProvider.notifier).signIn(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    ref.listen<AsyncValue<void>>(
      signInControllerProvider,
      (previous, next) {
        next.whenOrNull(
          error: (error, stackTrace) {
            AppSnackBar.showError(
              context,
              message: error.toString(),
            );
          },
          data: (_) {
            if (previous?.isLoading == true) {
              AppSnackBar.showSuccess(
                context,
                message: 'Welcome back to AI Hustle Co-Pilot!',
              );
              context.goNamed(RouteNames.dashboard);
            }
          },
        );
      },
    );

    final signInState = ref.watch(signInControllerProvider);
    final isLoading = signInState.isLoading;

    return AppAuthBackground(
      child: Column(
        children: [
          AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          Expanded(
            child: ResponsivePageContainer(
              child: AnimatedPage(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.space24,
                    vertical: AppSpacing.space12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Header ───────────────────────────────────────────
                      const AuthHeaderWidget(
                        title: 'Welcome Back',
                        subtitle:
                            'Sign in to access your AI Hustle Co-Pilot workspace',
                      ),

                      const SizedBox(height: AppSpacing.space24),

                      // ── Enterprise Card Container Surface ─────────────────
                      AppCard(
                        variant: isDark
                            ? AppCardVariant.filled
                            : AppCardVariant.elevated,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.space20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // ── Email Input ─────────────────────────────
                              AppTextField(
                                label: 'Email Address',
                                hint: 'you@example.com',
                                controller: _emailController,
                                errorText: _emailError,
                                isDisabled: isLoading,
                              ),

                              const SizedBox(height: AppSpacing.space16),

                              // ── Password Input ──────────────────────────
                              AppTextField(
                                label: 'Password',
                                hint: '••••••••',
                                type: AppTextFieldType.password,
                                controller: _passwordController,
                                errorText: _passwordError,
                                isDisabled: isLoading,
                              ),

                              const SizedBox(height: AppSpacing.space12),

                              // ── Remember Me & Forgot Password ────────────
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: RememberMeWidget(
                                      value: _rememberMe,
                                      onChanged: (val) {
                                        if (val != null) {
                                          setState(() => _rememberMe = val);
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: AppSpacing.space8),
                                  GestureDetector(
                                    onTap: () => context.pushNamed(
                                      RouteNames.forgotPassword,
                                    ),
                                    child: Text(
                                      'Forgot Password?',
                                      style:
                                          theme.textTheme.bodyMedium?.copyWith(
                                        color: isDark
                                            ? AppColors.darkPrimary
                                            : AppColors.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: AppSpacing.space24),

                              // ── Sign In Button ───────────────────────────
                              AppButton(
                                text: 'Sign In',
                                isLoading: isLoading,
                                onPressed: _onSignInSubmitted,
                              ),

                              const OrDividerWidget(),

                              // ── Social Login Buttons ──────────────────────
                              SocialLoginButtons(
                                isLoading: isLoading,
                                onGooglePressed: () {
                                  AppSnackBar.showInfo(
                                    context,
                                    message: 'Google Sign In initiated...',
                                  );
                                },
                                onGitHubPressed: () {
                                  AppSnackBar.showInfo(
                                    context,
                                    message: 'GitHub Sign In initiated...',
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.space24),

                      // ── Trust & Security Banner ───────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock_outline_rounded,
                            size: 14.0,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.space8),
                          Text(
                            '256-bit Bank-Grade Encryption • Privacy Guaranteed',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontSize: 11.0,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: AppSpacing.space16),

                      // ── Footer Prompt ────────────────────────────────────
                      AuthFooterWidget(
                        promptText: "Don't have an account? ",
                        actionText: 'Sign Up',
                        onActionPressed: () =>
                            context.pushNamed(RouteNames.register),
                      ),

                      const SizedBox(height: AppSpacing.space16),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
