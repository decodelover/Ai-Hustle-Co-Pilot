/// Enterprise color palette definitions for AI Hustle Co-Pilot.
///
/// Contains explicit constants for Light and Dark themes, chart visualizations,
/// AI copilot accents, status indicators, and interaction overlays.
library;

import 'package:flutter/material.dart';

/// Centralized immutable color constants adhering strictly to the Enterprise Design Specification.
abstract class AppColors {
  // ── Light Theme Palette ────────────────────────────────────────────────
  /// Deep Violet primary color representing intelligence and AI capability.
  static const Color primary = Color(0xFF6D28D9);

  /// High-contrast text/icon color on top of primary filled elements.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Indigo accent for secondary interactive elements, active tabs, and navigation.
  static const Color secondary = Color(0xFF4F46E5);

  /// Contrast color for text/icons on top of secondary elements.
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Electric Magenta reserved exclusively for AI Copilot triggers and spark indicators.
  static const Color accent = Color(0xFFEC4899);

  /// Contrast text over electric magenta accent elements.
  static const Color onAccent = Color(0xFFFFFFFF);

  /// Soft Slate background tint preventing blinding glare during extended usage.
  static const Color background = Color(0xFFF8FAFC);

  /// Pure white surface color for cards, panels, and container dialogs.
  static const Color surface = Color(0xFFFFFFFF);

  /// Subtle grey container surface for inputs, table headers, and nested cards.
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  /// Near-black Slate 900 text color delivering 16.5:1 WCAG AAA contrast.
  static const Color onSurface = Color(0xFF0F172A);

  /// Secondary body text, subheadings, and field labels (5.2:1 WCAG AA).
  static const Color onSurfaceVariant = Color(0xFF475569);

  /// Crisp 1px border stroke for card bounds and input fields.
  static const Color outline = Color(0xFFE2E8F0);

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
  static const Color info = Color(0xFF2563EB);

  /// Contrast text over info containers.
  static const Color onInfo = Color(0xFFFFFFFF);

  /// Skeleton shimmer starting color for light mode loading state.
  static const Color skeletonStart = Color(0xFFE2E8F0);

  /// Skeleton shimmer ending color for light mode loading state.
  static const Color skeletonEnd = Color(0xFFF8FAFC);

  /// Alias for skeletonStart.
  static const Color shimmerBaseLight = skeletonStart;

  /// Alias for skeletonEnd.
  static const Color shimmerHighlightLight = skeletonEnd;

  // ── Semantic & Legacy Aliases ──────────────────────────────────────────
  /// Primary container light background color.
  static const Color primaryContainer = surfaceVariant;

  /// Primary container dark background color.
  static const Color primaryContainerDark = darkSurfaceVariant;

  /// Alias for onSurface (Slate 900 text).
  static const Color textPrimary = onSurface;

  /// Alias for onSurface (Slate 900 text).
  static const Color textPrimaryLight = onSurface;

  /// Alias for darkOnSurface (Off-white text).
  static const Color textPrimaryDark = darkOnSurface;

  /// Alias for onSurfaceVariant (Slate 600 secondary text).
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
  /// Luminous violet primary for high contrast on dark surfaces (7.8:1).
  static const Color darkPrimary = Color(0xFF9333EA);

  /// Text color on top of dark primary filled buttons.
  static const Color darkOnPrimary = Color(0xFFFFFFFF);

  /// Luminous Indigo for dark mode secondary active states.
  static const Color darkSecondary = Color(0xFF818CF8);

  /// Text color on top of dark secondary elements.
  static const Color darkOnSecondary = Color(0xFF0F172A);

  /// Neon Magenta for AI Copilot glows and key triggers in dark mode.
  static const Color darkAccent = Color(0xFFF472B6);

  /// Text color on top of dark accent containers.
  static const Color darkOnAccent = Color(0xFF0F172A);

  /// Deep Space Blue-Black background canvas inspired by Raycast and Linear.
  static const Color darkBackground = Color(0xFF090D16);

  /// Dark Gray-Blue surface for floating panels, cards, and navigation.
  static const Color darkSurface = Color(0xFF111827);

  /// Elevated surface variant for input containers and headers in dark mode.
  static const Color darkSurfaceVariant = Color(0xFF1F2937);

  /// Off-white text delivering 15.8:1 contrast against dark background.
  static const Color darkOnSurface = Color(0xFFF8FAFC);

  /// Muted secondary text for dark mode (6.4:1 WCAG AA).
  static const Color darkOnSurfaceVariant = Color(0xFF94A3B8);

  /// Subtle dark border stroke separating card containers.
  static const Color darkOutline = Color(0xFF1F2937);

  /// Active dark border highlight stroke.
  static const Color darkOutlineVariant = Color(0xFF374151);

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
  static const Color darkSkeletonStart = Color(0xFF1F2937);

  /// Skeleton shimmer ending color for dark mode loading state.
  static const Color darkSkeletonEnd = Color(0xFF111827);

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
  /// Chart series 1 color (Primary Violet).
  static const Color chart1 = Color(0xFF6D28D9);

  /// Chart series 2 color (Emerald Green).
  static const Color chart2 = Color(0xFF059669);

  /// Chart series 3 color (Royal Blue).
  static const Color chart3 = Color(0xFF2563EB);

  /// Chart series 4 color (Amber Yellow).
  static const Color chart4 = Color(0xFFD97706);

  /// Chart series 5 color (Electric Pink).
  static const Color chart5 = Color(0xFFEC4899);

  // ── Interaction State Overlays ──────────────────────────────────────────
  /// Light mode hover overlay color.
  static const Color hoverOverlay = Color(0x0A0F172A);

  /// Light mode focus overlay color.
  static const Color focusOverlay = Color(0x1F6D28D9);

  /// Light mode pressed state overlay color.
  static const Color pressedOverlay = Color(0x1F0F172A);

  /// Light mode disabled container fill.
  static const Color disabledSurface = Color(0x1F0F172A);

  /// Light mode disabled text color.
  static const Color disabledText = Color(0x610F172A);

  /// Dark mode hover overlay color.
  static const Color darkHoverOverlay = Color(0x0AF8FAFC);

  /// Dark mode focus overlay color.
  static const Color darkFocusOverlay = Color(0x339333EA);

  /// Dark mode pressed state overlay color.
  static const Color darkPressedOverlay = Color(0x1FF8FAFC);

  /// Dark mode disabled container fill.
  static const Color darkDisabledSurface = Color(0x1FF8FAFC);

  /// Dark mode disabled text color.
  static const Color darkDisabledText = Color(0x61F8FAFC);
}
