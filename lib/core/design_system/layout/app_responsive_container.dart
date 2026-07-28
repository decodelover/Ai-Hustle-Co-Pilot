/// Responsive layout container enforcing AppBreakpoints content width constraints.
library;

import 'package:ai_hustle_copilot/core/theme/app_breakpoints.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Enterprise Material 3 Responsive Container component.
class ResponsivePageContainer extends StatelessWidget {
  /// Creates a [ResponsivePageContainer].
  const ResponsivePageContainer({
    required this.child,
    super.key,
    this.maxWidth = AppBreakpoints.contentMaxWidth,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.space16,
      vertical: AppSpacing.space16,
    ),
    this.alignment = Alignment.topCenter,
  });

  /// Child widget layout subtree.
  final Widget child;

  /// Maximum layout width constraint (defaults to 1200dp expanded breakpoint).
  final double maxWidth;

  /// Viewport padding.
  final EdgeInsetsGeometry padding;

  /// Alignment within available screen width.
  final AlignmentGeometry alignment;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}
