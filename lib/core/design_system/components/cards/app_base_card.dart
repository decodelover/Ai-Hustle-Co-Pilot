/// Reusable Base Card component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_animation.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_elevation.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:flutter/material.dart';

/// Reusable surface container card enforcing M3 & UI/UX Pro Max design tokens.
class AppBaseCard extends StatefulWidget {
  const AppBaseCard({
    required this.child,
    super.key,
    this.padding = AppSpacing.paddingAllLg,
    this.margin,
    this.onTap,
    this.elevation = AppElevation.level0,
    this.backgroundColor,
    this.borderColor,
    this.borderRadius,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final double elevation;
  final Color? backgroundColor;
  final Color? borderColor;
  final BorderRadius? borderRadius;

  @override
  State<AppBaseCard> createState() => _AppBaseCardState();
}

class _AppBaseCardState extends State<AppBaseCard> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.onTap != null) {
      setState(() => _isPressed = true);
    }
  }

  void _onTapUp(TapUpDetails details) {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  void _onTapCancel() {
    if (_isPressed) {
      setState(() => _isPressed = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveBg = widget.backgroundColor ?? theme.cardTheme.color;
    final effectiveRadius = widget.borderRadius ?? AppRadius.borderRadiusMd;
    final effectiveBorder =
        widget.borderColor ?? theme.colorScheme.outlineVariant;

    final cardContent = AnimatedContainer(
      duration: AppAnimation.fast,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: effectiveRadius,
        border: Border.all(color: effectiveBorder),
        boxShadow: widget.elevation > 0 ? AppElevation.shadowSm : null,
      ),
      child: widget.child,
    );

    var result = widget.margin != null
        ? Padding(padding: widget.margin!, child: cardContent)
        : cardContent;

    if (widget.onTap != null) {
      result = GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _isPressed ? AppAnimation.pressScale : 1.0,
          duration: AppAnimation.micro,
          curve: AppAnimation.standard,
          child: Material(
            color: Colors.transparent,
            borderRadius: effectiveRadius,
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: effectiveRadius,
              child: result,
            ),
          ),
        ),
      );
    }

    return result;
  }
}
