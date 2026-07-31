/// Domain Entity: ProjectAgent (Phase 3.3 & Amendment 3.3D)
library;

import 'package:flutter/foundation.dart';

/// Supported agent role specialization.
enum AgentRole { coding, research, writing, design, marketing, analysis }

/// Immutable domain model representing a configured AI Agent.
@immutable
final class ProjectAgent {
  /// Creates a [ProjectAgent].
  const ProjectAgent({
    required this.id,
    required this.name,
    required this.role,
    required this.systemInstructions,
    this.avatarUrl,
    this.supportedTools = const [],
    this.supportedFileTypes = const [],
    this.supportedModels = const [],
    this.isExecuting = false,
    this.currentTaskDescription,
  });

  /// Agent ID.
  final String id;

  /// Agent display name (e.g. "Devin Code Agent", "Research Pro").
  final String name;

  /// Role specialization.
  final AgentRole role;

  /// Base system instructions.
  final String systemInstructions;

  /// Avatar image asset or network URL.
  final String? avatarUrl;

  /// Supported tools declared in capability registry.
  final List<String> supportedTools;

  /// Supported file extensions (.dart, .pdf, .json).
  final List<String> supportedFileTypes;

  /// Supported LLM model bindings (gpt-4o, gemini-1.5-pro).
  final List<String> supportedModels;

  /// Whether the agent is currently executing an async task.
  final bool isExecuting;

  /// Active task description if executing.
  final String? currentTaskDescription;

  /// Copies [ProjectAgent] with modified fields.
  ProjectAgent copyWith({bool? isExecuting, String? currentTaskDescription}) {
    return ProjectAgent(
      id: id,
      name: name,
      role: role,
      systemInstructions: systemInstructions,
      avatarUrl: avatarUrl,
      supportedTools: supportedTools,
      supportedFileTypes: supportedFileTypes,
      supportedModels: supportedModels,
      isExecuting: isExecuting ?? this.isExecuting,
      currentTaskDescription:
          currentTaskDescription ?? this.currentTaskDescription,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectAgent &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          role == other.role &&
          systemInstructions == other.systemInstructions &&
          avatarUrl == other.avatarUrl &&
          listEquals(supportedTools, other.supportedTools) &&
          listEquals(supportedFileTypes, other.supportedFileTypes) &&
          listEquals(supportedModels, other.supportedModels) &&
          isExecuting == other.isExecuting &&
          currentTaskDescription == other.currentTaskDescription;

  @override
  int get hashCode => Object.hash(
    id,
    name,
    role,
    systemInstructions,
    avatarUrl,
    Object.hashAll(supportedTools),
    Object.hashAll(supportedFileTypes),
    Object.hashAll(supportedModels),
    isExecuting,
    currentTaskDescription,
  );
}
