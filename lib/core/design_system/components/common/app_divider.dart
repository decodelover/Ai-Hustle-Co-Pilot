/// Enterprise AppDivider supporting horizontal and vertical dividers.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Divider component.
class AppDivider extends StatelessWidget {
  /// Creates a horizontal [AppDivider].
  const AppDivider({
    super.key,
    this.height = AppSpacing.space16,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  }) : isVertical = false;

  /// Creates a vertical [AppDivider].
  const AppDivider.vertical({
    super.key,
    this.height = AppSpacing.space16,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.color,
  }) : isVertical = true;

  /// Orientation indicator.
  final bool isVertical;

  /// Height for horizontal divider or width for vertical divider.
  final double height;

  /// Stroke thickness.
  final double thickness;

  /// Start indent inset.
  final double indent;

  /// End indent inset.
  final double endIndent;

  /// Custom divider color override.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final dividerColor =
        color ?? (isDark ? AppColors.darkOutline : AppColors.outline);

    if (isVertical) {
      return VerticalDivider(
        width: height,
        thickness: thickness,
        indent: indent,
        endIndent: endIndent,
        color: dividerColor,
      );
    }

    return Divider(
      height: height,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      color: dividerColor,
    );
  }
}
