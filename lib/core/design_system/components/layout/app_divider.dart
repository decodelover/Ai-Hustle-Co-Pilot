/// Reusable App Divider component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Styled divider supporting horizontal/vertical modes and optional centered text.
class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.label,
    this.color,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.vertical = false,
  });

  final String? label;
  final Color? color;
  final double thickness;
  final double indent;
  final double endIndent;
  final bool vertical;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dividerColor = color ?? theme.colorScheme.outlineVariant;

    if (vertical) {
      return VerticalDivider(
        color: dividerColor,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
      );
    }

    if (label != null) {
      return Row(
        children: [
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: thickness,
              indent: indent,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            child: Text(
              label!,
              style: AppTypography.labelSmall.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: dividerColor,
              thickness: thickness,
              endIndent: endIndent,
            ),
          ),
        ],
      );
    }

    return Divider(
      color: dividerColor,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
    );
  }
}
