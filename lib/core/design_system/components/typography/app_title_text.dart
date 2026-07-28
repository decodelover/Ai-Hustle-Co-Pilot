/// Reusable Title typography component for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

enum AppTitleSize { large, medium, small }

/// Reusable Title Text widget.
class AppTitleText extends StatelessWidget {
  const AppTitleText(
    this.text, {
    super.key,
    this.size = AppTitleSize.medium,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final AppTitleSize size;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.onSurface;

    final baseStyle = switch (size) {
      AppTitleSize.large => AppTypography.titleLarge,
      AppTitleSize.medium => AppTypography.titleMedium,
      AppTitleSize.small => AppTypography.titleSmall,
    };

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle.copyWith(
        color: color ?? defaultColor,
        fontWeight: fontWeight,
      ),
    );
  }
}
