/// Enterprise RememberMeWidget checkbox with WCAG AA touch target bounds.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Reusable Remember Me checkbox widget.
class RememberMeWidget extends StatelessWidget {
  /// Creates a [RememberMeWidget].
  const RememberMeWidget({
    required this.value,
    required this.onChanged,
    super.key,
  });

  /// Checkbox value state.
  final bool value;

  /// Value change callback.
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: AppSpacing.space48,
          height: AppSpacing.space48,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: isDark ? AppColors.darkPrimary : AppColors.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.borderSmall,
            ),
          ),
        ),
        GestureDetector(
          onTap: () => onChanged(!value),
          child: Text(
            'Remember me',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: isDark ? AppColors.darkOnSurface : AppColors.onSurface,
            ),
          ),
        ),
      ],
    );
  }
}
