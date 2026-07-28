/// Data-driven navigation item model for AI Hustle Co-Pilot enterprise shell.
library;

import 'package:flutter/material.dart';

/// Immutable model representing a single data-driven navigation item.
@immutable
class ShellNavigationItem {
  /// Creates a [ShellNavigationItem].
  const ShellNavigationItem({
    required this.id,
    required this.icon,
    required this.selectedIcon,
    required this.title,
    required this.tooltip,
    required this.route,
    required this.analyticsIdentifier,
    this.permissions = const [],
    this.badgeCount,
    this.isPrimaryTab = false,
    this.isPinnedShortcut = false,
  });

  /// Unique identifier (e.g., 'dashboard', 'ai_workspace').
  final String id;

  /// Unselected icon token.
  final IconData icon;

  /// Active selected icon token.
  final IconData selectedIcon;

  /// Display title.
  final String title;

  /// Accessibility tooltip text.
  final String tooltip;

  /// Target route path string.
  final String route;

  /// Unique analytics tracking tag.
  final String analyticsIdentifier;

  /// Required permissions list for feature access.
  final List<String> permissions;

  /// Optional dynamic notification/alert badge count.
  final int? badgeCount;

  /// Primary tab flag for phone bottom navigation bar.
  final bool isPrimaryTab;

  /// Pinned shortcut flag for desktop sidebar section.
  final bool isPinnedShortcut;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShellNavigationItem &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
