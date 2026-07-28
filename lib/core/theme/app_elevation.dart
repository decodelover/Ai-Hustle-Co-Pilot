/// Material 3 elevation definitions for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/theme/app_shadows.dart';
import 'package:flutter/material.dart';

/// Centralized immutable elevation tokens.
abstract class AppElevation {
  /// Flat level 0 (0.0dp).
  static const double level0 = 0.0;

  /// Card / AppBar level 1 (1.0dp).
  static const double level1 = 1.0;

  /// Hovered card level 2 (3.0dp).
  static const double level2 = 3.0;

  /// FAB / Sticky bar level 3 (6.0dp).
  static const double level3 = 6.0;

  /// Dialog modal level 4 (12.0dp).
  static const double level4 = 12.0;

  /// Full-screen sheet level 5 (24.0dp).
  static const double level5 = 24.0;

  /// Legacy alias for small elevation shadow.
  static const List<BoxShadow> shadowSm = AppShadows.lightSm;
}
