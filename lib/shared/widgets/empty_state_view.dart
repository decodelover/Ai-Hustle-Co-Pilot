/// Reusable empty state view widget wrapping design system AppEmptyState.
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_empty_state.dart';
import 'package:flutter/material.dart';

/// Centered empty state view wrapping design system feedback component.
class EmptyStateView extends StatelessWidget {
  const EmptyStateView({
    required this.icon,
    required this.title,
    super.key,
    this.subtitle,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      title: title,
      message: subtitle ?? '',
      icon: icon,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
