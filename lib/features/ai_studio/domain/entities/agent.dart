/// Domain Entity: Agent (Multi-Agent Architecture Abstraction - Amendment 3.1N)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/agent_capability.dart';

/// Abstract domain entity representing a specialized AI Agent.
///
/// Designed to support future multi-agent routing (Coding, Research, Writing,
/// Marketing, Legal, Voice, Image) without architectural refactoring.
final class Agent {
  /// Creates an [Agent].
  const Agent({
    required this.id,
    required this.name,
    required this.roleDescription,
    required this.defaultModelId,
    this.avatarAssetPath,
    this.capabilities = const [],
    this.isAvailable = true,
  });

  /// Unique agent ID.
  final String id;

  /// Agent name (e.g. 'Coding Assistant', 'Research Analyst').
  final String name;

  /// Role description.
  final String roleDescription;

  /// Default model ID for this agent.
  final String defaultModelId;

  /// Optional avatar icon asset.
  final String? avatarAssetPath;

  /// List of capabilities supported by this agent.
  final List<AgentCapability> capabilities;

  /// Whether this agent is currently unlocked and active.
  final bool isAvailable;
}
