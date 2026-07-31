/// Production-ready enterprise AppButton supporting 7 visual variants,
/// loading states, leading/trailing icons, press animations, and WCAG AA touch targets.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Available visual variants for [AppButton].
enum AppButtonVariant {
  /// Primary filled violet button.
  primary,

  /// Secondary indigo/soft button.
  secondary,

  /// Outlined border stroke button.
  outlined,

  /// Ghost transparent background button.
  ghost,

  /// Destructive red danger button.
  destructive,

  /// Emerald success button.
  success,

  /// Explicit loading state button.
  loading,
}

/// Enterprise Material 3 Button component.
class AppButton extends StatefulWidget {
  /// Creates an [AppButton].
  const AppButton({
    required this.text,
    super.key,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.icon,
    this.iconWidget,
    this.trailingIcon,
    this.isLoading = false,
    this.isDisabled = false,
    this.fullWidth = true,
    this.height = AppSpacing.space48,
  });

  /// Button text label.
  final String text;

  /// Trigger callback on press.
  final VoidCallback? onPressed;

  /// Visual variant style.
  final AppButtonVariant variant;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional custom leading icon widget.
  final Widget? iconWidget;

  /// Optional trailing icon.
  final IconData? trailingIcon;

  /// Shows an embedded circular progress indicator when true.
  final bool isLoading;

  /// Disables button interactions when true.
  final bool isDisabled;

  /// Expands button horizontally to fill available width when true.
  final bool fullWidth;

  /// Height constraint (defaults to 48dp minimum touch target).
  final double height;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  bool get _effectiveDisabled =>
      widget.isDisabled || widget.onPressed == null || widget.isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final (Color bg, Color fg, BorderSide border) = _resolveColors(
      theme,
      isDark,
    );

    final content = Row(
      mainAxisSize: widget.fullWidth ? MainAxisSize.max : MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (widget.isLoading) ...[
          SizedBox(
            width: 18.0,
            height: 18.0,
            child: CircularProgressIndicator(
              strokeWidth: 2.0,
              valueColor: AlwaysStoppedAnimation<Color>(fg),
            ),
          ),
          const SizedBox(width: AppSpacing.space8),
        ] else if (widget.iconWidget != null) ...[
          widget.iconWidget!,
          const SizedBox(width: AppSpacing.space8),
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: 18.0, color: fg),
          const SizedBox(width: AppSpacing.space8),
        ],
        Text(
          widget.text,
          style: theme.textTheme.labelLarge?.copyWith(
            color: fg,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (!widget.isLoading && widget.trailingIcon != null) ...[
          const SizedBox(width: AppSpacing.space8),
          Icon(widget.trailingIcon, size: 18.0, color: fg),
        ],
      ],
    );

    return Semantics(
      button: true,
      enabled: !_effectiveDisabled,
      label: widget.text,
      child: AnimatedScale(
        scale: _isPressed ? AppMotion.pressScale : 1.0,
        duration: AppMotion.fast,
        curve: AppMotion.decelerateCurve,
        child: SizedBox(
          height: widget.height,
          width: widget.fullWidth ? double.infinity : null,
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
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.space16,
                ),
                child: Center(child: content),
              ),
            ),
          ),
        ),
      ),
    );
  }

  (Color bg, Color fg, BorderSide border) _resolveColors(
    ThemeData theme,
    bool isDark,
  ) {
    if (_effectiveDisabled) {
      final disabledBg = isDark
          ? AppColors.darkDisabledSurface
          : AppColors.disabledSurface;
      final disabledFg = isDark
          ? AppColors.darkDisabledText
          : AppColors.disabledText;
      return (disabledBg, disabledFg, BorderSide.none);
    }

    final variant = widget.isLoading
        ? AppButtonVariant.loading
        : widget.variant;

    switch (variant) {
      case AppButtonVariant.primary:
      case AppButtonVariant.loading:
        return (
          isDark ? AppColors.darkPrimary : AppColors.primary,
          AppColors.onPrimary,
          BorderSide.none,
        );
      case AppButtonVariant.secondary:
        return (
          isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
          isDark ? AppColors.darkOnSurface : AppColors.onSurface,
          BorderSide.none,
        );
      case AppButtonVariant.outlined:
        return (
          Colors.transparent,
          isDark ? AppColors.darkOnSurface : AppColors.onSurface,
          BorderSide(color: isDark ? AppColors.darkOutline : AppColors.outline),
        );
      case AppButtonVariant.ghost:
        return (
          Colors.transparent,
          isDark ? AppColors.darkPrimary : AppColors.primary,
          BorderSide.none,
        );
      case AppButtonVariant.destructive:
        return (
          isDark ? AppColors.darkDanger : AppColors.danger,
          AppColors.onDanger,
          BorderSide.none,
        );
      case AppButtonVariant.success:
        return (
          isDark ? AppColors.darkSuccess : AppColors.success,
          AppColors.onSuccess,
          BorderSide.none,
        );
    }
  }
}
