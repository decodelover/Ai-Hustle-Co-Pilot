/// Domain Entity: AgentTask (Amendment 3.2C)
library;

/// Execution phase status of an AgentTask.
enum AgentTaskPhase {
  /// Initial prompt breakdown and sub-goal planning.
  planning,

  /// Tool execution and action generation.
  execution,

  /// Quality check and validation.
  review,

  /// Completed final output delivery.
  delivery,

  /// Encountered execution error.
  failed,
}

/// Immutable domain entity representing an AI Agent Task.
final class AgentTask {
  /// Creates an [AgentTask].
  const AgentTask({
    required this.id,
    required this.goal,
    required this.phase,
    required this.createdAt,
    this.steps = const [],
    this.resultOutput,
    this.errorMessage,
  });

  /// Unique task ID.
  final String id;

  /// Goal statement provided by the user.
  final String goal;

  /// Current execution phase.
  final AgentTaskPhase phase;

  /// Creation timestamp.
  final DateTime createdAt;

  /// List of planning or execution steps.
  final List<String> steps;

  /// Final output string when phase is delivery.
  final String? resultOutput;

  /// Optional error message when phase is failed.
  final String? errorMessage;
}
