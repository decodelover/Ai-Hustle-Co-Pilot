/// Verification success experience for newly confirmed accounts.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_experience_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Full-screen success state shown after email verification.
class VerificationSuccessScreen extends StatelessWidget {
  /// Creates a [VerificationSuccessScreen].
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final success = isDark ? AppColors.darkSuccess : AppColors.success;

    return AuthExperienceScaffold(
      kicker: 'You’re all set',
      title: 'Email confirmed',
      subtitle: 'Your account is ready. Welcome to AI Hustle Co-Pilot.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                color: success.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                border: Border.all(color: success.withValues(alpha: 0.18)),
              ),
              child: Icon(Icons.verified_rounded, color: success, size: 46),
            ),
          ),
          const SizedBox(height: AppSpacing.space24),
          Text(
            'Everything is connected. Step into your dashboard and choose your next best move.',
            textAlign: TextAlign.center,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
          const SizedBox(height: AppSpacing.space24),
          AppButton(
            text: 'Continue to Dashboard',
            height: 52,
            onPressed: () => context.goNamed(RouteNames.dashboard),
          ),
        ],
      ),
    );
  }
}
