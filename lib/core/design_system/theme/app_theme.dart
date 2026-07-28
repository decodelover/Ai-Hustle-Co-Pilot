/// Single source of truth barrel delegating to core theme AppTheme.
library;

import 'package:ai_hustle_copilot/core/theme/app_dark_theme.dart';
import 'package:ai_hustle_copilot/core/theme/app_light_theme.dart';
import 'package:flutter/material.dart';

export 'package:ai_hustle_copilot/core/theme/app_theme.dart';

/// Legacy theme accessor delegating to the new Enterprise Material 3 theme.
abstract class AppTheme {
  /// Light theme delegate.
  static ThemeData get lightTheme => getAppLightTheme();

  /// Dark theme delegate.
  static ThemeData get darkTheme => getAppDarkTheme();

  /// Legacy alias for [lightTheme].
  static ThemeData get light => lightTheme;

  /// Legacy alias for [darkTheme].
  static ThemeData get dark => darkTheme;
}
