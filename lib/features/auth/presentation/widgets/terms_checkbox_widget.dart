/// Enterprise TermsCheckboxWidget matching reference design.
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
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Row(
      children: [
        SizedBox(
          width: 24.0,
          height: 24.0,
          child: Checkbox(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
            checkColor: AppColors.onPrimary,
            side: const BorderSide(color: AppColors.outlineVariant, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
        const SizedBox(width: AppSpacing.space8),
        Expanded(
          child: GestureDetector(
            onTap: () => onChanged(!value),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
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
                      color: AppColors.primary,
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
                          'AI Hustle Co-Pilot protects and processes account data according to its privacy policy.',
                      primaryActionText: 'Close',
                    );
                  },
                  child: Text(
                    'Privacy Policy',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.primary,
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
