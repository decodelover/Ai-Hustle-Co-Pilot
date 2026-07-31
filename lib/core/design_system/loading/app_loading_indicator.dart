/// Reusable AppLoadingIndicator providing themed Circular and Linear progress indicators.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

/// Preset variants for [AppLoadingIndicator].
enum AppLoadingVariant {
  /// Circular spinner.
  circular,

  /// Linear progress bar.
  linear,
}

/// Enterprise Material 3 Progress Indicator component.
class AppLoadingIndicator extends StatelessWidget {
  /// Creates a circular [AppLoadingIndicator].
  const AppLoadingIndicator({
    super.key,
    this.value,
    this.size = 36.0,
    this.strokeWidth = 3.0,
    this.color,
  }) : variant = AppLoadingVariant.circular,
       height = null;

  /// Creates a linear [AppLoadingIndicator].
  const AppLoadingIndicator.linear({
    super.key,
    this.value,
    this.height = 4.0,
    this.color,
  }) : variant = AppLoadingVariant.linear,
       size = 36.0,
       strokeWidth = 3.0;

  /// Progress value (0.0 to 1.0) or null for indeterminate.
  final double? value;

  /// Visual variant.
  final AppLoadingVariant variant;

  /// Outer dimension for circular spinner.
  final double size;

  /// Stroke width for circular spinner.
  final double strokeWidth;

  /// Height for linear progress bar.
  final double? height;

  /// Custom color override.
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDarkMode;
    final activeColor =
        color ?? (isDark ? AppColors.darkPrimary : AppColors.primary);

    if (variant == AppLoadingVariant.linear) {
      return SizedBox(
        height: height ?? 4.0,
        child: LinearProgressIndicator(
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(activeColor),
          backgroundColor: activeColor.withValues(alpha: 0.15),
        ),
      );
    }

    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(activeColor),
        backgroundColor: activeColor.withValues(alpha: 0.15),
      ),
    );
  }
}
