/// Reusable loading indicator widget wrapping design system AppLoadingWidget.
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_loading_widget.dart';
import 'package:flutter/material.dart';

/// Centered loading indicator wrapping design system feedback component.
class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    super.key,
    this.message,
  });

  final String? message;

  @override
  Widget build(BuildContext context) {
    return AppLoadingWidget(message: message);
  }
}
