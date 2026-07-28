/// Reusable Body typography component for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

enum AppBodySize { large, medium, small }

/// Reusable Body Text widget for paragraph content.
class AppBodyText extends StatelessWidget {
  const AppBodyText(
    this.text, {
    super.key,
    this.size = AppBodySize.medium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
  });

  final String text;
  final AppBodySize size;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.onSurface;

    final baseStyle = switch (size) {
      AppBodySize.large => AppTypography.bodyLarge,
      AppBodySize.medium => AppTypography.bodyMedium,
      AppBodySize.small => AppTypography.bodySmall,
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
