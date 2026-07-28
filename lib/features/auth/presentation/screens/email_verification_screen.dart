/// Production-ready Email Verification status screen using Riverpod auth controllers.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Full-featured Email Verification screen.
class EmailVerificationScreen extends ConsumerWidget {
  /// Creates an [EmailVerificationScreen].
  const EmailVerificationScreen({
    super.key,
    this.email = 'your registered email address',
  });

  /// User's registered email address.
  final String email;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    ref
      ..listen<AsyncValue<void>>(
        resendVerificationControllerProvider,
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
                  message: 'Verification link resent successfully!',
                );
              }
            },
          );
        },
      )
      ..listen<AsyncValue<void>>(
        refreshSessionControllerProvider,
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
                  message: 'Email status updated!',
                );
                context.goNamed(RouteNames.verificationSuccess);
              }
            },
          );
        },
      );

    final resendState = ref.watch(resendVerificationControllerProvider);
    final refreshState = ref.watch(refreshSessionControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: ResponsivePageContainer(
          child: AnimatedPage(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space24),
              child: Column(
                children: [
                  const Spacer(),

                  // ── Verification Graphic Badge ──────────────────────
                  Container(
                    width: 96.0,
                    height: 96.0,
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppColors.darkPrimary.withValues(alpha: 0.15)
                          : AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.mark_email_unread_rounded,
                      size: 48.0,
                      color: isDark ? AppColors.darkPrimary : AppColors.primary,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.space24),

                  Text(
                    'Verify Your Email',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.space8),

                  Text(
                    'We sent a confirmation link to $email. Please click the link in your inbox to complete registration.',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark
                          ? AppColors.darkOnSurfaceVariant
                          : AppColors.onSurfaceVariant,
                    ),
                  ),

                  const Spacer(),

                  // ── Primary Actions ─────────────────────────────────
                  AppButton(
                    text: 'Resend Verification Email',
                    isLoading: resendState.isLoading,
                    onPressed: () {
                      ref
                          .read(resendVerificationControllerProvider.notifier)
                          .resendVerification(email: email);
                    },
                  ),

                  const SizedBox(height: AppSpacing.space12),

                  AppButton(
                    text: 'Refresh Status',
                    variant: AppButtonVariant.outlined,
                    isLoading: refreshState.isLoading,
                    onPressed: () {
                      ref
                          .read(refreshSessionControllerProvider.notifier)
                          .refreshSession();
                    },
                  ),

                  const SizedBox(height: AppSpacing.space12),

                  AppButton(
                    text: 'Back to Sign In',
                    variant: AppButtonVariant.ghost,
                    onPressed: () => context.goNamed(RouteNames.login),
                  ),

                  const SizedBox(height: AppSpacing.space16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
