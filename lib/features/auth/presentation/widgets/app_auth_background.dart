/// Backwards-compatible auth background entry point.
library;

import 'package:ai_hustle_copilot/shared/widgets/app_brand_background.dart';
import 'package:flutter/material.dart';

/// Delegates legacy auth callers to the shared product background.
class AppAuthBackground extends StatelessWidget {
  /// Creates an auth background.
  const AppAuthBackground({required this.child, super.key});

  /// Auth content.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AppBrandBackground(
      child: child,
    );
  }
}
