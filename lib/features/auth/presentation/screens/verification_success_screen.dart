/// Celebratory verification success experience.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/widgets/auth_experience_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Full-screen celebration shown after successful email verification.
class VerificationSuccessScreen extends StatelessWidget {
  /// Creates a [VerificationSuccessScreen].
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthExperienceScaffold(
      eyebrow: 'Ready to move',
      headline: 'Your workspace is open.',
      description:
          'The setup is complete. Your AI co-pilot is ready to help turn the next opportunity into momentum.',
      formTitle: 'Account Verified!',
      formDescription:
          'Your email address has been successfully verified. Welcome to AI Hustle Co-Pilot!',
      icon: Icons.celebration_rounded,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.verified_rounded,
            size: 88,
            color: AppColors.success,
          ),
          const SizedBox(height: AppSpacing.space24),
          Text(
            'Everything is connected. Step into your dashboard and choose the next best move.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: AppSpacing.space24),
          AppButton(
            text: 'Continue to Dashboard',
            height: 56,
            onPressed: () => context.goNamed(RouteNames.dashboard),
            trailingIcon: Icons.arrow_forward_rounded,
          ),
        ],
      ),
    );
  }
}
