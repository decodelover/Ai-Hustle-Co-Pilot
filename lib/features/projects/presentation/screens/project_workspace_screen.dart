/// Presentation Screen: ProjectWorkspaceScreen (Amendment 3.3H Responsive Workspace)
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_error_state.dart';
import 'package:ai_hustle_copilot/features/projects/application/providers/project_providers.dart';
import 'package:ai_hustle_copilot/features/projects/application/states/project_workspace_state.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/screens/create_project_modal.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/widgets/agent_execution_panel.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/widgets/project_dashboard_tab.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/widgets/project_file_context_tab.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/widgets/project_navigation_sidebar.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/widgets/project_task_board_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Master 3-Panel Responsive Project Workspace Shell of AI Hustle Co-Pilot.
class ProjectWorkspaceScreen extends ConsumerWidget {
  /// Creates a [ProjectWorkspaceScreen].
  const ProjectWorkspaceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceStateAsync = ref.watch(projectWorkspaceControllerProvider);
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 1200;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: workspaceStateAsync.when(
          loading: () => const Center(
            child: CircularProgressIndicator(color: Color(0xFF0D1B2A)),
          ),
          error: (error, stackTrace) => AppErrorState(
            title: 'Failed to load AI Project Workspace',
            message: error.toString(),
            onRetry: () => ref
                .read(projectWorkspaceControllerProvider.notifier)
                .initWorkspace(),
          ),
          data: (state) {
            final active = state.activeProject;

            if (active == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.folder_special_rounded,
                      size: 64,
                      color: Color(0xFF9CA3AF),
                    ),
                    const SizedBox(height: 16.0),
                    const Text(
                      'No AI Projects Available',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 20.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton.icon(
                      onPressed: () => CreateProjectModal.show(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D1B2A),
                        foregroundColor: Colors.white,
                      ),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Create First Project'),
                    ),
                  ],
                ),
              );
            }

            if (!isDesktop) {
              // Mobile / Tablet Segmented Experience
              return Column(
                children: [
                  Expanded(
                    child: _buildCenterTabContent(state.selectedTab, active),
                  ),
                ],
              );
            }

            // Desktop 3-Panel Workspace Layout
            return Row(
              children: [
                // Left Panel: Project Navigation Sidebar (260dp)
                ProjectNavigationSidebar(
                  onNewProjectPressed: () => CreateProjectModal.show(context),
                ),
                const VerticalDivider(width: 1, color: Color(0xFFE5E7EB)),

                // Center Panel: Main Workspace Content (Flex 7)
                Expanded(
                  child: _buildCenterTabContent(state.selectedTab, active),
                ),
                const VerticalDivider(width: 1, color: Color(0xFFE5E7EB)),

                // Right Panel: Agent Execution Stream Monitor (340dp)
                const AgentExecutionPanel(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCenterTabContent(WorkspaceTab tab, Project project) {
    return switch (tab) {
      WorkspaceTab.dashboard => ProjectDashboardTab(project: project),
      WorkspaceTab.tasks => ProjectTaskBoardTab(project: project),
      WorkspaceTab.agents => ProjectDashboardTab(project: project),
      WorkspaceTab.files => ProjectFileContextTab(project: project),
      WorkspaceTab.settings => ProjectDashboardTab(project: project),
    };
  }
}
