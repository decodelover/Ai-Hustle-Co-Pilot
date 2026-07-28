/// Spatial grid definitions for AI Hustle Co-Pilot based on an 8-point spatial system.
library;

import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:flutter/material.dart';

/// Centralized immutable spatial tokens and layout helpers.
abstract class AppSpacing {
  // ── Raw Spatial Values ──────────────────────────────────────────────────
  /// 4dp micro spatial token.
  static const double space4 = 4.0;

  /// 8dp spatial token.
  static const double space8 = 8.0;

  /// 12dp spatial token.
  static const double space12 = 12.0;

  /// 16dp standard screen margin spatial token.
  static const double space16 = 16.0;

  /// 20dp spatial token.
  static const double space20 = 20.0;

  /// 24dp section spacing token.
  static const double space24 = 24.0;

  /// 32dp spatial token.
  static const double space32 = 32.0;

  /// 40dp spatial token.
  static const double space40 = 40.0;

  /// 48dp minimum accessibility touch target spatial token.
  static const double space48 = 48.0;

  /// 64dp spatial token.
  static const double space64 = 64.0;

  /// 80dp spatial token.
  static const double space80 = 80.0;

  /// 96dp maximum desktop section spatial token.
  static const double space96 = 96.0;

  /// Minimum touch target dimension (48dp).
  static const double minTouchTarget = space48;

  // ── Semantic Aliases ───────────────────────────────────────────────────
  /// Alias for 4dp (space4).
  static const double xs = space4;

  /// Alias for 8dp (space8).
  static const double sm = space8;

  /// Alias for 16dp (space16).
  static const double md = space16;

  /// Alias for 24dp (space24).
  static const double lg = space24;

  /// Alias for 32dp (space32).
  static const double xl = space32;

  /// Alias for 40dp (space40).
  static const double xxl = space40;

  /// Alias for 80dp (space80).
  static const double xxxl = space80;

  /// Alias for 64dp (space64).
  static const double huge = space64;

  /// Alias for 96dp (space96).
  static const double massive = space96;

  // ── Radius Aliases ─────────────────────────────────────────────────────
  /// Radius small alias (6dp).
  static const double radiusSm = AppRadius.small;

  /// Radius medium alias (10dp).
  static const double radiusMd = AppRadius.medium;

  /// Radius large alias (16dp).
  static const double radiusLg = AppRadius.large;

  /// Radius extra large alias (24dp).
  static const double radiusXl = AppRadius.xLarge;

  // ── EdgeInsets Shortcuts ────────────────────────────────────────────────
  /// Uniform padding of 4dp.
  static const EdgeInsets p4 = EdgeInsets.all(space4);

  /// Uniform padding of 8dp.
  static const EdgeInsets p8 = EdgeInsets.all(space8);

  /// Uniform padding of 12dp.
  static const EdgeInsets p12 = EdgeInsets.all(space12);

  /// Uniform padding of 16dp.
  static const EdgeInsets p16 = EdgeInsets.all(space16);

  /// Uniform padding of 20dp.
  static const EdgeInsets p20 = EdgeInsets.all(space20);

  /// Uniform padding of 24dp.
  static const EdgeInsets p24 = EdgeInsets.all(space24);

  /// Uniform padding of 32dp.
  static const EdgeInsets p32 = EdgeInsets.all(space32);

  /// Horizontal padding of 16dp.
  static const EdgeInsets px16 = EdgeInsets.symmetric(horizontal: space16);

  /// Vertical padding of 16dp.
  static const EdgeInsets py16 = EdgeInsets.symmetric(vertical: space16);

  /// Horizontal padding of 24dp.
  static const EdgeInsets px24 = EdgeInsets.symmetric(horizontal: space24);

  /// Vertical padding of 24dp.
  static const EdgeInsets py24 = EdgeInsets.symmetric(vertical: space24);

  // ── Semantic Padding Helpers ───────────────────────────────────────────
  /// Padding all 4dp (xs).
  static const EdgeInsets paddingAllXs = EdgeInsets.all(xs);

  /// Padding all 8dp (sm).
  static const EdgeInsets paddingAllSm = EdgeInsets.all(sm);

  /// Padding all 16dp (md).
  static const EdgeInsets paddingAllMd = EdgeInsets.all(md);

  /// Padding all 24dp (lg).
  static const EdgeInsets paddingAllLg = EdgeInsets.all(lg);

  /// Padding all 32dp (xl).
  static const EdgeInsets paddingAllXl = EdgeInsets.all(xl);

  /// Horizontal padding 8dp (sm).
  static const EdgeInsets paddingHorizontalSm =
      EdgeInsets.symmetric(horizontal: sm);

  /// Horizontal padding 16dp (md).
  static const EdgeInsets paddingHorizontalMd =
      EdgeInsets.symmetric(horizontal: md);

  /// Horizontal padding 24dp (lg).
  static const EdgeInsets paddingHorizontalLg =
      EdgeInsets.symmetric(horizontal: lg);

  /// Vertical padding 8dp (sm).
  static const EdgeInsets paddingVerticalSm =
      EdgeInsets.symmetric(vertical: sm);

  /// Vertical padding 16dp (md).
  static const EdgeInsets paddingVerticalMd =
      EdgeInsets.symmetric(vertical: md);

  /// Vertical padding 24dp (lg).
  static const EdgeInsets paddingVerticalLg =
      EdgeInsets.symmetric(vertical: lg);

  // ── SizedBox Gap Helpers ────────────────────────────────────────────────
  /// 4dp square gap.
  static const SizedBox gap4 = SizedBox(width: space4, height: space4);

  /// 8dp square gap.
  static const SizedBox gap8 = SizedBox(width: space8, height: space8);

  /// 12dp square gap.
  static const SizedBox gap12 = SizedBox(width: space12, height: space12);

  /// 16dp square gap.
  static const SizedBox gap16 = SizedBox(width: space16, height: space16);

  /// 20dp square gap.
  static const SizedBox gap20 = SizedBox(width: space20, height: space20);

  /// 24dp square gap.
  static const SizedBox gap24 = SizedBox(width: space24, height: space24);

  /// 32dp square gap.
  static const SizedBox gap32 = SizedBox(width: space32, height: space32);
}
