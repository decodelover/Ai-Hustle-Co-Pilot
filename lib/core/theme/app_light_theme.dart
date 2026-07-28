/// Enterprise Material 3 Light Theme configuration.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_elevation.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_shadows.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/core/theme/app_typography.dart';
import 'package:ai_hustle_copilot/core/theme/theme_extensions.dart';
import 'package:flutter/material.dart';

/// Configures the production-grade Material 3 Light ThemeData.
ThemeData getAppLightTheme() {
  const colorScheme = ColorScheme.light(
    primary: AppColors.primary,
    secondary: AppColors.secondary,
    onSecondary: AppColors.onSecondary,
    tertiary: AppColors.accent,
    onTertiary: AppColors.onAccent,
    onSurface: AppColors.onSurface,
    surfaceContainerHigh: AppColors.surfaceVariant,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    outline: AppColors.outline,
    outlineVariant: AppColors.outlineVariant,
    error: AppColors.danger,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: AppTypography.lightTextTheme(AppColors.onSurface),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.surface,
      foregroundColor: AppColors.onSurface,
      elevation: AppElevation.level0,
      scrolledUnderElevation: AppElevation.level1,
      centerTitle: false,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.surface,
      elevation: AppElevation.level1,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderLarge,
        side: BorderSide(color: AppColors.outline),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surfaceVariant,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      border: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.primary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.danger, width: 2.0),
      ),
      hintStyle: TextStyle(color: AppColors.onSurfaceVariant),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        minimumSize: const Size(double.infinity, AppSpacing.space48),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderMedium,
        ),
        elevation: AppElevation.level1,
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.onSurface,
        side: const BorderSide(color: AppColors.outline),
        minimumSize: const Size(double.infinity, AppSpacing.space48),
        shape: const RoundedRectangleBorder(
          borderRadius: AppRadius.borderMedium,
        ),
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary,
        minimumSize: const Size(0, AppSpacing.space48),
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.surface,
      elevation: AppElevation.level4,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderXLarge,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.surface,
      elevation: AppElevation.level5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xLarge),
        ),
      ),
    ),
    extensions: const [
      AiColorsExtension(
        accent: AppColors.accent,
        onAccent: AppColors.onAccent,
        glowColor: Color(0x406D28D9),
        sparkGradient: LinearGradient(
          colors: [AppColors.primary, AppColors.accent],
        ),
      ),
      ChartColorsExtension(
        chart1: AppColors.chart1,
        chart2: AppColors.chart2,
        chart3: AppColors.chart3,
        chart4: AppColors.chart4,
        chart5: AppColors.chart5,
      ),
      StatusColorsExtension(
        success: AppColors.success,
        onSuccess: AppColors.onSuccess,
        warning: AppColors.warning,
        onWarning: AppColors.onWarning,
        danger: AppColors.danger,
        onDanger: AppColors.onDanger,
        info: AppColors.info,
        onInfo: AppColors.onInfo,
      ),
      ShadowsExtension(
        sm: AppShadows.lightSm,
        md: AppShadows.lightMd,
        lg: AppShadows.lightLg,
        aiGlow: AppShadows.lightAiGlow,
      ),
      SpacingExtension(
        space4: AppSpacing.space4,
        space8: AppSpacing.space8,
        space12: AppSpacing.space12,
        space16: AppSpacing.space16,
        space20: AppSpacing.space20,
        space24: AppSpacing.space24,
        space32: AppSpacing.space32,
        space40: AppSpacing.space40,
        space48: AppSpacing.space48,
        space64: AppSpacing.space64,
      ),
      RadiusExtension(
        small: AppRadius.small,
        medium: AppRadius.medium,
        large: AppRadius.large,
        xLarge: AppRadius.xLarge,
        pill: AppRadius.pill,
      ),
      AnimationExtension(
        fast: AppMotion.fast,
        medium: AppMotion.medium,
        slow: AppMotion.slow,
        standardCurve: AppMotion.standardCurve,
        springCurve: AppMotion.springCurve,
      ),
    ],
  );
}
