/// Animation durations, easing curves, and motion constants.
library;

import 'package:flutter/material.dart';

/// Centralized immutable motion and animation tokens.
abstract class AppMotion {
  // ── Animation Durations ────────────────────────────────────────────────
  /// Fast duration (150ms) for micro-interactions and button feedback.
  static const Duration fast = Duration(milliseconds: 150);

  /// Medium duration (250ms) for card expands and tab transitions.
  static const Duration medium = Duration(milliseconds: 250);

  /// Slow duration (350ms) for page transitions and modal slides.
  static const Duration slow = Duration(milliseconds: 350);

  /// Micro animation duration (150ms).
  static const Duration micro = fast;

  /// Normal animation duration (250ms).
  static const Duration normal = medium;

  /// Press scale shrink factor (0.98x).
  static const double pressScale = 0.98;

  // ── Transition Specific Durations ──────────────────────────────────────
  /// Standard page route transition duration (300ms).
  static const Duration pageTransitionDuration = Duration(milliseconds: 300);

  /// Bottom sheet / modal slide duration (250ms).
  static const Duration modalSlideDuration = Duration(milliseconds: 250);

  /// Fade transition duration (150ms).
  static const Duration fadeDuration = Duration(milliseconds: 150);

  /// Scale feedback duration (200ms).
  static const Duration scaleDuration = Duration(milliseconds: 200);

  // ── Easing Curves ─────────────────────────────────────────────────────
  /// Standard Material emphasized decelerate curve.
  static const Curve standardCurve = Cubic(0.2, 0.0, 0.0, 1.0);

  /// Spring physics curve for subtle pop feedback on AI triggers.
  static const Curve springCurve = Cubic(0.34, 1.56, 0.64, 1.0);

  /// Smooth enter decelerate curve.
  static const Curve decelerateCurve = Curves.easeOutCubic;

  /// Fast exit accelerate curve.
  static const Curve accelerateCurve = Curves.easeInCubic;
}

/// Legacy alias class for [AppMotion].
abstract class AppAnimation {
  /// Fast duration (150ms).
  static const Duration fast = AppMotion.fast;

  /// Medium duration (250ms).
  static const Duration medium = AppMotion.medium;

  /// Slow duration (350ms).
  static const Duration slow = AppMotion.slow;

  /// Micro duration (150ms).
  static const Duration micro = AppMotion.micro;

  /// Normal duration (250ms).
  static const Duration normal = AppMotion.normal;

  /// Standard curve.
  static const Curve standard = AppMotion.standardCurve;

  /// Standard duration (250ms).
  static const Duration standardDuration = AppMotion.medium;

  /// Press scale shrink factor (0.98x).
  static const double pressScale = AppMotion.pressScale;

  /// Standard curve.
  static const Curve standardCurve = AppMotion.standardCurve;

  /// Spring curve.
  static const Curve springCurve = AppMotion.springCurve;

  /// Decelerate curve.
  static const Curve decelerateCurve = AppMotion.decelerateCurve;

  /// Accelerate curve.
  static const Curve accelerateCurve = AppMotion.accelerateCurve;
}
