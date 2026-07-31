/// Presentation Widget: ProjectNavigationSidebar (Phase 3.3 Left Panel)
library;

import 'package:ai_hustle_copilot/features/projects/application/providers/project_providers.dart';
import 'package:ai_hustle_copilot/features/projects/application/states/project_workspace_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Left navigation sidebar widget displaying project tree and workspace tabs.
class ProjectNavigationSidebar extends ConsumerWidget {
  /// Creates a [ProjectNavigationSidebar].
  const ProjectNavigationSidebar({
    required this.onNewProjectPressed,
    super.key,
  });

  /// New project creation trigger.
  final VoidCallback onNewProjectPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workspaceStateAsync = ref.watch(projectWorkspaceControllerProvider);

    return workspaceStateAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
      data: (state) {
        final activeId = state.activeProject?.id;

        return Container(
          width: 260.0,
          color: const Color(0xFFF8FAFC),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header & New Project CTA
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'AI Projects',
                      style: TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 16.0,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    IconButton(
                      onPressed: onNewProjectPressed,
                      icon: const Icon(Icons.add_circle_outline_rounded, color: Color(0xFF0D1B2A)),
                      tooltip: 'New Project',
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Project List Tree
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  itemCount: state.projects.length,
                  itemBuilder: (context, index) {
                    final project = state.projects[index];
                    final isSelected = project.id == activeId;

                    return ListTile(
                      dense: true,
                      selected: isSelected,
                      selectedTileColor: const Color(0xFF0D1B2A).withValues(alpha: 0.08),
                      leading: Icon(
                        Icons.folder_special_rounded,
                        color: isSelected ? const Color(0xFF0D1B2A) : const Color(0xFF6B7280),
                        size: 20,
                      ),
                      title: Text(
                        project.title,
                        style: TextStyle(
                          color: isSelected ? const Color(0xFF0D1B2A) : const Color(0xFF374151),
                          fontSize: 13.5,
                          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          '${project.healthScore}%',
                          style: const TextStyle(
                            color: Color(0xFF10B981),
                            fontSize: 10.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () {
                        ref.read(projectWorkspaceControllerProvider.notifier).selectProject(project.id);
                      },
                    );
                  },
                ),
              ),
              const Divider(height: 1, color: Color(0xFFE5E7EB)),

              // Navigation Workspace Tabs
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: WorkspaceTab.values.map((tab) {
                    final isTabSelected = state.selectedTab == tab;

                    return ListTile(
                      dense: true,
                      selected: isTabSelected,
                      selectedTileColor: const Color(0xFF0D1B2A),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                      leading: Icon(
                        _getTabIcon(tab),
                        color: isTabSelected ? Colors.white : const Color(0xFF6B7280),
                        size: 18,
                      ),
                      title: Text(
                        tab.name.toUpperCase(),
                        style: TextStyle(
                          color: isTabSelected ? Colors.white : const Color(0xFF4B5563),
                          fontSize: 11.5,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.5,
                        ),
                      ),
                      onTap: () {
                        ref.read(projectWorkspaceControllerProvider.notifier).selectTab(tab);
                      },
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  IconData _getTabIcon(WorkspaceTab tab) {
    return switch (tab) {
      WorkspaceTab.dashboard => Icons.space_dashboard_rounded,
      WorkspaceTab.tasks => Icons.task_alt_rounded,
      WorkspaceTab.agents => Icons.smart_toy_rounded,
      WorkspaceTab.files => Icons.folder_open_rounded,
      WorkspaceTab.settings => Icons.tune_rounded,
    };
  }
}
