/// Abstracted AI Copilot Launcher service.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for [AiLauncherService].
final aiLauncherServiceProvider = Provider<AiLauncherService>((ref) {
  return const AiLauncherService();
});

/// Centralized service handling AI Copilot launcher triggers.
class AiLauncherService {
  /// Creates an [AiLauncherService].
  const AiLauncherService();

  /// Launches the AI Copilot modal assistant contextually.
  void launchCopilot(BuildContext context, {String? prompt}) {
    AppBottomSheet.show<void>(
      context: context,
      title: 'AI Hustle Co-Pilot Assistant',
      child: Column(
        children: [
          const AppTextField(
            hint: 'Ask AI Co-Pilot anything...',
            prefixIcon: Icons.auto_awesome_rounded,
            autofocus: true,
          ),
          const SizedBox(height: AppSpacing.space16),
          AppButton(
            text: 'Generate Proposal & Workflow',
            icon: Icons.bolt_rounded,
            onPressed: () {
              Navigator.of(context).pop();
              AppSnackBar.showSuccess(
                context,
                message: 'AI Copilot processing request...',
              );
            },
          ),
        ],
      ),
    );
  }
}
