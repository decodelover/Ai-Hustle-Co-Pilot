/// Typography definitions for AI Hustle Co-Pilot.
///
/// Implements full Material 3 text scale using Inter for UI body/headings
/// and Fira Code / JetBrains Mono for code snippets and metrics.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralized immutable typography tokens.
abstract class AppTypography {
  /// Primary UI font family name (Inter).
  static String get fontFamily => GoogleFonts.inter().fontFamily ?? 'Inter';

  /// Monospace font family name (Fira Code).
  static String get monospaceFontFamily =>
      GoogleFonts.firaCode().fontFamily ?? 'FiraCode';

  /// Display Large (40sp, Bold).
  static TextStyle get displayLarge => GoogleFonts.inter(
        fontSize: 40.0,
        fontWeight: FontWeight.w700,
        height: 1.2,
        letterSpacing: -0.5,
      );

  /// Display Medium (32sp, SemiBold).
  static TextStyle get displayMedium => GoogleFonts.inter(
        fontSize: 32.0,
        fontWeight: FontWeight.w600,
        height: 1.25,
        letterSpacing: -0.25,
      );

  /// Display Small (28sp, SemiBold).
  static TextStyle get displaySmall => GoogleFonts.inter(
        fontSize: 28.0,
        fontWeight: FontWeight.w600,
        height: 1.286,
        letterSpacing: 0.0,
      );

  /// Headline Large (24sp, SemiBold).
  static TextStyle get headlineLarge => GoogleFonts.inter(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
        height: 1.333,
        letterSpacing: 0.0,
      );

  /// Headline Medium (20sp, Medium).
  static TextStyle get headlineMedium => GoogleFonts.inter(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.15,
      );

  /// Headline Small (18sp, Medium).
  static TextStyle get headlineSmall => GoogleFonts.inter(
        fontSize: 18.0,
        fontWeight: FontWeight.w500,
        height: 1.333,
        letterSpacing: 0.15,
      );

  /// Title Large (16sp, Medium).
  static TextStyle get titleLarge => GoogleFonts.inter(
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
        height: 1.375,
        letterSpacing: 0.1,
      );

  /// Title Medium (14sp, Medium).
  static TextStyle get titleMedium => GoogleFonts.inter(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.428,
        letterSpacing: 0.1,
      );

  /// Title Small (12sp, Medium).
  static TextStyle get titleSmall => GoogleFonts.inter(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        height: 1.333,
        letterSpacing: 0.1,
      );

  /// Body Large (16sp, Regular).
  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 1.5,
        letterSpacing: 0.5,
      );

  /// Body Medium (14sp, Regular).
  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 1.428,
        letterSpacing: 0.25,
      );

  /// Body Small (12sp, Regular).
  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        height: 1.333,
        letterSpacing: 0.4,
      );

  /// Label Large (14sp, Medium).
  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        height: 1.428,
        letterSpacing: 0.1,
      );

  /// Label Medium (12sp, Medium).
  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12.0,
        fontWeight: FontWeight.w500,
        height: 1.333,
        letterSpacing: 0.5,
      );

  /// Label Small (10sp, Medium).
  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 10.0,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.5,
      );

  /// Standard TextTheme accessor.
  static TextTheme get textTheme => lightTextTheme(const Color(0xFF0F172A));

  /// Light theme text theme containing all 15 Material 3 text styles.
  static TextTheme lightTextTheme(Color color) {
    return TextTheme(
      displayLarge: displayLarge.copyWith(color: color),
      displayMedium: displayMedium.copyWith(color: color),
      displaySmall: displaySmall.copyWith(color: color),
      headlineLarge: headlineLarge.copyWith(color: color),
      headlineMedium: headlineMedium.copyWith(color: color),
      headlineSmall: headlineSmall.copyWith(color: color),
      titleLarge: titleLarge.copyWith(color: color),
      titleMedium: titleMedium.copyWith(color: color),
      titleSmall: titleSmall.copyWith(color: color),
      bodyLarge: bodyLarge.copyWith(color: color),
      bodyMedium: bodyMedium.copyWith(color: color),
      bodySmall: bodySmall.copyWith(color: color),
      labelLarge: labelLarge.copyWith(color: color),
      labelMedium: labelMedium.copyWith(color: color),
      labelSmall: labelSmall.copyWith(color: color),
    );
  }

  /// Monospace code large style.
  static TextStyle codeLarge(Color color) {
    return GoogleFonts.firaCode(
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: color,
    );
  }

  /// Monospace code medium style.
  static TextStyle codeMedium(Color color) {
    return GoogleFonts.firaCode(
      fontSize: 12.0,
      fontWeight: FontWeight.w400,
      height: 1.4,
      color: color,
    );
  }

  /// Helper for labelSmall style.
  static TextStyle labelSmallStyle([Color? color]) {
    return labelSmall.copyWith(color: color);
  }
}
