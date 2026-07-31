/// Domain Failures: Project Failures (Phase 3.3)
library;

import 'package:flutter/foundation.dart';

/// Sealed base class for project domain failures.
@immutable
sealed class ProjectFailure implements Exception {
  const ProjectFailure(this.message);

  final String message;

  @override
  String toString() => 'ProjectFailure: $message';
}

/// Project not found failure.
final class ProjectNotFoundFailure extends ProjectFailure {
  const ProjectNotFoundFailure([
    super.message = 'Requested project was not found.',
  ]);
}

/// Agent execution failure.
final class AgentExecutionFailure extends ProjectFailure {
  const AgentExecutionFailure([super.message = 'AI Agent execution failed.']);
}

/// Task creation or state failure.
final class TaskOperationFailure extends ProjectFailure {
  const TaskOperationFailure([
    super.message = 'Failed to process task operation.',
  ]);
}

/// Knowledge file operation failure.
final class ProjectFileFailure extends ProjectFailure {
  const ProjectFileFailure([
    super.message = 'Knowledge file operation failed.',
  ]);
}
