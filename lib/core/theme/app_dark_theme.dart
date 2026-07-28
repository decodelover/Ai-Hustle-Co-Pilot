/// Enterprise Material 3 Dark Theme configuration.
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

/// Configures the production-grade Material 3 Dark ThemeData.
ThemeData getAppDarkTheme() {
  const colorScheme = ColorScheme.dark(
    primary: AppColors.darkPrimary,
    onPrimary: AppColors.darkOnPrimary,
    secondary: AppColors.darkSecondary,
    onSecondary: AppColors.darkOnSecondary,
    tertiary: AppColors.darkAccent,
    onTertiary: AppColors.darkOnAccent,
    surface: AppColors.darkSurface,
    onSurface: AppColors.darkOnSurface,
    surfaceContainerHigh: AppColors.darkSurfaceVariant,
    onSurfaceVariant: AppColors.darkOnSurfaceVariant,
    outline: AppColors.darkOutline,
    outlineVariant: AppColors.darkOutlineVariant,
    error: AppColors.darkDanger,
    onError: AppColors.darkOnDanger,
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: AppColors.darkBackground,
    textTheme: AppTypography.lightTextTheme(AppColors.darkOnSurface),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkSurface,
      foregroundColor: AppColors.darkOnSurface,
      elevation: AppElevation.level0,
      scrolledUnderElevation: AppElevation.level1,
      centerTitle: false,
    ),
    cardTheme: const CardThemeData(
      color: AppColors.darkSurface,
      elevation: AppElevation.level1,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderLarge,
        side: BorderSide(color: AppColors.darkOutline),
      ),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurfaceVariant,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space12,
      ),
      border: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.darkOutline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.darkOutline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.darkPrimary, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.darkDanger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: AppRadius.borderMedium,
        borderSide: BorderSide(color: AppColors.darkDanger, width: 2.0),
      ),
      hintStyle: TextStyle(color: AppColors.darkOnSurfaceVariant),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkPrimary,
        foregroundColor: AppColors.darkOnPrimary,
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
        foregroundColor: AppColors.darkOnSurface,
        side: const BorderSide(color: AppColors.darkOutlineVariant),
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
        foregroundColor: AppColors.darkPrimary,
        minimumSize: const Size(0, AppSpacing.space48),
        textStyle: const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: AppElevation.level4,
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.borderXLarge,
      ),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.darkSurface,
      elevation: AppElevation.level5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppRadius.xLarge),
        ),
      ),
    ),
    extensions: const [
      AiColorsExtension(
        accent: AppColors.darkAccent,
        onAccent: AppColors.darkOnAccent,
        glowColor: Color(0x599333EA),
        sparkGradient: LinearGradient(
          colors: [AppColors.darkPrimary, AppColors.darkAccent],
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
        success: AppColors.darkSuccess,
        onSuccess: AppColors.darkOnSuccess,
        warning: AppColors.darkWarning,
        onWarning: AppColors.darkOnWarning,
        danger: AppColors.darkDanger,
        onDanger: AppColors.darkOnDanger,
        info: AppColors.darkInfo,
        onInfo: AppColors.darkOnInfo,
      ),
      ShadowsExtension(
        sm: AppShadows.darkSm,
        md: AppShadows.darkMd,
        lg: AppShadows.darkLg,
        aiGlow: AppShadows.darkAiGlow,
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
