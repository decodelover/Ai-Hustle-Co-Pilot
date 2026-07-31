/// Reusable Subtitle typography component for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Reusable Subtitle Text widget formatted in secondary content color.
class AppSubtitleText extends StatelessWidget {
  const AppSubtitleText(
    this.text, {
    super.key,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  final String text;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final defaultColor = theme.colorScheme.onSurfaceVariant;

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: AppTypography.titleSmall.copyWith(color: color ?? defaultColor),
    );
  }
}
