/// Domain model for reusable quick action buttons.
library;

import 'package:flutter/material.dart';

/// Immutable domain model representing a dashboard Quick Action.
@immutable
class QuickActionModel {
  /// Creates a [QuickActionModel].
  const QuickActionModel({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
    this.badgeCount,
    this.analyticsEvent,
    this.requiredPermission,
    this.isFeatured = false,
  });

  /// Unique quick action identifier.
  final String id;

  /// Display text label.
  final String label;

  /// Leading icon.
  final IconData icon;

  /// Target route path for navigation.
  final String route;

  /// Optional badge counter.
  final int? badgeCount;

  /// Telemetry event name.
  final String? analyticsEvent;

  /// Required permission string if restricted.
  final String? requiredPermission;

  /// Whether to highlight this quick action.
  final bool isFeatured;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuickActionModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          label == other.label &&
          icon == other.icon &&
          route == other.route &&
          badgeCount == other.badgeCount &&
          analyticsEvent == other.analyticsEvent &&
          requiredPermission == other.requiredPermission &&
          isFeatured == other.isFeatured;

  @override
  int get hashCode => Object.hash(
        id,
        label,
        icon,
        route,
        badgeCount,
        analyticsEvent,
        requiredPermission,
        isFeatured,
      );
}
