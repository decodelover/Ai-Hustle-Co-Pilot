/// Reusable Heading typography component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Semantic heading levels (H1, H2, H3, H4).
enum AppHeadingLevel { h1, h2, h3, h4 }

/// Reusable Heading widget with automatic styling based on heading level.
class AppHeading extends StatelessWidget {
  const AppHeading(
    this.text, {
    super.key,
    this.level = AppHeadingLevel.h2,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final AppHeadingLevel level;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.onSurface;

    final baseStyle = switch (level) {
      AppHeadingLevel.h1 => AppTypography.headlineLarge,
      AppHeadingLevel.h2 => AppTypography.headlineMedium,
      AppHeadingLevel.h3 => AppTypography.headlineSmall,
      AppHeadingLevel.h4 => AppTypography.titleLarge,
    };

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: baseStyle.copyWith(color: color ?? defaultColor),
    );
  }
}
