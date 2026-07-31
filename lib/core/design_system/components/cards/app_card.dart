/// Production-ready enterprise AppCard supporting standard, elevated, filled,
/// and outlined variants with header, footer, leading, trailing, and press animations.
library;

import 'package:ai_hustle_copilot/core/design_system/utils/context_extensions.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_shadows.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Available visual variants for [AppCard].
enum AppCardVariant {
  /// Standard card with subtle border stroke and level 1 elevation.
  standard,

  /// Elevated card with prominent shadow.
  elevated,

  /// Filled background card with surface variant tint.
  filled,

  /// Outlined border stroke card without elevation shadow.
  outlined,
}

/// Enterprise Material 3 Card component.
class AppCard extends StatefulWidget {
  /// Creates an [AppCard].
  const AppCard({
    super.key,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.header,
    this.footer,
    this.child,
    this.onTap,
    this.variant = AppCardVariant.standard,
    this.padding = const EdgeInsets.all(AppSpacing.space16),
    this.margin = EdgeInsets.zero,
  });

  /// Optional card title header string.
  final String? title;

  /// Optional card subtitle description string.
  final String? subtitle;

  /// Optional leading icon or avatar widget.
  final Widget? leading;

  /// Optional trailing action widget.
  final Widget? trailing;

  /// Custom top header section widget.
  final Widget? header;

  /// Custom bottom footer section widget.
  final Widget? footer;

  /// Main body child widget.
  final Widget? child;

  /// Tap callback for interactive cards.
  final VoidCallback? onTap;

  /// Visual variant style.
  final AppCardVariant variant;

  /// Inner content padding.
  final EdgeInsetsGeometry padding;

  /// Outer container margin.
  final EdgeInsetsGeometry margin;

  @override
  State<AppCard> createState() => _AppCardState();
}

class _AppCardState extends State<AppCard> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final (Color bg, List<BoxShadow> shadows, BorderSide border) =
        _resolveStyling(isDark);

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.header != null) widget.header!,
        if (widget.title != null ||
            widget.leading != null ||
            widget.trailing != null) ...[
          Row(
            children: [
              if (widget.leading != null) ...[
                widget.leading!,
                const SizedBox(width: AppSpacing.space12),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (widget.title != null)
                      Text(
                        widget.title!,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.darkOnSurface
                              : AppColors.onSurface,
                        ),
                      ),
                    if (widget.subtitle != null) ...[
                      const SizedBox(height: AppSpacing.space4),
                      Text(
                        subtitleText,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.darkOnSurfaceVariant
                              : AppColors.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (widget.trailing != null) ...[
                const SizedBox(width: AppSpacing.space12),
                widget.trailing!,
              ],
            ],
          ),
          if (widget.child != null) const SizedBox(height: AppSpacing.space12),
        ],
        if (widget.child != null) widget.child!,
        if (widget.footer != null) ...[
          const SizedBox(height: AppSpacing.space12),
          widget.footer!,
        ],
      ],
    );

    Widget cardWidget = Container(
      margin: widget.margin,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: AppRadius.borderLarge,
        border: border != BorderSide.none
            ? Border.fromBorderSide(border)
            : null,
        boxShadow: shadows,
      ),
      clipBehavior: Clip.antiAlias,
      child: widget.onTap != null
          ? InkWell(
              onTap: widget.onTap,
              onHighlightChanged: (pressed) {
                setState(() => _isPressed = pressed);
              },
              borderRadius: AppRadius.borderLarge,
              child: Padding(padding: widget.padding, child: content),
            )
          : Padding(padding: widget.padding, child: content),
    );

    if (widget.onTap != null) {
      cardWidget = AnimatedScale(
        scale: _isPressed ? AppMotion.pressScale : 1.0,
        duration: AppMotion.fast,
        curve: AppMotion.decelerateCurve,
        child: cardWidget,
      );
    }

    return cardWidget;
  }

  String get subtitleText => widget.subtitle!;

  (Color bg, List<BoxShadow> shadows, BorderSide border) _resolveStyling(
    bool isDark,
  ) {
    switch (widget.variant) {
      case AppCardVariant.standard:
        return (
          isDark ? AppColors.darkSurface : AppColors.surface,
          isDark ? AppShadows.darkSm : AppShadows.lightSm,
          BorderSide(color: isDark ? AppColors.darkOutline : AppColors.outline),
        );
      case AppCardVariant.elevated:
        return (
          isDark ? AppColors.darkSurface : AppColors.surface,
          isDark ? AppShadows.darkLg : AppShadows.lightLg,
          BorderSide.none,
        );
      case AppCardVariant.filled:
        return (
          isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant,
          const [],
          BorderSide.none,
        );
      case AppCardVariant.outlined:
        return (
          Colors.transparent,
          const [],
          BorderSide(
            color: isDark ? AppColors.darkOutline : AppColors.outline,
            width: 1.5,
          ),
        );
    }
  }
}
