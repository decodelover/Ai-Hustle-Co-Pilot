/// Center Floating AI Action Button for AI Copilot assistant.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/shell/application/services/ai_launcher_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Floating AI Action Button featuring animated gradient glow and spring scaling.
class AiFloatingButton extends ConsumerWidget {
  /// Creates an [AiFloatingButton].
  const AiFloatingButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDarkMode;

    return Semantics(
      label: 'Open AI Copilot Assistant',
      button: true,
      child: ScaleIn(
        child: Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                isDark ? AppColors.darkPrimary : AppColors.primary,
                isDark ? AppColors.darkSecondary : AppColors.secondary,
              ],
            ),
            boxShadow: isDark ? AppShadows.darkAiGlow : AppShadows.lightAiGlow,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: () {
                ref.read(aiLauncherServiceProvider).launchCopilot(context);
              },
              child: const Center(
                child: Icon(
                  Icons.auto_awesome_rounded,
                  color: AppColors.onPrimary,
                  size: 28.0,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
