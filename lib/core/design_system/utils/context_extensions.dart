/// Context extension shortcuts for accessing Theme, ColorScheme, Typography,
/// Spatial tokens, Extensions, and Breakpoints cleanly across Flutter widgets.
library;

import 'package:ai_hustle_copilot/core/theme/app_breakpoints.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

/// Convenient BuildContext extension methods for design tokens and theme objects.
extension ContextDesignSystemX on BuildContext {
  // ── Core Theme Shortcuts ───────────────────────────────────────────────
  /// Returns the current [ThemeData].
  ThemeData get theme => Theme.of(this);

  /// Returns the current [ColorScheme].
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Returns the current [TextTheme].
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns `true` if current theme brightness is dark mode.
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // ── ThemeExtension Shortcuts ────────────────────────────────────────────
  /// Returns the active [AiColorsExtension].
  AiColorsExtension get aiColors =>
      Theme.of(this).extension<AiColorsExtension>() ??
      const AiColorsExtension(
        accent: Color(0xFFEC4899),
        onAccent: Color(0xFFFFFFFF),
        glowColor: Color(0x406D28D9),
        sparkGradient: LinearGradient(
          colors: [Color(0xFF6D28D9), Color(0xFFEC4899)],
        ),
      );

  /// Returns the active [ChartColorsExtension].
  ChartColorsExtension get chartColors =>
      Theme.of(this).extension<ChartColorsExtension>() ??
      const ChartColorsExtension(
        chart1: Color(0xFF6D28D9),
        chart2: Color(0xFF059669),
        chart3: Color(0xFF2563EB),
        chart4: Color(0xFFD97706),
        chart5: Color(0xFFEC4899),
      );

  /// Returns the active [StatusColorsExtension].
  StatusColorsExtension get statusColors =>
      Theme.of(this).extension<StatusColorsExtension>() ??
      const StatusColorsExtension(
        success: Color(0xFF059669),
        onSuccess: Color(0xFFFFFFFF),
        warning: Color(0xFFD97706),
        onWarning: Color(0xFFFFFFFF),
        danger: Color(0xFFDC2626),
        onDanger: Color(0xFFFFFFFF),
        info: Color(0xFF2563EB),
        onInfo: Color(0xFFFFFFFF),
      );

  /// Returns the active [ShadowsExtension].
  ShadowsExtension? get shadows => Theme.of(this).extension<ShadowsExtension>();

  // ── Media & Breakpoint Shortcuts ───────────────────────────────────────
  /// Current viewport width.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Current viewport height.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Compact screen check (<600dp).
  bool get isCompact => AppBreakpoints.isCompact(this);

  /// Medium screen check (600dp - 839dp).
  bool get isMedium => AppBreakpoints.isMedium(this);

  /// Expanded screen check (840dp - 1199dp).
  bool get isExpanded => AppBreakpoints.isExpanded(this);

  /// Desktop screen check (>=1200dp).
  bool get isDesktop => AppBreakpoints.isDesktop(this);

  // ── Spatial Token Shortcuts ─────────────────────────────────────────────
  /// 4dp space shortcut.
  double get space4 => AppSpacing.space4;

  /// 8dp space shortcut.
  double get space8 => AppSpacing.space8;

  /// 12dp space shortcut.
  double get space12 => AppSpacing.space12;

  /// 16dp space shortcut.
  double get space16 => AppSpacing.space16;

  /// 20dp space shortcut.
  double get space20 => AppSpacing.space20;

  /// 24dp space shortcut.
  double get space24 => AppSpacing.space24;

  /// 32dp space shortcut.
  double get space32 => AppSpacing.space32;

  /// 48dp min touch target shortcut.
  double get minTouchTarget => AppSpacing.minTouchTarget;
}
