/// Production-ready Forgot Password screen with AppAuthBackground ambient mesh glow & glass surface.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/app_auth_background.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured Password Recovery screen.
class ForgotPasswordScreen extends ConsumerStatefulWidget {
  /// Creates a [ForgotPasswordScreen].
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState
    extends ConsumerState<ForgotPasswordScreen> {
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

    ref.read(resetPasswordControllerProvider.notifier).resetPassword(
          email: _emailController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    ref.listen<AsyncValue<void>>(
      resetPasswordControllerProvider,
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
              setState(() => _isSubmittedSuccess = true);
            }
          },
        );
      },
    );

    final resetState = ref.watch(resetPasswordControllerProvider);
    final isLoading = resetState.isLoading;

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
                    vertical: AppSpacing.space16,
                  ),
                  child: _isSubmittedSuccess
                      ? AppSuccessState(
                          title: 'Reset Link Sent!',
                          message:
                              'We sent a password recovery email to ${_emailController.text.trim()}. Please check your inbox.',
                          actionLabel: 'Return to Sign In',
                          onAction: () => context.goNamed(RouteNames.login),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const AuthHeaderWidget(
                              title: 'Reset Password',
                              subtitle:
                                  'Enter your account email and we will send a password reset link',
                            ),

                            const SizedBox(height: AppSpacing.space24),

                            // ── Card Container ────────────────────────────
                            AppCard(
                              variant: isDark
                                  ? AppCardVariant.filled
                                  : AppCardVariant.elevated,
                              child: Padding(
                                padding:
                                    const EdgeInsets.all(AppSpacing.space20),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    AppTextField(
                                      label: 'Email Address',
                                      hint: 'you@example.com',
                                      controller: _emailController,
                                      errorText: _emailError,
                                      isDisabled: isLoading,
                                    ),

                                    const SizedBox(height: AppSpacing.space24),

                                    AppButton(
                                      text: 'Send Reset Link',
                                      isLoading: isLoading,
                                      onPressed: _onResetSubmitted,
                                    ),

                                    const SizedBox(height: AppSpacing.space12),

                                    AppButton(
                                      text: 'Back to Sign In',
                                      variant: AppButtonVariant.ghost,
                                      onPressed: () =>
                                          context.goNamed(RouteNames.login),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const SizedBox(height: AppSpacing.space24),

                            // ── Security Help Footer ───────────────────────
                            Center(
                              child: Text(
                                'Need further assistance? Contact Support',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ),
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
