/// Domain Repository Contract: AgentRepository (Amendment 3.3C Execution Pipeline)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_context.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';

/// Contract abstracting AI agent capabilities and 11-step execution streaming.
abstract interface class AgentRepository {
  /// Retrieves all registered AI agents.
  Future<List<ProjectAgent>> getAvailableAgents();

  /// Streams agent execution logs and output through the 11-step pipeline.
  Stream<String> executeAgentTask({
    required ProjectAgent agent,
    required ProjectTask task,
    required ProjectContext? context,
  });
}
