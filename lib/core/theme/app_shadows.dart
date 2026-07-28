/// Reusable BoxShadow definitions for Light and Dark themes.
library;

import 'package:flutter/material.dart';

/// Centralized immutable shadow presets and AI copilot glow effects.
abstract class AppShadows {
  // ── Light Theme Shadows ────────────────────────────────────────────────
  /// Subtle card elevation shadow for light mode.
  static const List<BoxShadow> lightSm = [
    BoxShadow(
      color: Color(0x0D0F172A),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  /// Medium popover/dropdown shadow for light mode.
  static const List<BoxShadow> lightMd = [
    BoxShadow(
      color: Color(0x140F172A),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0A0F172A),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -2,
    ),
  ];

  /// Elevated modal/dialog shadow for light mode.
  static const List<BoxShadow> lightLg = [
    BoxShadow(
      color: Color(0x1A0F172A),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0D0F172A),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -4,
    ),
  ];

  /// Signature AI Copilot glowing purple shadow for light mode.
  static const List<BoxShadow> lightAiGlow = [
    BoxShadow(
      color: Color(0x406D28D9),
      blurRadius: 20,
      spreadRadius: 2,
    ),
  ];

  // ── Dark Theme Shadows ─────────────────────────────────────────────────
  /// Subtle card elevation shadow for dark mode.
  static const List<BoxShadow> darkSm = [
    BoxShadow(
      color: Color(0x66000000),
      offset: Offset(0, 1),
      blurRadius: 2,
    ),
  ];

  /// Medium popover/dropdown shadow for dark mode.
  static const List<BoxShadow> darkMd = [
    BoxShadow(
      color: Color(0x80000000),
      offset: Offset(0, 4),
      blurRadius: 12,
    ),
  ];

  /// Elevated modal/dialog shadow for dark mode.
  static const List<BoxShadow> darkLg = [
    BoxShadow(
      color: Color(0xB3000000),
      offset: Offset(0, 12),
      blurRadius: 24,
    ),
  ];

  /// Signature AI Copilot glowing neon purple shadow for dark mode.
  static const List<BoxShadow> darkAiGlow = [
    BoxShadow(
      color: Color(0x599333EA),
      blurRadius: 24,
      spreadRadius: 2,
    ),
  ];
}
