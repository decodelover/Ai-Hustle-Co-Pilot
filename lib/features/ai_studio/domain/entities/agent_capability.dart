/// Domain Entity: AgentCapability
library;

/// Represents a specific capability skill of an AI agent.
final class AgentCapability {
  /// Creates an [AgentCapability].
  const AgentCapability({
    required this.id,
    required this.name,
    required this.description,
  });

  /// Capability ID.
  final String id;

  /// Display name of capability.
  final String name;

  /// Description of capability.
  final String description;
}
