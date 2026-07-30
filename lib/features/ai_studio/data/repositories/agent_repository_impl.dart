/// Concrete Implementation of [AgentRepository] (Amendment 3.1N)
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/datasources/ai_studio_local_data_source.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/agent.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/agent_repository.dart';

/// Repository implementation delivering AI Agent instances.
final class AgentRepositoryImpl implements AgentRepository {
  /// Constructs [AgentRepositoryImpl].
  AgentRepositoryImpl({required this.localDataSource});

  /// Injected local data source.
  final AiStudioLocalDataSource localDataSource;

  @override
  Future<List<Agent>> getAgents() async {
    return localDataSource.getAgents();
  }

  @override
  Future<Agent?> getAgentById(String id) async {
    final agents = localDataSource.getAgents();
    try {
      return agents.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}
