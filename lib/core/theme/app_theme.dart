/// Centralized Theme Factory and Barrel Export for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/theme/app_dark_theme.dart';
import 'package:ai_hustle_copilot/core/theme/app_light_theme.dart';
import 'package:flutter/material.dart';

export 'app_breakpoints.dart';
export 'app_colors.dart';
export 'app_dark_theme.dart';
export 'app_elevation.dart';
export 'app_light_theme.dart';
export 'app_motion.dart';
export 'app_radius.dart';
export 'app_shadows.dart';
export 'app_spacing.dart';
export 'app_typography.dart';
export 'theme_extensions.dart';

/// Provides theme configuration accessors for Light and Dark modes.
abstract class AppTheme {
  /// Enterprise Material 3 Light Theme instance.
  static ThemeData get lightTheme => getAppLightTheme();

  /// Enterprise Material 3 Dark Theme instance.
  static ThemeData get darkTheme => getAppDarkTheme();

  /// Legacy alias for [lightTheme].
  static ThemeData get light => lightTheme;

  /// Legacy alias for [darkTheme].
  static ThemeData get dark => darkTheme;
}
