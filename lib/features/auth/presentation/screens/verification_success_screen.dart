/// Celebratory Verification Success screen.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Full-screen celebration view shown after successful email verification.
class VerificationSuccessScreen extends StatelessWidget {
  /// Creates a [VerificationSuccessScreen].
  const VerificationSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsivePageContainer(
          child: AnimatedPage(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.space24),
              child: AppSuccessState(
                title: 'Account Verified!',
                message:
                    'Your email address has been successfully verified. Welcome to AI Hustle Co-Pilot!',
                actionLabel: 'Continue to Dashboard',
                onAction: () => context.goNamed(RouteNames.dashboard),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
