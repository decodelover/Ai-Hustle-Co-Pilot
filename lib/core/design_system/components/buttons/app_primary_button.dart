/// Reusable Primary CTA Button component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_animation.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';
import 'package:flutter/material.dart';

/// Reusable primary CTA button with tactile scale feedback, optional icon, and loading state.
class AppPrimaryButton extends StatefulWidget {
  const AppPrimaryButton({
    required this.label,
    super.key,
    this.onPressed,
    this.icon,
    this.isLoading = false,
    this.isFullWidth = true,
    this.height = AppSpacing.minTouchTarget,
    this.backgroundColor,
    this.foregroundColor,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final bool isFullWidth;
  final double height;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  State<AppPrimaryButton> createState() => _AppPrimaryButtonState();
}

class _AppPrimaryButtonState extends State<AppPrimaryButton> {
  bool _isPressed = false;

  void _onTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
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
    final effectiveBg = widget.backgroundColor ?? theme.colorScheme.primary;
    final effectiveFg = widget.foregroundColor ?? theme.colorScheme.onPrimary;

    Widget childWidget;

    if (widget.isLoading) {
      childWidget = SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(effectiveFg),
        ),
      );
    } else if (widget.icon != null) {
      childWidget = Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(widget.icon, size: 20, color: effectiveFg),
          const SizedBox(width: AppSpacing.sm),
          Text(
            widget.label,
            style: AppTypography.labelLarge.copyWith(
              color: effectiveFg,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      );
    } else {
      childWidget = Text(
        widget.label,
        style: AppTypography.labelLarge.copyWith(
          color: effectiveFg,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: effectiveBg,
      foregroundColor: effectiveFg,
      disabledBackgroundColor: effectiveBg.withValues(alpha: 0.5),
      elevation: 0,
      minimumSize: Size(widget.isFullWidth ? double.infinity : 0, widget.height),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xxl,
        vertical: AppSpacing.md,
      ),
      shape: AppRadius.shapeMd,
    );

    final isInteractive = widget.onPressed != null && !widget.isLoading;

    return Semantics(
      button: true,
      enabled: isInteractive,
      label: widget.label,
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: AnimatedScale(
          scale: _isPressed ? AppAnimation.pressScale : 1.0,
          duration: AppAnimation.micro,
          curve: AppAnimation.standard,
          child: SizedBox(
            height: widget.height,
            width: widget.isFullWidth ? double.infinity : null,
            child: ElevatedButton(
              onPressed: widget.isLoading ? null : widget.onPressed,
              style: buttonStyle,
              child: childWidget,
            ),
          ),
        ),
      ),
    );
  }
}
