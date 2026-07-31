/// Domain Entity: Project (Phase 3.3 Master Entity)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project_activity.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_context.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_file.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_member.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';
import 'package:flutter/foundation.dart';

/// Project classification category.
enum ProjectCategory {
  mobileApp,
  website,
  research,
  marketing,
  software,
  content,
}

/// Immutable master domain model representing an AI Project.
@immutable
final class Project {
  /// Creates a [Project].
  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.createdAt,
    required this.updatedAt,
    this.progress = 0.0,
    this.healthScore = 100,
    this.activeAgents = const [],
    this.tasks = const [],
    this.knowledgeFiles = const [],
    this.activities = const [],
    this.members = const [],
    this.context,
  });

  /// Unique project ID.
  final String id;

  /// Project title.
  final String title;

  /// Detailed project description.
  final String description;

  /// Project category.
  final ProjectCategory category;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last updated timestamp.
  final DateTime updatedAt;

  /// Completion progress (0.0 to 1.0).
  final double progress;

  /// Dynamically calculated health score (0 to 100).
  final int healthScore;

  /// Active AI agents assigned.
  final List<ProjectAgent> activeAgents;

  /// Tasks list.
  final List<ProjectTask> tasks;

  /// Knowledge files list.
  final List<ProjectFile> knowledgeFiles;

  /// Activity feed list.
  final List<ProjectActivity> activities;

  /// Project members list.
  final List<ProjectMember> members;

  /// AI Context directives.
  final ProjectContext? context;

  /// Copies [Project] with modified properties.
  Project copyWith({
    String? title,
    String? description,
    double? progress,
    int? healthScore,
    List<ProjectAgent>? activeAgents,
    List<ProjectTask>? tasks,
    List<ProjectFile>? knowledgeFiles,
    List<ProjectActivity>? activities,
    List<ProjectMember>? members,
    ProjectContext? context,
  }) {
    return Project(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
      progress: progress ?? this.progress,
      healthScore: healthScore ?? this.healthScore,
      activeAgents: activeAgents ?? this.activeAgents,
      tasks: tasks ?? this.tasks,
      knowledgeFiles: knowledgeFiles ?? this.knowledgeFiles,
      activities: activities ?? this.activities,
      members: members ?? this.members,
      context: context ?? this.context,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Project &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          category == other.category &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          progress == other.progress &&
          healthScore == other.healthScore &&
          listEquals(activeAgents, other.activeAgents) &&
          listEquals(tasks, other.tasks) &&
          listEquals(knowledgeFiles, other.knowledgeFiles) &&
          listEquals(activities, other.activities) &&
          listEquals(members, other.members) &&
          context == other.context;

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    category,
    createdAt,
    updatedAt,
    progress,
    healthScore,
    Object.hashAll(activeAgents),
    Object.hashAll(tasks),
    Object.hashAll(knowledgeFiles),
    Object.hashAll(activities),
    Object.hashAll(members),
    context,
  );
}
