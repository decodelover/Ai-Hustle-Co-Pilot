/// Border radius tokens for AI Hustle Co-Pilot — Master Design System V2.0.
library;

import 'package:flutter/material.dart';

/// Centralized immutable border radius tokens adhering to Design System V2.0 specs.
abstract class AppRadius {
  /// Extra small border radius (4.0dp).
  static const double extraSmall = 4.0;

  /// Small border radius (8.0dp).
  static const double small = 8.0;

  /// Medium border radius for inputs (16.0dp).
  static const double medium = 16.0;

  /// Large standard card border radius (24.0dp).
  static const double large = 24.0;

  /// Extra large modal/dialog border radius (28.0dp).
  static const double xLarge = 28.0;

  /// Bottom sheet border radius (32.0dp).
  static const double xxLarge = 32.0;

  /// Pill border radius (999.0dp).
  static const double pill = 999.0;

  /// Circular border radius (50.0dp / percentage).
  static const double circular = 50.0;

  // ── Radius Object Constants ────────────────────────────────────────────
  /// Radius object extra small (4.0dp).
  static const Radius radiusObjectExtraSmall = Radius.circular(extraSmall);

  /// Radius object small (8.0dp).
  static const Radius radiusObjectSmall = Radius.circular(small);

  /// Radius object medium (16.0dp).
  static const Radius radiusObjectMedium = Radius.circular(medium);

  /// Radius object large (24.0dp).
  static const Radius radiusObjectLarge = Radius.circular(large);

  /// Radius object xLarge (28.0dp).
  static const Radius radiusObjectXLarge = Radius.circular(xLarge);

  /// Radius object xxLarge (32.0dp).
  static const Radius radiusObjectXXLarge = Radius.circular(xxLarge);

  // ── Semantic Aliases ───────────────────────────────────────────────────
  /// Alias for extraSmall (4dp).
  static const double xs = extraSmall;

  /// Alias for small (8dp).
  static const double sm = small;

  /// Alias for medium (16dp).
  static const double md = medium;

  /// Alias for large (24dp).
  static const double lg = large;

  /// Alias for xLarge (28dp).
  static const double xl = xLarge;

  /// Alias for xxLarge (32dp).
  static const double xxl = xxLarge;

  /// Alias for pill (999dp).
  static const double full = pill;

  /// Alias for small (8dp).
  static const double radiusSm = small;

  /// Alias for medium (16dp).
  static const double radiusMd = medium;

  /// Alias for large (24dp).
  static const double radiusLg = large;

  /// Alias for xLarge (28dp).
  static const double radiusXl = xLarge;

  /// Alias for pill (999dp).
  static const double radiusPill = pill;

  // ── BorderRadius Constants ──────────────────────────────────────────────
  /// Radius geometry for extra small elements.
  static const BorderRadius borderExtraSmall = BorderRadius.all(
    radiusObjectExtraSmall,
  );

  /// Radius geometry for small elements.
  static const BorderRadius borderSmall = BorderRadius.all(radiusObjectSmall);

  /// Radius geometry for medium elements (inputs).
  static const BorderRadius borderMedium = BorderRadius.all(radiusObjectMedium);

  /// Radius geometry for large elements (cards).
  static const BorderRadius borderLarge = BorderRadius.all(radiusObjectLarge);

  /// Radius geometry for extra large elements (dialogs).
  static const BorderRadius borderXLarge = BorderRadius.all(radiusObjectXLarge);

  /// Radius geometry for bottom sheets (32dp).
  static const BorderRadius borderXXLarge = BorderRadius.all(
    radiusObjectXXLarge,
  );

  /// Radius geometry for pill buttons and chips.
  static const BorderRadius borderPill = BorderRadius.all(
    Radius.circular(pill),
  );

  // ── Legacy BorderRadius Aliases ─────────────────────────────────────────
  /// Alias for borderExtraSmall.
  static const BorderRadius borderRadiusXs = borderExtraSmall;

  /// Alias for borderSmall.
  static const BorderRadius borderRadiusSm = borderSmall;

  /// Alias for borderMedium.
  static const BorderRadius borderRadiusMd = borderMedium;

  /// Alias for borderLarge.
  static const BorderRadius borderRadiusLg = borderLarge;

  /// Alias for borderXLarge.
  static const BorderRadius borderRadiusXl = borderXLarge;

  /// Alias for borderPill.
  static const BorderRadius borderRadiusFull = borderPill;

  // ── OutlinedBorder Constants ────────────────────────────────────────────
  /// OutlinedBorder small.
  static const OutlinedBorder shapeSm = RoundedRectangleBorder(
    borderRadius: borderSmall,
  );

  /// OutlinedBorder medium.
  static const OutlinedBorder shapeMd = RoundedRectangleBorder(
    borderRadius: borderMedium,
  );

  /// OutlinedBorder large.
  static const OutlinedBorder shapeLg = RoundedRectangleBorder(
    borderRadius: borderLarge,
  );

  /// OutlinedBorder extra large.
  static const OutlinedBorder shapeXl = RoundedRectangleBorder(
    borderRadius: borderXLarge,
  );

  /// OutlinedBorder pill.
  static const OutlinedBorder shapePill = RoundedRectangleBorder(
    borderRadius: borderPill,
  );
}
