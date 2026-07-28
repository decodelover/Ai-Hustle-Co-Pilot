/// Enterprise TermsCheckboxWidget for accepting Terms of Service and Privacy Policy.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';

/// Reusable terms and conditions agreement checkbox widget.
class TermsCheckboxWidget extends StatelessWidget {
  /// Creates a [TermsCheckboxWidget].
  const TermsCheckboxWidget({
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 36.0,
          height: 36.0,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: isDark ? AppColors.darkPrimary : AppColors.primary,
            shape: const RoundedRectangleBorder(
              borderRadius: AppRadius.borderSmall,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.space8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 6.0),
            child: Wrap(
              children: [
                Text(
                  'I agree to the ',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.darkOnSurfaceVariant
                        : AppColors.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppDialog.show<void>(
                      context: context,
                      title: 'Terms of Service',
                      description:
                          'By using AI Hustle Co-Pilot, you agree to comply with our terms and enterprise user policies.',
                      primaryActionText: 'Close',
                    );
                  },
                  child: Text(
                    'Terms of Service',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? AppColors.darkPrimary : AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  ' and ',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark
                        ? AppColors.darkOnSurfaceVariant
                        : AppColors.onSurfaceVariant,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    AppDialog.show<void>(
                      context: context,
                      title: 'Privacy Policy',
                      description:
                          'We respect your privacy and process all domain data with encrypted enterprise standards.',
                      primaryActionText: 'Close',
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isDark ? AppColors.darkPrimary : AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
