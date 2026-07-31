/// Domain Entity: ProjectContext (Phase 3.3)
library;

import 'package:flutter/foundation.dart';

/// Immutable domain model encapsulating AI system instructions and constraints for a project.
@immutable
final class ProjectContext {
  /// Creates a [ProjectContext].
  const ProjectContext({
    required this.projectId,
    required this.systemInstructions,
    this.techStack = const [],
    this.keyRules = const [],
    this.targetAudience,
    this.architectureNotes,
  });

  /// Associated project ID.
  final String projectId;

  /// Primary AI system instructions.
  final String systemInstructions;

  /// Technology stack tags (e.g. Flutter, Supabase, Dio).
  final List<String> techStack;

  /// Critical project directives and constraints.
  final List<String> keyRules;

  /// Target audience description.
  final String? targetAudience;

  /// Architectural guidelines summary.
  final String? architectureNotes;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectContext &&
          runtimeType == other.runtimeType &&
          projectId == other.projectId &&
          systemInstructions == other.systemInstructions &&
          listEquals(techStack, other.techStack) &&
          listEquals(keyRules, other.keyRules) &&
          targetAudience == other.targetAudience &&
          architectureNotes == other.architectureNotes;

  @override
  int get hashCode => Object.hash(
    projectId,
    systemInstructions,
    Object.hashAll(techStack),
    Object.hashAll(keyRules),
    targetAudience,
    architectureNotes,
  );
}
