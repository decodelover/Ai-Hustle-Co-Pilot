/// Reusable enterprise AppIconButton component supporting filled, outlined,
/// and ghost variants with tooltips and minimum 48dp WCAG AA touch target box.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Available visual variants for [AppIconButton].
enum AppIconButtonVariant {
  /// Filled background icon button.
  filled,

  /// Outlined stroke icon button.
  outlined,

  /// Ghost transparent background icon button.
  ghost,
}

/// Enterprise Material 3 Icon Button component.
class AppIconButton extends StatefulWidget {
  /// Creates an [AppIconButton].
  const AppIconButton({
    required this.icon,
    super.key,
    this.onPressed,
    this.variant = AppIconButtonVariant.ghost,
    this.tooltip,
    this.isLoading = false,
    this.isDisabled = false,
    this.size = AppSpacing.space48,
    this.iconSize = 20.0,
  });

  /// Icon to display.
  final IconData icon;

  /// Trigger callback on press.
  final VoidCallback? onPressed;

  /// Visual variant.
  final AppIconButtonVariant variant;

  /// Optional accessibility tooltip.
  final String? tooltip;

  /// Shows loading spinner when true.
  final bool isLoading;

  /// Disables button when true.
  final bool isDisabled;

  /// Outer square dimension (defaults to 48dp).
  final double size;

  /// Inner icon dimension (defaults to 20dp).
  final double iconSize;

  @override
  State<AppIconButton> createState() => _AppIconButtonState();
}

class _AppIconButtonState extends State<AppIconButton> {
  bool _isPressed = false;

  bool get _effectiveDisabled =>
      widget.isDisabled || widget.onPressed == null || widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final (Color bg, Color fg, BorderSide border) = _resolveColors(theme, isDark);

    Widget buttonWidget = AnimatedScale(
      scale: _isPressed ? AppMotion.pressScale : 1.0,
      duration: AppMotion.fast,
      curve: AppMotion.decelerateCurve,
      child: SizedBox(
        width: widget.size,
        height: widget.size,
        child: Material(
          color: bg,
          shape: RoundedRectangleBorder(
            borderRadius: AppRadius.borderMedium,
            side: border,
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: _effectiveDisabled ? null : widget.onPressed,
            onHighlightChanged: (pressed) {
              if (!_effectiveDisabled) {
                setState(() => _isPressed = pressed);
              }
            },
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: widget.iconSize,
                      height: widget.iconSize,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        valueColor: AlwaysStoppedAnimation<Color>(fg),
                      ),
                    )
                  : Icon(
                      widget.icon,
                      size: widget.iconSize,
                      color: fg,
                    ),
            ),
          ),
        ),
      ),
    );

    final tooltip = widget.tooltip;
    if (tooltip != null && tooltip.isNotEmpty) {
      buttonWidget = Tooltip(
        message: tooltip,
        child: buttonWidget,
      );
    }

    return Semantics(
      button: true,
      enabled: !_effectiveDisabled,
      label: tooltip ?? 'Icon Button',
      child: buttonWidget,
    );
  }

  (Color bg, Color fg, BorderSide border) _resolveColors(
    ThemeData theme,
    bool isDark,
  ) {
    if (_effectiveDisabled) {
      final disabledBg =
          isDark ? AppColors.darkDisabledSurface : AppColors.disabledSurface;
      final disabledFg =
          isDark ? AppColors.darkDisabledText : AppColors.disabledText;
      return (disabledBg, disabledFg, BorderSide.none);
    }

    switch (widget.variant) {
      case AppIconButtonVariant.filled:
        return (
          isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
          isDark ? AppColors.darkOnSurface : AppColors.onSurface,
          BorderSide.none
        );
      case AppIconButtonVariant.outlined:
        return (
          Colors.transparent,
          isDark ? AppColors.darkOnSurface : AppColors.onSurface,
          BorderSide(
            color: isDark ? AppColors.darkOutline : AppColors.outline,
          )
        );
      case AppIconButtonVariant.ghost:
        return (
          Colors.transparent,
          isDark ? AppColors.darkOnSurface : AppColors.onSurface,
          BorderSide.none
        );
    }
  }
}
