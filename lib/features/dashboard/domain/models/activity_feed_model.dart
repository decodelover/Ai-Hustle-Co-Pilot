/// Domain model for activity timeline items.
library;

import 'package:flutter/material.dart';

/// Enum representing the category of activity event.
enum ActivityCategory {
  aiAction,
  project,
  document,
  automation,
  marketplace,
  authentication,
  system,
}

/// Immutable domain model representing a single activity feed entry.
@immutable
class ActivityFeedModel {
  /// Creates an [ActivityFeedModel].
  const ActivityFeedModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.category,
    required this.icon,
    this.avatarUrl,
    this.statusColor,
    this.targetRoute,
  });

  /// Unique activity item identifier.
  final String id;

  /// Activity title summary.
  final String title;

  /// Detailed description.
  final String description;

  /// Occurrence timestamp.
  final DateTime timestamp;

  /// Event category.
  final ActivityCategory category;

  /// Category or status icon.
  final IconData icon;

  /// Optional actor avatar URL.
  final String? avatarUrl;

  /// Optional indicator color.
  final Color? statusColor;

  /// Optional target route.
  final String? targetRoute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ActivityFeedModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          timestamp == other.timestamp &&
          category == other.category &&
          icon == other.icon &&
          avatarUrl == other.avatarUrl &&
          statusColor == other.statusColor &&
          targetRoute == other.targetRoute;

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    timestamp,
    category,
    icon,
    avatarUrl,
    statusColor,
    targetRoute,
  );
}
