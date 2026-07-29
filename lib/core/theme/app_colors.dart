/// Enterprise color palette definitions for AI Hustle Co-Pilot.
///
/// Established directly from the Master Design Specification:
/// - Primary Accent & Buttons: Vibrant Blue (#3D82F7)
/// - Light Canvas Background: Light Soft Gray (#F4F5F8)
/// - Card Surface: Pure White (#FFFFFF)
/// - Dark Onboarding Canvas: Dark Slate (#3D4655 / #2B323E)
/// - Primary Text: Deep Charcoal (#111111)
/// - Secondary Text & Muted Labels: Soft Gray (#777777)
library;

import 'package:flutter/material.dart';

/// Centralized immutable color constants adhering strictly to the Master Specification.
abstract class AppColors {
  // ── Light Theme Palette ────────────────────────────────────────────────
  /// Vibrant Blue primary color representing trust, tech, and action (#3D82F7).
  static const Color primary = Color(0xFF3D82F7);

  /// High-contrast text/icon color on top of primary filled elements.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Indigo-Blue accent for secondary interactive elements and active tabs (#1877F2).
  static const Color secondary = Color(0xFF1877F2);

  /// Contrast color for text/icons on top of secondary elements.
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Electric Cyan-Blue reserved for AI Copilot triggers and spark indicators.
  static const Color accent = Color(0xFF3B82F6);

  /// Contrast text over accent elements.
  static const Color onAccent = Color(0xFFFFFFFF);

  /// Soft light canvas background (#F4F5F8).
  static const Color background = Color(0xFFF4F5F8);

  /// Pure white surface color for cards, panels, and container dialogs (#FFFFFF).
  static const Color surface = Color(0xFFFFFFFF);

  /// Input background and nested container fill (#F4F5F8).
  static const Color surfaceVariant = Color(0xFFF4F5F8);

  /// Deep charcoal text color (#111111).
  static const Color onSurface = Color(0xFF111111);

  /// Secondary body text, subheadings, and field labels (#777777).
  static const Color onSurfaceVariant = Color(0xFF777777);

  /// Crisp 1px border stroke for card bounds and input fields.
  static const Color outline = Color(0xFFE5E7EB);

  /// Active focus and hover border stroke state.
  static const Color outlineVariant = Color(0xFFCBD5E1);

  /// Emerald green confirming completed workflows, saved drafts, and active syncs.
  static const Color success = Color(0xFF059669);

  /// Contrast text over success containers.
  static const Color onSuccess = Color(0xFFFFFFFF);

  /// Amber warning for pending approvals, quota limits, and network degradation.
  static const Color warning = Color(0xFFD97706);

  /// Contrast text over warning containers.
  static const Color onWarning = Color(0xFFFFFFFF);

  /// Ruby red for destructive actions, validation errors, and auth failures.
  static const Color danger = Color(0xFFDC2626);

  /// Alias for danger color.
  static const Color error = danger;

  /// Contrast text over danger containers.
  static const Color onDanger = Color(0xFFFFFFFF);

  /// Royal blue for neutral system notifications and informational badges.
  static const Color info = Color(0xFF3D82F7);

  /// Contrast text over info containers.
  static const Color onInfo = Color(0xFFFFFFFF);

  /// Skeleton shimmer starting color for light mode loading state.
  static const Color skeletonStart = Color(0xFFE2E8F0);

  /// Skeleton shimmer ending color for light mode loading state.
  static const Color skeletonEnd = Color(0xFFF4F5F8);

  /// Alias for skeletonStart.
  static const Color shimmerBaseLight = skeletonStart;

  /// Alias for skeletonEnd.
  static const Color shimmerHighlightLight = skeletonEnd;

  // ── Semantic & Legacy Aliases ──────────────────────────────────────────
  /// Primary container light background color.
  static const Color primaryContainer = surfaceVariant;

  /// Primary container dark background color.
  static const Color primaryContainerDark = darkSurfaceVariant;

  /// Alias for onSurface (#111111 text).
  static const Color textPrimary = onSurface;

  /// Alias for onSurface (#111111 text).
  static const Color textPrimaryLight = onSurface;

  /// Alias for darkOnSurface (Off-white text).
  static const Color textPrimaryDark = darkOnSurface;

  /// Alias for onSurfaceVariant (#777777 secondary text).
  static const Color textSecondary = onSurfaceVariant;

  /// Alias for onSurfaceVariant.
  static const Color textSecondaryLight = onSurfaceVariant;

  /// Alias for darkOnSurfaceVariant.
  static const Color textSecondaryDark = darkOnSurfaceVariant;

  /// Alias for outline (card border).
  static const Color border = outline;

  /// Alias for outline (divider line).
  static const Color divider = outline;

  /// Alias for surface (card background).
  static const Color card = surface;

  // ── Dark Theme Palette ─────────────────────────────────────────────────
  /// Luminous blue primary for high contrast on dark surfaces (#3D82F7).
  static const Color darkPrimary = Color(0xFF3D82F7);

  /// Text color on top of dark primary filled buttons.
  static const Color darkOnPrimary = Color(0xFFFFFFFF);

  /// Secondary active states in dark mode.
  static const Color darkSecondary = Color(0xFF60A5FA);

  /// Text color on top of dark secondary elements.
  static const Color darkOnSecondary = Color(0xFF0F172A);

  /// Accent glows in dark mode.
  static const Color darkAccent = Color(0xFF60A5FA);

  /// Text color on top of dark accent containers.
  static const Color darkOnAccent = Color(0xFF0F172A);

  /// Master Slate dark background canvas (#3D4655).
  static const Color darkBackground = Color(0xFF3D4655);

  /// Dark surface for panels, cards, and navigation (#2B323E).
  static const Color darkSurface = Color(0xFF2B323E);

  /// Elevated surface variant for inputs in dark mode (#262D38).
  static const Color darkSurfaceVariant = Color(0xFF262D38);

  /// Off-white text delivering high contrast against dark background.
  static const Color darkOnSurface = Color(0xFFF8FAFC);

  /// Muted secondary text for dark mode.
  static const Color darkOnSurfaceVariant = Color(0xFF94A3B8);

  /// Subtle dark border stroke separating card containers.
  static const Color darkOutline = Color(0xFF262D38);

  /// Active dark border highlight stroke.
  static const Color darkOutlineVariant = Color(0xFF3D4655);

  /// Bright Emerald green for dark mode success indicators.
  static const Color darkSuccess = Color(0xFF10B981);

  /// Text color on dark success containers.
  static const Color darkOnSuccess = Color(0xFF0F172A);

  /// Bright Amber for dark mode warnings.
  static const Color darkWarning = Color(0xFFF59E0B);

  /// Text color on dark warning containers.
  static const Color darkOnWarning = Color(0xFF0F172A);

  /// Crimson Red for dark mode destructive alerts.
  static const Color darkDanger = Color(0xFFEF4444);

  /// Text color on dark danger containers.
  static const Color darkOnDanger = Color(0xFFFFFFFF);

  /// Sky Blue for dark mode system info.
  static const Color darkInfo = Color(0xFF60A5FA);

  /// Text color on dark info containers.
  static const Color darkOnInfo = Color(0xFF0F172A);

  /// Skeleton shimmer starting color for dark mode loading state.
  static const Color darkSkeletonStart = Color(0xFF262D38);

  /// Skeleton shimmer ending color for dark mode loading state.
  static const Color darkSkeletonEnd = Color(0xFF2B323E);

  /// Alias for darkSkeletonStart.
  static const Color shimmerBaseDark = darkSkeletonStart;

  /// Alias for darkSkeletonEnd.
  static const Color shimmerHighlightDark = darkSkeletonEnd;

  /// Alias for darkOutline.
  static const Color darkBorder = darkOutline;

  /// Alias for darkOutline.
  static const Color darkDivider = darkOutline;

  /// Alias for darkSurface.
  static const Color darkCard = darkSurface;

  // ── Chart Palette (Data Visualization) ──────────────────────────────────
  /// Chart series 1 color (Primary Blue).
  static const Color chart1 = Color(0xFF3D82F7);

  /// Chart series 2 color (Emerald Green).
  static const Color chart2 = Color(0xFF059669);

  /// Chart series 3 color (Royal Blue).
  static const Color chart3 = Color(0xFF1877F2);

  /// Chart series 4 color (Amber Yellow).
  static const Color chart4 = Color(0xFFD97706);

  /// Chart series 5 color (Sky Blue).
  static const Color chart5 = Color(0xFF60A5FA);

  // ── Interaction State Overlays ──────────────────────────────────────────
  /// Light mode hover overlay color.
  static const Color hoverOverlay = Color(0x0A111111);

  /// Light mode focus overlay color.
  static const Color focusOverlay = Color(0x1F3D82F7);

  /// Light mode pressed state overlay color.
  static const Color pressedOverlay = Color(0x1F111111);

  /// Light mode disabled container fill.
  static const Color disabledSurface = Color(0x1F111111);

  /// Light mode disabled text color.
  static const Color disabledText = Color(0x61111111);

  /// Dark mode hover overlay color.
  static const Color darkHoverOverlay = Color(0x0AF8FAFC);

  /// Dark mode focus overlay color.
  static const Color darkFocusOverlay = Color(0x333D82F7);

  /// Dark mode pressed state overlay color.
  static const Color darkPressedOverlay = Color(0x1FF8FAFC);

  /// Dark mode disabled container fill.
  static const Color darkDisabledSurface = Color(0x1FF8FAFC);

  /// Dark mode disabled text color.
  static const Color darkDisabledText = Color(0x61F8FAFC);
}
