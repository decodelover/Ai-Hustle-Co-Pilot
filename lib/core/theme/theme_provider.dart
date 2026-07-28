/// Riverpod ThemeMode provider for AI Hustle Co-Pilot.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod notifier managing active application [ThemeMode].
class ThemeModeNotifier extends Notifier<ThemeMode> {
  @override
  ThemeMode build() {
    return ThemeMode.system;
  }

  /// Sets the active theme mode to [ThemeMode.light].
  void setLightMode() {
    state = ThemeMode.light;
  }

  /// Sets the active theme mode to [ThemeMode.dark].
  void setDarkMode() {
    state = ThemeMode.dark;
  }

  /// Resets the active theme mode to [ThemeMode.system].
  void setSystemMode() {
    state = ThemeMode.system;
  }

  /// Toggles between light and dark modes.
  void toggleTheme() {
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
  }
}

/// Provider exposing active [ThemeMode] and toggle actions.
final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(
  ThemeModeNotifier.new,
);
