/// Reusable enterprise AppChip supporting filter, input, action, and choice types.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Preset modes for [AppChip].
enum AppChipType {
  /// Filter chip with checkmark when selected.
  filter,

  /// Input chip with deletion trailing icon.
  input,

  /// Action chip triggering an operation.
  action,

  /// Choice chip representing single selection.
  choice,
}

/// Enterprise Material 3 Chip component.
class AppChip extends StatefulWidget {
  /// Creates an [AppChip].
  const AppChip({
    required this.label,
    super.key,
    this.type = AppChipType.filter,
    this.isSelected = false,
    this.isDisabled = false,
    this.onTap,
    this.onDeleted,
    this.icon,
    this.avatar,
  });

  /// Label string.
  final String label;

  /// Chip type mode.
  final AppChipType type;

  /// Selected state boolean.
  final bool isSelected;

  /// Disabled state boolean.
  final bool isDisabled;

  /// Tap callback.
  final VoidCallback? onTap;

  /// Deletion callback (used for [AppChipType.input]).
  final VoidCallback? onDeleted;

  /// Optional leading icon.
  final IconData? icon;

  /// Optional leading avatar widget.
  final Widget? avatar;

  @override
  State<AppChip> createState() => _AppChipState();
}

class _AppChipState extends State<AppChip> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final (Color bg, Color fg, BorderSide border) = _resolveColors(isDark);

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.isSelected && widget.type == AppChipType.filter) ...[
          Icon(Icons.check_rounded, size: 16.0, color: fg),
          const SizedBox(width: AppSpacing.space4),
        ] else if (widget.avatar != null) ...[
          widget.avatar!,
          const SizedBox(width: 6.0),
        ] else if (widget.icon != null) ...[
          Icon(widget.icon, size: 16.0, color: fg),
          const SizedBox(width: 6.0),
        ],
        Text(
          widget.label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: fg,
            fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
        if (widget.onDeleted != null) ...[
          const SizedBox(width: AppSpacing.space4),
          GestureDetector(
            onTap: widget.isDisabled ? null : widget.onDeleted,
            child: Icon(Icons.close_rounded, size: 14.0, color: fg),
          ),
        ],
      ],
    );

    return AnimatedScale(
      scale: _isPressed ? AppMotion.pressScale : 1.0,
      duration: AppMotion.fast,
      curve: AppMotion.decelerateCurve,
      child: Material(
        color: bg,
        shape: RoundedRectangleBorder(
          borderRadius: AppRadius.borderPill,
          side: border,
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: widget.isDisabled ? null : widget.onTap,
          onHighlightChanged: (pressed) {
            if (!widget.isDisabled) {
              setState(() => _isPressed = pressed);
            }
          },
          borderRadius: AppRadius.borderPill,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.space12,
              vertical: AppSpacing.space8,
            ),
            child: content,
          ),
        ),
      ),
    );
  }

  (Color bg, Color fg, BorderSide border) _resolveColors(bool isDark) {
    if (widget.isDisabled) {
      final bg = isDark ? AppColors.darkDisabledSurface : AppColors.disabledSurface;
      final fg = isDark ? AppColors.darkDisabledText : AppColors.disabledText;
      return (bg, fg, BorderSide.none);
    }

    if (widget.isSelected) {
      final bg = isDark ? AppColors.darkPrimary : AppColors.primary;
      const fg = AppColors.onPrimary;
      return (bg, fg, BorderSide.none);
    }

    final bg = isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant;
    final fg = isDark ? AppColors.darkOnSurface : AppColors.onSurface;
    final border = BorderSide(
      color: isDark ? AppColors.darkOutline : AppColors.outline,
    );

    return (bg, fg, border);
  }
}
