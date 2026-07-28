/// Reusable Loading Button component for AI Hustle Co-Pilot design system.
library;

import 'package:ai_hustle_copilot/core/design_system/components/buttons/app_primary_button.dart';
import 'package:flutter/material.dart';

/// Dedicated Loading Button component showcasing an inline spinner state.
class AppLoadingButton extends StatelessWidget {
  const AppLoadingButton({
    required this.label,
    super.key,
    this.onPressed,
    this.isLoading = true,
    this.isFullWidth = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    return AppPrimaryButton(
      label: label,
      onPressed: onPressed,
      isLoading: isLoading,
      isFullWidth: isFullWidth,
    );
  }
}
