/// Application Controller: AgentController (Amendment 3.2C)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/agent_task.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/use_cases/execute_agent_task_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod StateNotifier driving AgentTask execution lifecycle.
class AgentController extends StateNotifier<AsyncValue<AgentTask?>> {
  /// Creates an [AgentController].
  AgentController({ExecuteAgentTaskUseCase? executeUseCase})
    : _executeUseCase = executeUseCase ?? ExecuteAgentTaskUseCase(),
      super(const AsyncData(null));

  final ExecuteAgentTaskUseCase _executeUseCase;

  /// Runs an agent task for a goal string.
  Future<void> runTask(String goal) async {
    state = const AsyncLoading();
    try {
      await for (final taskProgress in _executeUseCase.execute(goal)) {
        state = AsyncData(taskProgress);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Resets controller state.
  void clear() {
    state = const AsyncData(null);
  }
}
