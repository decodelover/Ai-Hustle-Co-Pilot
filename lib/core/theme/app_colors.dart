/// Enterprise Master Design System V2.0 color palette definitions for AI Hustle Co-Pilot.
library;

import 'package:flutter/material.dart';

/// Centralized immutable color constants adhering strictly to Design System V2.0.
abstract class AppColors {
  // ── Primary Dark Blue & Brand Colors ──────────────────────────────────
  /// Primary Dark Blue brand color (#0D1B2A) used for headers, dark surfaces, and primary CTAs.
  static const Color primaryDarkBlue = Color(0xFF0D1B2A);

  /// Primary Blue secondary brand color (#152A4D).
  static const Color primaryBlue = Color(0xFF152A4D);

  /// Primary action color (#0D1B2A).
  static const Color primary = Color(0xFF0D1B2A);

  /// High-contrast text/icon color on top of primary filled elements.
  static const Color onPrimary = Color(0xFFFFFFFF);

  /// Indigo/Blue accent (#3A5FA0) for active highlights and secondary triggers.
  static const Color secondary = Color(0xFF3A5FA0);

  /// Contrast text for secondary interactive surfaces.
  static const Color onSecondary = Color(0xFFFFFFFF);

  /// Accent Blue (#3A5FA0).
  static const Color accent = Color(0xFF3A5FA0);

  /// Accent Coral (#FF6B6B) for high-energy CTA highlights and notifications.
  static const Color accentCoral = Color(0xFFFF6B6B);

  /// Contrast text over accent elements.
  static const Color onAccent = Color(0xFFFFFFFF);

  // ── Light Theme Palette ────────────────────────────────────────────────
  /// Clean, crisp white background canvas (#FFFFFF).
  static const Color background = Color(0xFFFFFFFF);

  /// Pure white surface color for cards, panels, and container dialogs (#FFFFFF).
  static const Color surface = Color(0xFFFFFFFF);

  /// Soft Light Gray container fill for form inputs, table headers, and nested cards (#F8FAFC).
  static const Color surfaceVariant = Color(0xFFF8FAFC);

  /// Deep charcoal text color delivering 18.5:1 WCAG AAA text contrast (#111827).
  static const Color onSurface = Color(0xFF111827);

  /// Muted secondary text, subheadings, and field labels (#6B7280).
  static const Color onSurfaceVariant = Color(0xFF6B7280);

  /// Light border stroke for card bounds and input fields (#E5E7EB).
  static const Color outline = Color(0xFFE5E7EB);

  /// Active focus and hover border stroke state (#CBD5E1).
  static const Color outlineVariant = Color(0xFFCBD5E1);

  /// Emerald green for completed workflows and active syncs (#10B981).
  static const Color success = Color(0xFF10B981);

  /// Contrast text over success containers.
  static const Color onSuccess = Color(0xFFFFFFFF);

  /// Amber warning for pending approvals and quota limits (#F59E0B).
  static const Color warning = Color(0xFFF59E0B);

  /// Contrast text over warning containers.
  static const Color onWarning = Color(0xFFFFFFFF);

  /// Ruby red for destructive actions, validation errors, and auth failures (#EF4444).
  static const Color danger = Color(0xFFEF4444);

  /// Alias for danger color.
  static const Color error = danger;

  /// Contrast text over danger containers.
  static const Color onDanger = Color(0xFFFFFFFF);

  /// Royal blue for neutral system notifications (#3A5FA0).
  static const Color info = Color(0xFF3A5FA0);

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

  /// Alias for onSurface (#111827 text).
  static const Color textPrimary = onSurface;

  /// Alias for onSurface (#111827 text).
  static const Color textPrimaryLight = onSurface;

  /// Alias for darkOnSurface (Off-white text).
  static const Color textPrimaryDark = darkOnSurface;

  /// Alias for onSurfaceVariant (#6B7280 secondary text).
  static const Color textSecondary = onSurfaceVariant;

  /// Alias for onSurfaceVariant.
  static const Color textSecondaryLight = onSurfaceVariant;

  /// Alias for darkOnSurfaceVariant.
  static const Color textSecondaryDark = darkOnSurfaceVariant;

  /// Alias for outline (card border #E5E7EB).
  static const Color border = outline;

  /// Alias for outline (divider line #E5E7EB).
  static const Color divider = outline;

  /// Alias for surface (card background #FFFFFF).
  static const Color card = surface;

  // ── Dark Theme Palette ─────────────────────────────────────────────────
  /// Luminous blue primary for high contrast on dark surfaces (#3A5FA0).
  static const Color darkPrimary = Color(0xFF3A5FA0);

  /// Text color on top of dark primary filled buttons.
  static const Color darkOnPrimary = Color(0xFFFFFFFF);

  /// Secondary active states in dark mode.
  static const Color darkSecondary = Color(0xFF60A5FA);

  /// Text color on top of dark secondary elements.
  static const Color darkOnSecondary = Color(0xFF0F172A);

  /// Accent glows in dark mode.
  static const Color darkAccent = Color(0xFFFF6B6B);

  /// Text color on top of dark accent containers.
  static const Color darkOnAccent = Color(0xFFFFFFFF);

  /// Primary Dark Blue background canvas (#0D1B2A).
  static const Color darkBackground = Color(0xFF0D1B2A);

  /// Dark surface for panels, cards, and navigation (#152A4D).
  static const Color darkSurface = Color(0xFF152A4D);

  /// Elevated surface variant for inputs in dark mode (#1E3A5F).
  static const Color darkSurfaceVariant = Color(0xFF1E3A5F);

  /// Off-white text delivering high contrast against dark background.
  static const Color darkOnSurface = Color(0xFFF8FAFC);

  /// Muted secondary text for dark mode.
  static const Color darkOnSurfaceVariant = Color(0xFF94A3B8);

  /// Subtle dark border stroke separating card containers.
  static const Color darkOutline = Color(0xFF1E3A5F);

  /// Active dark border highlight stroke.
  static const Color darkOutlineVariant = Color(0xFF2E4A7F);

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
  static const Color darkSkeletonStart = Color(0xFF1E3A5F);

  /// Skeleton shimmer ending color for dark mode loading state.
  static const Color darkSkeletonEnd = Color(0xFF152A4D);

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
  /// Chart series 1 color (Primary Dark Blue).
  static const Color chart1 = Color(0xFF0D1B2A);

  /// Chart series 2 color (Emerald Green).
  static const Color chart2 = Color(0xFF10B981);

  /// Chart series 3 color (Accent Coral).
  static const Color chart3 = Color(0xFFFF6B6B);

  /// Chart series 4 color (Amber Yellow).
  static const Color chart4 = Color(0xFFF59E0B);

  /// Chart series 5 color (Accent Blue).
  static const Color chart5 = Color(0xFF3A5FA0);

  // ── Interaction State Overlays ──────────────────────────────────────────
  /// Light mode hover overlay color.
  static const Color hoverOverlay = Color(0x0A111827);

  /// Light mode focus overlay color.
  static const Color focusOverlay = Color(0x1F0D1B2A);

  /// Light mode pressed state overlay color.
  static const Color pressedOverlay = Color(0x1F111827);

  /// Light mode disabled container fill.
  static const Color disabledSurface = Color(0x1F111827);

  /// Light mode disabled text color.
  static const Color disabledText = Color(0x61111827);

  /// Dark mode hover overlay color.
  static const Color darkHoverOverlay = Color(0x0AF8FAFC);

  /// Dark mode focus overlay color.
  static const Color darkFocusOverlay = Color(0x333A5FA0);

  /// Dark mode pressed state overlay color.
  static const Color darkPressedOverlay = Color(0x1FF8FAFC);

  /// Dark mode disabled container fill.
  static const Color darkDisabledSurface = Color(0x1FF8FAFC);

  /// Dark mode disabled text color.
  static const Color darkDisabledText = Color(0x61F8FAFC);
}
