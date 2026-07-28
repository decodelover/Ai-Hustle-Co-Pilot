/// Responsive breakpoint thresholds and layout helper utilities.
library;

import 'package:flutter/material.dart';

/// Centralized responsive layout breakpoint thresholds.
abstract class AppBreakpoints {
  /// Compact breakpoint threshold (600dp) for mobile phones.
  static const double compact = 600.0;

  /// Medium breakpoint threshold (840dp) for tablets and foldables.
  static const double medium = 840.0;

  /// Expanded breakpoint threshold (1200dp) for desktop views.
  static const double expanded = 1200.0;

  /// Large desktop breakpoint threshold (1440dp).
  static const double desktop = 1440.0;

  /// UltraWide monitor breakpoint threshold (1920dp).
  static const double ultraWide = 1920.0;

  /// Standard max content width for responsive container constraint (1200dp).
  static const double contentMaxWidth = expanded;

  // ── Width Evaluation Helpers ───────────────────────────────────────────
  /// Returns `true` if screen [width] is compact (<600dp).
  static bool isCompactWidth(double width) => width < compact;

  /// Returns `true` if screen [width] is medium (600dp - 839dp).
  static bool isMediumWidth(double width) => width >= compact && width < medium;

  /// Returns `true` if screen [width] is expanded (840dp - 1199dp).
  static bool isExpandedWidth(double width) =>
      width >= medium && width < expanded;

  /// Returns `true` if screen [width] is desktop (>=1200dp).
  static bool isDesktopWidth(double width) => width >= expanded;

  /// Returns `true` if screen [width] is ultrawide (>=1920dp).
  static bool isUltraWideWidth(double width) => width >= ultraWide;

  // ── BuildContext Helpers ───────────────────────────────────────────────
  /// Returns `true` if current context is compact (<600dp).
  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < compact;

  /// Returns `true` if current context is medium (600dp - 839dp).
  static bool isMedium(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= compact && w < medium;
  }

  /// Returns `true` if current context is expanded (840dp - 1199dp).
  static bool isExpanded(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    return w >= medium && w < expanded;
  }

  /// Returns `true` if current context is desktop (>=1200dp).
  static bool isDesktop(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= expanded;
}
