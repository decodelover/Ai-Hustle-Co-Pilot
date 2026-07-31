/// Account creation screen connected to the shared onboarding brand system.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_input_field.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/or_divider_widget.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/social_login_buttons.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/terms_checkbox_widget.dart';
import 'package:ai_hustle_copilot/shared/widgets/app_brand_background.dart';
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
  bool _agreeToTerms = true;
  String? _nameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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
    });
    if (_nameError != null || _emailError != null || _passwordError != null) {
      return;
    }
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please accept the Terms of Service.'),
          backgroundColor: AppColors.danger,
        ),
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
        error: (error, stackTrace) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString().replaceAll('Exception:', '').trim()),
              backgroundColor: AppColors.danger,
            ),
          );
        },
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
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppBrandBackground(
        headerHeight: 220,
        header: const _RegisterBrandHeader(),
        child: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(28, 44, 28, 28),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text('Create an Account', style: textTheme.headlineLarge),
                    const SizedBox(height: AppSpacing.space8),
                    Text(
                      'Set up your workspace and turn good ideas into repeatable progress.',
                      style: textTheme.bodyMedium?.copyWith(
                        color: AppColors.secondaryText,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space24),
                    AuthInputField(
                      label: 'Name',
                      hintText: 'Your full name',
                      controller: _nameController,
                      errorText: _nameError,
                      isDisabled: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    AuthInputField(
                      label: 'Email',
                      hintText: 'you@example.com',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      errorText: _emailError,
                      isDisabled: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    AuthInputField(
                      label: 'Password',
                      hintText: 'At least 6 characters',
                      isPassword: true,
                      controller: _passwordController,
                      errorText: _passwordError,
                      isDisabled: isLoading,
                    ),
                    const SizedBox(height: AppSpacing.space12),
                    TermsCheckboxWidget(
                      value: _agreeToTerms,
                      onChanged: (value) {
                        if (!isLoading) {
                          setState(() => _agreeToTerms = value ?? false);
                        }
                      },
                    ),
                    const SizedBox(height: AppSpacing.space16),
                    SizedBox(
                      height: 56,
                      child: FilledButton(
                        onPressed: isLoading ? null : _submit,
                        child: isLoading
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  color: AppColors.onPrimary,
                                  strokeWidth: 2.5,
                                ),
                              )
                            : const Text('Create account'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.space20),
                    const OrDividerWidget(),
                    SocialLoginButtons(
                      isLoading: isLoading,
                      onFacebookPressed: () {},
                      onGooglePressed: () {},
                      onApplePressed: () {},
                    ),
                    const SizedBox(height: AppSpacing.space20),
                    Center(
                      child: TextButton(
                        onPressed: () => context.pushNamed(RouteNames.login),
                        child: const Text('Already have an account? Sign in'),
                      ),
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

class _RegisterBrandHeader extends StatelessWidget {
  const _RegisterBrandHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Row(
        children: [
          IconButton(
            tooltip: 'Back',
            onPressed: context.pop,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: AppColors.onPrimary,
            ),
          ),
          const _RegisterBrandMark(),
          const SizedBox(width: AppSpacing.space12),
          const Text(
            'AI Hustle Co-Pilot',
            style: TextStyle(
              color: AppColors.onPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _RegisterBrandMark extends StatelessWidget {
  const _RegisterBrandMark();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.onPrimary.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(14),
      ),
      child: const Icon(
        Icons.auto_awesome_rounded,
        color: AppColors.onPrimary,
        size: 20,
      ),
    );
  }
}
