/// Custom ThemeExtensions for AI Hustle Co-Pilot.
///
/// Provides type-safe theme access to AI accents, chart colors, status colors,
/// custom shadows, spatial tokens, radius tokens, and animation presets.
library;

import 'package:flutter/material.dart';

// ── 1. AI Colors Extension ──────────────────────────────────────────────────
/// ThemeExtension providing access to AI Copilot branding colors and glows.
class AiColorsExtension extends ThemeExtension<AiColorsExtension> {
  const AiColorsExtension({
    required this.accent,
    required this.onAccent,
    required this.glowColor,
    required this.sparkGradient,
  });

  final Color accent;
  final Color onAccent;
  final Color glowColor;
  final LinearGradient sparkGradient;

  @override
  AiColorsExtension copyWith({
    Color? accent,
    Color? onAccent,
    Color? glowColor,
    LinearGradient? sparkGradient,
  }) {
    return AiColorsExtension(
      accent: accent ?? this.accent,
      onAccent: onAccent ?? this.onAccent,
      glowColor: glowColor ?? this.glowColor,
      sparkGradient: sparkGradient ?? this.sparkGradient,
    );
  }

  @override
  AiColorsExtension lerp(
    covariant ThemeExtension<AiColorsExtension>? other,
    double t,
  ) {
    if (other is! AiColorsExtension) return this;
    return AiColorsExtension(
      accent: Color.lerp(accent, other.accent, t)!,
      onAccent: Color.lerp(onAccent, other.onAccent, t)!,
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
      sparkGradient: LinearGradient.lerp(
        sparkGradient,
        other.sparkGradient,
        t,
      )!,
    );
  }
}

// ── 2. Chart Colors Extension ───────────────────────────────────────────────
/// ThemeExtension providing data visualization chart colors.
class ChartColorsExtension extends ThemeExtension<ChartColorsExtension> {
  const ChartColorsExtension({
    required this.chart1,
    required this.chart2,
    required this.chart3,
    required this.chart4,
    required this.chart5,
  });

  final Color chart1;
  final Color chart2;
  final Color chart3;
  final Color chart4;
  final Color chart5;

  @override
  ChartColorsExtension copyWith({
    Color? chart1,
    Color? chart2,
    Color? chart3,
    Color? chart4,
    Color? chart5,
  }) {
    return ChartColorsExtension(
      chart1: chart1 ?? this.chart1,
      chart2: chart2 ?? this.chart2,
      chart3: chart3 ?? this.chart3,
      chart4: chart4 ?? this.chart4,
      chart5: chart5 ?? this.chart5,
    );
  }

  @override
  ChartColorsExtension lerp(
    covariant ThemeExtension<ChartColorsExtension>? other,
    double t,
  ) {
    if (other is! ChartColorsExtension) return this;
    return ChartColorsExtension(
      chart1: Color.lerp(chart1, other.chart1, t)!,
      chart2: Color.lerp(chart2, other.chart2, t)!,
      chart3: Color.lerp(chart3, other.chart3, t)!,
      chart4: Color.lerp(chart4, other.chart4, t)!,
      chart5: Color.lerp(chart5, other.chart5, t)!,
    );
  }
}

// ── 3. Status Colors Extension ──────────────────────────────────────────────
/// ThemeExtension providing success, warning, danger, and info colors with on-colors.
class StatusColorsExtension extends ThemeExtension<StatusColorsExtension> {
  const StatusColorsExtension({
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.danger,
    required this.onDanger,
    required this.info,
    required this.onInfo,
  });

  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color danger;
  final Color onDanger;
  final Color info;
  final Color onInfo;

  @override
  StatusColorsExtension copyWith({
    Color? success,
    Color? onSuccess,
    Color? warning,
    Color? onWarning,
    Color? danger,
    Color? onDanger,
    Color? info,
    Color? onInfo,
  }) {
    return StatusColorsExtension(
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      warning: warning ?? this.warning,
      onWarning: onWarning ?? this.onWarning,
      danger: danger ?? this.danger,
      onDanger: onDanger ?? this.onDanger,
      info: info ?? this.info,
      onInfo: onInfo ?? this.onInfo,
    );
  }

  @override
  StatusColorsExtension lerp(
    covariant ThemeExtension<StatusColorsExtension>? other,
    double t,
  ) {
    if (other is! StatusColorsExtension) return this;
    return StatusColorsExtension(
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      onWarning: Color.lerp(onWarning, other.onWarning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      onDanger: Color.lerp(onDanger, other.onDanger, t)!,
      info: Color.lerp(info, other.info, t)!,
      onInfo: Color.lerp(onInfo, other.onInfo, t)!,
    );
  }
}

// ── 4. Shadows Extension ─────────────────────────────────────────────────────
/// ThemeExtension providing custom elevation shadows and AI glows.
class ShadowsExtension extends ThemeExtension<ShadowsExtension> {
  const ShadowsExtension({
    required this.sm,
    required this.md,
    required this.lg,
    required this.aiGlow,
  });

  final List<BoxShadow> sm;
  final List<BoxShadow> md;
  final List<BoxShadow> lg;
  final List<BoxShadow> aiGlow;

  @override
  ShadowsExtension copyWith({
    List<BoxShadow>? sm,
    List<BoxShadow>? md,
    List<BoxShadow>? lg,
    List<BoxShadow>? aiGlow,
  }) {
    return ShadowsExtension(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      aiGlow: aiGlow ?? this.aiGlow,
    );
  }

  @override
  ShadowsExtension lerp(
    covariant ThemeExtension<ShadowsExtension>? other,
    double t,
  ) {
    if (other is! ShadowsExtension) return this;
    return ShadowsExtension(
      sm: BoxShadow.lerpList(sm, other.sm, t)!,
      md: BoxShadow.lerpList(md, other.md, t)!,
      lg: BoxShadow.lerpList(lg, other.lg, t)!,
      aiGlow: BoxShadow.lerpList(aiGlow, other.aiGlow, t)!,
    );
  }
}

// ── 5. Spacing Extension ─────────────────────────────────────────────────────
/// ThemeExtension providing spatial grid tokens.
class SpacingExtension extends ThemeExtension<SpacingExtension> {
  const SpacingExtension({
    required this.space4,
    required this.space8,
    required this.space12,
    required this.space16,
    required this.space20,
    required this.space24,
    required this.space32,
    required this.space40,
    required this.space48,
    required this.space64,
  });

  final double space4;
  final double space8;
  final double space12;
  final double space16;
  final double space20;
  final double space24;
  final double space32;
  final double space40;
  final double space48;
  final double space64;

  @override
  SpacingExtension copyWith({
    double? space4,
    double? space8,
    double? space12,
    double? space16,
    double? space20,
    double? space24,
    double? space32,
    double? space40,
    double? space48,
    double? space64,
  }) {
    return SpacingExtension(
      space4: space4 ?? this.space4,
      space8: space8 ?? this.space8,
      space12: space12 ?? this.space12,
      space16: space16 ?? this.space16,
      space20: space20 ?? this.space20,
      space24: space24 ?? this.space24,
      space32: space32 ?? this.space32,
      space40: space40 ?? this.space40,
      space48: space48 ?? this.space48,
      space64: space64 ?? this.space64,
    );
  }

  @override
  SpacingExtension lerp(
    covariant ThemeExtension<SpacingExtension>? other,
    double t,
  ) {
    if (other is! SpacingExtension) return this;
    return SpacingExtension(
      space4: space4 + (other.space4 - space4) * t,
      space8: space8 + (other.space8 - space8) * t,
      space12: space12 + (other.space12 - space12) * t,
      space16: space16 + (other.space16 - space16) * t,
      space20: space20 + (other.space20 - space20) * t,
      space24: space24 + (other.space24 - space24) * t,
      space32: space32 + (other.space32 - space32) * t,
      space40: space40 + (other.space40 - space40) * t,
      space48: space48 + (other.space48 - space48) * t,
      space64: space64 + (other.space64 - space64) * t,
    );
  }
}

// ── 6. Radius Extension ──────────────────────────────────────────────────────
/// ThemeExtension providing border radius tokens.
class RadiusExtension extends ThemeExtension<RadiusExtension> {
  const RadiusExtension({
    required this.small,
    required this.medium,
    required this.large,
    required this.xLarge,
    required this.pill,
  });

  final double small;
  final double medium;
  final double large;
  final double xLarge;
  final double pill;

  @override
  RadiusExtension copyWith({
    double? small,
    double? medium,
    double? large,
    double? xLarge,
    double? pill,
  }) {
    return RadiusExtension(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
      xLarge: xLarge ?? this.xLarge,
      pill: pill ?? this.pill,
    );
  }

  @override
  RadiusExtension lerp(
    covariant ThemeExtension<RadiusExtension>? other,
    double t,
  ) {
    if (other is! RadiusExtension) return this;
    return RadiusExtension(
      small: small + (other.small - small) * t,
      medium: medium + (other.medium - medium) * t,
      large: large + (other.large - large) * t,
      xLarge: xLarge + (other.xLarge - xLarge) * t,
      pill: pill + (other.pill - pill) * t,
    );
  }
}

// ── 7. Animation Extension ───────────────────────────────────────────────────
/// ThemeExtension providing animation durations and curves.
class AnimationExtension extends ThemeExtension<AnimationExtension> {
  const AnimationExtension({
    required this.fast,
    required this.medium,
    required this.slow,
    required this.standardCurve,
    required this.springCurve,
  });

  final Duration fast;
  final Duration medium;
  final Duration slow;
  final Curve standardCurve;
  final Curve springCurve;

  @override
  AnimationExtension copyWith({
    Duration? fast,
    Duration? medium,
    Duration? slow,
    Curve? standardCurve,
    Curve? springCurve,
  }) {
    return AnimationExtension(
      fast: fast ?? this.fast,
      medium: medium ?? this.medium,
      slow: slow ?? this.slow,
      standardCurve: standardCurve ?? this.standardCurve,
      springCurve: springCurve ?? this.springCurve,
    );
  }

  @override
  AnimationExtension lerp(
    covariant ThemeExtension<AnimationExtension>? other,
    double t,
  ) {
    if (other is! AnimationExtension) return this;
    return AnimationExtension(
      fast: t < 0.5 ? fast : other.fast,
      medium: t < 0.5 ? medium : other.medium,
      slow: t < 0.5 ? slow : other.slow,
      standardCurve: t < 0.5 ? standardCurve : other.standardCurve,
      springCurve: t < 0.5 ? springCurve : other.springCurve,
    );
  }
}
