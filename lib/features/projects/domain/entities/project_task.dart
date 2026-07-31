/// Domain Entity: ProjectTask (Phase 3.3)
library;

import 'package:flutter/foundation.dart';

/// Execution status of an AI Project task.
enum ProjectTaskStatus { pending, running, completed, failed, cancelled }

/// Immutable domain model representing a task assigned to an AI Agent or user.
@immutable
final class ProjectTask {
  /// Creates a [ProjectTask].
  const ProjectTask({
    required this.id,
    required this.projectId,
    required this.title,
    required this.description,
    required this.createdAt,
    this.status = ProjectTaskStatus.pending,
    this.assignedAgentId,
    this.progress = 0.0,
    this.executionLogs = const [],
    this.completedAt,
  });

  /// Task ID.
  final String id;

  /// Project ID.
  final String projectId;

  /// Task title.
  final String title;

  /// Detailed requirement description.
  final String description;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Execution status.
  final ProjectTaskStatus status;

  /// Assigned agent ID.
  final String? assignedAgentId;

  /// Progress fraction (0.0 to 1.0).
  final double progress;

  /// Real-time execution logs.
  final List<String> executionLogs;

  /// Completion timestamp.
  final DateTime? completedAt;

  /// Copies [ProjectTask] with updated fields.
  ProjectTask copyWith({
    ProjectTaskStatus? status,
    double? progress,
    List<String>? executionLogs,
    DateTime? completedAt,
  }) {
    return ProjectTask(
      id: id,
      projectId: projectId,
      title: title,
      description: description,
      createdAt: createdAt,
      status: status ?? this.status,
      assignedAgentId: assignedAgentId,
      progress: progress ?? this.progress,
      executionLogs: executionLogs ?? this.executionLogs,
      completedAt: completedAt ?? this.completedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectTask &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          title == other.title &&
          description == other.description &&
          createdAt == other.createdAt &&
          status == other.status &&
          assignedAgentId == other.assignedAgentId &&
          progress == other.progress &&
          listEquals(executionLogs, other.executionLogs) &&
          completedAt == other.completedAt;

  @override
  int get hashCode => Object.hash(
    id,
    projectId,
    title,
    description,
    createdAt,
    status,
    assignedAgentId,
    progress,
    Object.hashAll(executionLogs),
    completedAt,
  );
}
