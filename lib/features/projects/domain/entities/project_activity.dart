/// Domain Entity: ProjectActivity (Amendment 3.3I Unified Timeline)
library;

import 'package:flutter/material.dart';

/// Event type for project activity timeline.
enum ActivityType {
  aiGeneration,
  fileUpload,
  conversation,
  agentExecution,
  taskCompletion,
  projectEdit,
  collaboration,
  system,
}

/// Immutable domain model representing a chronological project activity log entry.
@immutable
final class ProjectActivity {
  /// Creates a [ProjectActivity].
  const ProjectActivity({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    required this.icon,
    this.actorName,
    this.statusColor,
  });

  /// Activity ID.
  final String id;

  /// Associated Project ID.
  final String projectId;

  /// Activity title.
  final String title;

  /// Detailed description.
  final String description;

  /// Event occurrence timestamp.
  final DateTime timestamp;

  /// Event classification type.
  final ActivityType type;

  /// Visual icon indicator.
  final IconData icon;

  /// Actor or agent display name.
  final String? actorName;

  /// Optional accent status color.
  final Color? statusColor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectActivity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          title == other.title &&
          description == other.description &&
          timestamp == other.timestamp &&
          type == other.type &&
          icon == other.icon &&
          actorName == other.actorName &&
          statusColor == other.statusColor;

  @override
  int get hashCode => Object.hash(
        id,
        projectId,
        title,
        description,
        timestamp,
        type,
        icon,
        actorName,
        statusColor,
      );
}
