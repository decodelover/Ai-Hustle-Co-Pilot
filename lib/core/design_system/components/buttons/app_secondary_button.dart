/// Reusable Secondary Button component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Reusable secondary container button with 48dp touch target.
class AppSecondaryButton extends StatelessWidget {
  const AppSecondaryButton({
    required this.label,
    super.key,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = AppSpacing.minTouchTarget,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double height;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bg = theme.colorScheme.secondaryContainer;
    final fg = theme.colorScheme.onSecondaryContainer;

    Widget childWidget;

    if (isLoading) {
      childWidget = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(fg),
        ),
      );
    } else if (icon != null) {
      childWidget = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 20, color: fg),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelLarge.copyWith(
              color: fg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      childWidget = Text(
        label,
        style: AppTypography.labelLarge.copyWith(
          color: fg,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    return Semantics(
      button: true,
      enabled: onPressed != null && !isLoading,
      label: label,
      child: SizedBox(
        height: height,
        width: isFullWidth ? double.infinity : null,
        child: FilledButton.tonal(
          onPressed: isLoading ? null : onPressed,
          style: FilledButton.styleFrom(
            backgroundColor: bg,
            foregroundColor: fg,
            disabledBackgroundColor: bg.withValues(alpha: 0.5),
            minimumSize: Size(isFullWidth ? double.infinity : 0, height),
            shape: AppRadius.shapeMd,
          ),
          child: childWidget,
        ),
      ),
    );
  }
}
