/// Production-ready Sign Up screen with AppAuthBackground ambient mesh glow, glass surface, and trust badges.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/app_auth_background.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_footer_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/password_strength_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/terms_checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured enterprise Sign Up screen.
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
  final _confirmPasswordController = TextEditingController();

  bool _agreeToTerms = false;
  String? _nameError;
  String? _emailError;
  String? _passwordError;
  String? _confirmPasswordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _onSignUpSubmitted() {
    setState(() {
      _nameError = _nameController.text.trim().isEmpty
          ? 'Full name is required'
          : null;
      _emailError = _emailController.text.trim().isEmpty
          ? 'Email address is required'
          : null;
      _passwordError = _passwordController.text.length < 8
          ? 'Password must be at least 8 characters'
          : null;
      _confirmPasswordError =
          _confirmPasswordController.text != _passwordController.text
              ? 'Passwords do not match'
              : null;
    });

    if (_nameError != null ||
        _emailError != null ||
        _passwordError != null ||
        _confirmPasswordError != null) {
      return;
    }

    if (!_agreeToTerms) {
      AppSnackBar.showWarning(
        context,
        message: 'Please accept the Terms of Service and Privacy Policy.',
      );
      return;
    }

    ref.read(signUpControllerProvider.notifier).signUp(
          email: _emailController.text.trim(),
          password: _passwordController.text,
          displayName: _nameController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    ref.listen<AsyncValue<void>>(
      signUpControllerProvider,
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
                message: 'Account created! Please verify your email.',
              );
              context.goNamed(RouteNames.verifyEmail);
            }
          },
        );
      },
    );

    final signUpState = ref.watch(signUpControllerProvider);
    final isLoading = signUpState.isLoading;

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
                        title: 'Create Your Account',
                        subtitle:
                            'Start automating your freelancing hustle today',
                      ),

                      const SizedBox(height: AppSpacing.space24),

                      // ── Card Surface Container ────────────────────────────
                      AppCard(
                        variant: isDark
                            ? AppCardVariant.filled
                            : AppCardVariant.elevated,
                        child: Padding(
                          padding: const EdgeInsets.all(AppSpacing.space20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // ── Full Name Field ──────────────────────────
                              AppTextField(
                                label: 'Full Name',
                                hint: 'Alex Johnson',
                                controller: _nameController,
                                errorText: _nameError,
                                isDisabled: isLoading,
                              ),

                              const SizedBox(height: AppSpacing.space16),

                              // ── Email Address Field ──────────────────────
                              AppTextField(
                                label: 'Email Address',
                                hint: 'you@example.com',
                                controller: _emailController,
                                errorText: _emailError,
                                isDisabled: isLoading,
                              ),

                              const SizedBox(height: AppSpacing.space16),

                              // ── Password Field ───────────────────────────
                              AppTextField(
                                label: 'Password',
                                hint: '••••••••',
                                type: AppTextFieldType.password,
                                controller: _passwordController,
                                errorText: _passwordError,
                                isDisabled: isLoading,
                                onChanged: (_) => setState(() {}),
                              ),

                              PasswordStrengthWidget(
                                password: _passwordController.text,
                              ),

                              const SizedBox(height: AppSpacing.space16),

                              // ── Confirm Password Field ───────────────────
                              AppTextField(
                                label: 'Confirm Password',
                                hint: '••••••••',
                                type: AppTextFieldType.password,
                                controller: _confirmPasswordController,
                                errorText: _confirmPasswordError,
                                isDisabled: isLoading,
                              ),

                              const SizedBox(height: AppSpacing.space16),

                              // ── Terms & Conditions Checkbox ───────────────
                              TermsCheckboxWidget(
                                value: _agreeToTerms,
                                onChanged: (val) {
                                  if (val != null) {
                                    setState(() => _agreeToTerms = val);
                                  }
                                },
                              ),

                              const SizedBox(height: AppSpacing.space24),

                              // ── Create Account Button ────────────────────
                              AppButton(
                                text: 'Create Account',
                                isLoading: isLoading,
                                onPressed: _onSignUpSubmitted,
                              ),

                              const OrDividerWidget(),

                              // ── Social Login Buttons ──────────────────────
                              SocialLoginButtons(
                                isLoading: isLoading,
                                onGooglePressed: () {
                                  AppSnackBar.showInfo(
                                    context,
                                    message: 'Google Sign Up initiated...',
                                  );
                                },
                                onGitHubPressed: () {
                                  AppSnackBar.showInfo(
                                    context,
                                    message: 'GitHub Sign Up initiated...',
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: AppSpacing.space24),

                      // ── Security & Trust Banner ───────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shield_outlined,
                            size: 14.0,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: AppSpacing.space8),
                          Text(
                            '100% Free Trial • No Credit Card Required',
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
                        promptText: 'Already have an account? ',
                        actionText: 'Sign In',
                        onActionPressed: () =>
                            context.pushNamed(RouteNames.login),
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
