/// Reusable Responsive Container component for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_breakpoints.dart';
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';
import 'package:flutter/material.dart';

/// Layout container that constrains content to a maximum responsive width on large screens.
class AppResponsiveContainer extends StatelessWidget {
  const AppResponsiveContainer({
    required this.child,
    super.key,
    this.maxWidth = AppBreakpoints.contentMaxWidth,
    this.padding = AppSpacing.paddingHorizontalLg,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
