/// Custom theme extensions for AI Hustle Co-Pilot design system.
///
/// Provides custom design tokens (status colors, AI gradients, custom card borders)
/// via Flutter's [ThemeExtension] system.
library;

import 'package:ai_hustle_copilot/core/design_system/tokens/app_colors.dart';
import 'package:flutter/material.dart';

/// Custom theme extension for domain-specific status and AI design tokens.
@immutable
class AppCustomThemeExtension extends ThemeExtension<AppCustomThemeExtension> {
  const AppCustomThemeExtension({
    required this.statusPending,
    required this.statusInProgress,
    required this.statusCompleted,
    required this.statusRejected,
    required this.aiGradientStart,
    required this.aiGradientEnd,
    required this.aiGlowColor,
    required this.cardBorder,
  });

  /// Pending status color (Amber).
  final Color statusPending;

  /// In-progress status color (Blue).
  final Color statusInProgress;

  /// Completed/Approved status color (Emerald).
  final Color statusCompleted;

  /// Rejected/Cancelled status color (Red).
  final Color statusRejected;

  /// AI gradient start color (Royal Blue).
  final Color aiGradientStart;

  /// AI gradient end color (Emerald/Teal).
  final Color aiGradientEnd;

  /// AI glow background color.
  final Color aiGlowColor;

  /// Custom subtle card border color.
  final Color cardBorder;

  /// Standard Light Mode custom extension instance.
  static const AppCustomThemeExtension light = AppCustomThemeExtension(
    statusPending: Color(0xFFF59E0B),
    statusInProgress: Color(0xFF2563EB),
    statusCompleted: Color(0xFF10B981),
    statusRejected: Color(0xFFEF4444),
    aiGradientStart: Color(0xFF2563EB),
    aiGradientEnd: Color(0xFF10B981),
    aiGlowColor: Color(0x1F2563EB),
    cardBorder: AppColors.divider,
  );

  /// Standard Dark Mode custom extension instance.
  static const AppCustomThemeExtension dark = AppCustomThemeExtension(
    statusPending: Color(0xFFFBBF24),
    statusInProgress: Color(0xFF60A5FA),
    statusCompleted: Color(0xFF34D399),
    statusRejected: Color(0xFFF87171),
    aiGradientStart: Color(0xFF3B82F6),
    aiGradientEnd: Color(0xFF34D399),
    aiGlowColor: Color(0x333B82F6),
    cardBorder: AppColors.darkDivider,
  );

  @override
  AppCustomThemeExtension copyWith({
    Color? statusPending,
    Color? statusInProgress,
    Color? statusCompleted,
    Color? statusRejected,
    Color? aiGradientStart,
    Color? aiGradientEnd,
    Color? aiGlowColor,
    Color? cardBorder,
  }) {
    return AppCustomThemeExtension(
      statusPending: statusPending ?? this.statusPending,
      statusInProgress: statusInProgress ?? this.statusInProgress,
      statusCompleted: statusCompleted ?? this.statusCompleted,
      statusRejected: statusRejected ?? this.statusRejected,
      aiGradientStart: aiGradientStart ?? this.aiGradientStart,
      aiGradientEnd: aiGradientEnd ?? this.aiGradientEnd,
      aiGlowColor: aiGlowColor ?? this.aiGlowColor,
      cardBorder: cardBorder ?? this.cardBorder,
    );
  }

  @override
  AppCustomThemeExtension lerp(
    covariant ThemeExtension<AppCustomThemeExtension>? other,
    double t,
  ) {
    if (other is! AppCustomThemeExtension) return this;
    return AppCustomThemeExtension(
      statusPending: Color.lerp(statusPending, other.statusPending, t)!,
      statusInProgress: Color.lerp(
        statusInProgress,
        other.statusInProgress,
        t,
      )!,
      statusCompleted: Color.lerp(statusCompleted, other.statusCompleted, t)!,
      statusRejected: Color.lerp(statusRejected, other.statusRejected, t)!,
      aiGradientStart: Color.lerp(aiGradientStart, other.aiGradientStart, t)!,
      aiGradientEnd: Color.lerp(aiGradientEnd, other.aiGradientEnd, t)!,
      aiGlowColor: Color.lerp(aiGlowColor, other.aiGlowColor, t)!,
      cardBorder: Color.lerp(cardBorder, other.cardBorder, t)!,
    );
  }
}
