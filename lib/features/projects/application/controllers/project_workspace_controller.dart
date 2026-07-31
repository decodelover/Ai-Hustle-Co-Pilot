/// Application Controller: ProjectWorkspaceController (Amendment 3.3A)
library;

import 'dart:async';
import 'package:ai_hustle_copilot/features/projects/application/states/project_workspace_state.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';
import 'package:ai_hustle_copilot/features/projects/domain/repositories/agent_repository.dart';
import 'package:ai_hustle_copilot/features/projects/domain/repositories/project_repository.dart';
import 'package:ai_hustle_copilot/features/projects/domain/repositories/task_repository.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/project_health_service.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/project_template_factory.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Centralized Riverpod AsyncNotifier orchestrating Phase 3.3 Project Workspace actions.
final class ProjectWorkspaceController
    extends StateNotifier<AsyncValue<ProjectWorkspaceState>> {
  /// Constructs [ProjectWorkspaceController].
  ProjectWorkspaceController({
    required this.projectRepository,
    required this.agentRepository,
    required this.taskRepository,
    this.healthService = const ProjectHealthService(),
  }) : super(const AsyncLoading()) {
    initWorkspace();
  }

  /// Injected project repository.
  final ProjectRepository projectRepository;

  /// Injected agent repository.
  final AgentRepository agentRepository;

  /// Injected task repository.
  final TaskRepository taskRepository;

  /// Injected project health service.
  final ProjectHealthService healthService;

  StreamSubscription<String>? _executionSub;

  /// Initializes workspace data.
  Future<void> initWorkspace() async {
    state = const AsyncLoading();
    try {
      final projects = await projectRepository.getProjects();
      final active = projects.isNotEmpty ? projects.first : null;

      state = AsyncData(
        ProjectWorkspaceState(
          projects: projects,
          activeProject: active,
          projectContext: active?.context,
          projectActivities: active?.activities ?? [],
          projectMembers: active?.members ?? [],
        ),
      );
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Selects active project by ID.
  void selectProject(String projectId) {
    state.whenData((current) {
      final match = current.projects.firstWhere(
        (p) => p.id == projectId,
        orElse: () => current.projects.first,
      );

      final recalculatedHealth = healthService.calculateHealthScore(match);
      final updated = match.copyWith(healthScore: recalculatedHealth);

      state = AsyncData(
        current.copyWith(
          activeProject: updated,
          projectContext: updated.context,
          projectActivities: updated.activities,
          projectMembers: updated.members,
        ),
      );
    });
  }

  /// Changes active workspace navigation tab.
  void selectTab(WorkspaceTab tab) {
    state.whenData((current) {
      state = AsyncData(current.copyWith(selectedTab: tab));
    });
  }

  /// Creates a new project from template.
  Future<void> createProject({
    required String title,
    required String description,
    required ProjectCategory category,
  }) async {
    final newId = 'proj_${DateTime.now().millisecondsSinceEpoch}';
    final project = ProjectTemplateFactory.createFromCategory(
      id: newId,
      title: title,
      description: description,
      category: category,
    );

    await projectRepository.createProject(project);
    await initWorkspace();
    selectProject(newId);
  }

  /// Executes an async AI task stream through the 11-step pipeline.
  Future<void> executeTask(ProjectTask task, ProjectAgent agent) async {
    final currentState = state.value;
    if (currentState == null || currentState.activeProject == null) return;

    final logs = <String>[];
    state = AsyncData(
      currentState.copyWith(
        isExecutingAgent: true,
        activeAgent: agent.copyWith(
          isExecuting: true,
          currentTaskDescription: task.title,
        ),
        executionLogs: logs,
      ),
    );

    await _executionSub?.cancel();
    _executionSub = agentRepository
        .executeAgentTask(
          agent: agent,
          task: task,
          context: currentState.projectContext,
        )
        .listen(
          (logChunk) {
            logs.add(logChunk);
            state = AsyncData(
              currentState.copyWith(
                isExecutingAgent: true,
                executionLogs: List.from(logs),
              ),
            );
          },
          onDone: () {
            state = AsyncData(
              currentState.copyWith(
                isExecutingAgent: false,
                activeAgent: agent.copyWith(isExecuting: false),
              ),
            );
          },
          onError: (Object error) {
            logs.add('\n[ERROR]: Agent execution failed: $error');
            state = AsyncData(
              currentState.copyWith(
                isExecutingAgent: false,
                activeAgent: agent.copyWith(isExecuting: false),
                executionLogs: List.from(logs),
              ),
            );
          },
        );
  }

  @override
  void dispose() {
    _executionSub?.cancel();
    super.dispose();
  }
}
