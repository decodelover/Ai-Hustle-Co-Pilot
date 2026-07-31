/// Centralized Riverpod Providers: Project Workspace (Phase 3.3)
library;

import 'package:ai_hustle_copilot/features/projects/application/controllers/project_workspace_controller.dart';
import 'package:ai_hustle_copilot/features/projects/application/states/project_workspace_state.dart';
import 'package:ai_hustle_copilot/features/projects/data/datasources/project_local_data_source.dart';
import 'package:ai_hustle_copilot/features/projects/data/repositories/agent_repository_impl.dart';
import 'package:ai_hustle_copilot/features/projects/data/repositories/project_repository_impl.dart';
import 'package:ai_hustle_copilot/features/projects/data/repositories/task_repository_impl.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Repository Providers
final projectRepositoryProvider = Provider(
  (ref) => ProjectRepositoryImpl(
    localDataSource: ProjectLocalDataSource(enablePersistence: true),
  ),
);
final agentRepositoryProvider = Provider((ref) => AgentRepositoryImpl());
final taskRepositoryProvider = Provider((ref) => TaskRepositoryImpl());

/// Master Unified Workspace Controller Provider (Amendment 3.3A)
final projectWorkspaceControllerProvider =
    StateNotifierProvider<
      ProjectWorkspaceController,
      AsyncValue<ProjectWorkspaceState>
    >((ref) {
      return ProjectWorkspaceController(
        projectRepository: ref.watch(projectRepositoryProvider),
        agentRepository: ref.watch(agentRepositoryProvider),
        taskRepository: ref.watch(taskRepositoryProvider),
      );
    });

/// Derived Provider: Active Project Slice (prevents unnecessary rebuilds)
final activeProjectProvider = Provider<Project?>((ref) {
  return ref.watch(
    projectWorkspaceControllerProvider.select((asyncState) {
      return asyncState.asData?.value.activeProject;
    }),
  );
});

/// Derived Provider: Selected Workspace Tab Slice
final selectedWorkspaceTabProvider = Provider<WorkspaceTab>((ref) {
  return ref.watch(
    projectWorkspaceControllerProvider.select((asyncState) {
      return asyncState.asData?.value.selectedTab ?? WorkspaceTab.dashboard;
    }),
  );
});
