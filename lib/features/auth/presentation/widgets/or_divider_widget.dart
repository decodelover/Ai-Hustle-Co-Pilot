/// Enterprise OrDividerWidget displaying horizontal lines with centered "OR" badge label.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Reusable section separator widget with centered "OR" label text.
class OrDividerWidget extends StatelessWidget {
  /// Creates an [OrDividerWidget].
  const OrDividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space24),
      child: Row(
        children: [
          const Expanded(child: AppDivider()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space12),
            child: Text(
              'OR',
              style: theme.textTheme.labelSmall?.copyWith(
                color: isDark
                    ? AppColors.darkOnSurfaceVariant
                    : AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          const Expanded(child: AppDivider()),
        ],
      ),
    );
  }
}
