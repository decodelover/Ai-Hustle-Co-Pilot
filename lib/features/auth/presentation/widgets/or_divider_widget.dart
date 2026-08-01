/// Quiet divider used between credentials and provider actions.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Reusable section separator widget with centered label text.
class OrDividerWidget extends StatelessWidget {
  /// Creates an [OrDividerWidget].
  const OrDividerWidget({super.key, this.label = 'Or Continue With'});

  /// Custom divider text label.
  final String label;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).brightness == Brightness.dark
        ? AppColors.darkOnSurfaceVariant
        : AppColors.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.space20),
      child: Row(
        children: [
          Expanded(child: Divider(color: color.withValues(alpha: 0.5))),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.space12),
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Expanded(child: Divider(color: color.withValues(alpha: 0.5))),
        ],
      ),
    );
  }
}
