/// Domain Repository Contract: AgentRepository (Amendment 3.1N)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/agent.dart';

/// Abstract repository contract for managing AI agents.
abstract interface class AgentRepository {
  /// Fetches available AI agents.
  Future<List<Agent>> getAgents();

  /// Gets an agent by ID.
  Future<Agent?> getAgentById(String id);
}
