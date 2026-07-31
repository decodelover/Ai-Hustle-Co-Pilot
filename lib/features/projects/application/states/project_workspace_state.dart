/// Application State: ProjectWorkspaceState (Amendment 3.3A Unified State)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_activity.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_context.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_file.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_member.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';
import 'package:flutter/foundation.dart';

/// Workspace navigation tabs.
enum WorkspaceTab { dashboard, tasks, agents, files, settings }

/// Realtime connection status.
enum RealtimeConnectionStatus { disconnected, connecting, connected }

/// Immutable state container managing the entire Project Workspace state slice.
@immutable
final class ProjectWorkspaceState {
  /// Creates a [ProjectWorkspaceState].
  const ProjectWorkspaceState({
    this.projects = const [],
    this.activeProject,
    this.selectedTab = WorkspaceTab.dashboard,
    this.activeAgent,
    this.selectedTask,
    this.selectedFile,
    this.projectActivities = const [],
    this.projectMembers = const [],
    this.projectContext,
    this.executionLogs = const [],
    this.isExecutingAgent = false,
    this.realtimeConnectionStatus = RealtimeConnectionStatus.connected,
    this.isLoading = false,
    this.isRefreshing = false,
    this.hasUnsavedChanges = false,
    this.errorMessage,
  });

  /// All available projects.
  final List<Project> projects;

  /// Currently active selected project.
  final Project? activeProject;

  /// Active workspace view tab.
  final WorkspaceTab selectedTab;

  /// Active selected agent.
  final ProjectAgent? activeAgent;

  /// Active selected task.
  final ProjectTask? selectedTask;

  /// Active selected file.
  final ProjectFile? selectedFile;

  /// Project activities timeline.
  final List<ProjectActivity> projectActivities;

  /// Project team members.
  final List<ProjectMember> projectMembers;

  /// Project AI context directives.
  final ProjectContext? projectContext;

  /// Real-time agent execution stream logs.
  final List<String> executionLogs;

  /// Whether an agent task execution stream is active.
  final bool isExecutingAgent;

  /// Realtime connection status.
  final RealtimeConnectionStatus realtimeConnectionStatus;

  /// Loading state flag.
  final bool isLoading;

  /// Refreshing state flag.
  final bool isRefreshing;

  /// Has unsaved form changes flag.
  final bool hasUnsavedChanges;

  /// Optional error message.
  final String? errorMessage;

  /// Copies state with modified fields.
  ProjectWorkspaceState copyWith({
    List<Project>? projects,
    Project? activeProject,
    WorkspaceTab? selectedTab,
    ProjectAgent? activeAgent,
    ProjectTask? selectedTask,
    ProjectFile? selectedFile,
    List<ProjectActivity>? projectActivities,
    List<ProjectMember>? projectMembers,
    ProjectContext? projectContext,
    List<String>? executionLogs,
    bool? isExecutingAgent,
    RealtimeConnectionStatus? realtimeConnectionStatus,
    bool? isLoading,
    bool? isRefreshing,
    bool? hasUnsavedChanges,
    String? errorMessage,
  }) {
    return ProjectWorkspaceState(
      projects: projects ?? this.projects,
      activeProject: activeProject ?? this.activeProject,
      selectedTab: selectedTab ?? this.selectedTab,
      activeAgent: activeAgent ?? this.activeAgent,
      selectedTask: selectedTask ?? this.selectedTask,
      selectedFile: selectedFile ?? this.selectedFile,
      projectActivities: projectActivities ?? this.projectActivities,
      projectMembers: projectMembers ?? this.projectMembers,
      projectContext: projectContext ?? this.projectContext,
      executionLogs: executionLogs ?? this.executionLogs,
      isExecutingAgent: isExecutingAgent ?? this.isExecutingAgent,
      realtimeConnectionStatus: realtimeConnectionStatus ?? this.realtimeConnectionStatus,
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      hasUnsavedChanges: hasUnsavedChanges ?? this.hasUnsavedChanges,
      errorMessage: errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectWorkspaceState &&
          runtimeType == other.runtimeType &&
          listEquals(projects, other.projects) &&
          activeProject == other.activeProject &&
          selectedTab == other.selectedTab &&
          activeAgent == other.activeAgent &&
          selectedTask == other.selectedTask &&
          selectedFile == other.selectedFile &&
          listEquals(projectActivities, other.projectActivities) &&
          listEquals(projectMembers, other.projectMembers) &&
          projectContext == other.projectContext &&
          listEquals(executionLogs, other.executionLogs) &&
          isExecutingAgent == other.isExecutingAgent &&
          realtimeConnectionStatus == other.realtimeConnectionStatus &&
          isLoading == other.isLoading &&
          isRefreshing == other.isRefreshing &&
          hasUnsavedChanges == other.hasUnsavedChanges &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
        Object.hashAll(projects),
        activeProject,
        selectedTab,
        activeAgent,
        selectedTask,
        selectedFile,
        Object.hashAll(projectActivities),
        Object.hashAll(projectMembers),
        projectContext,
        Object.hashAll(executionLogs),
        isExecutingAgent,
        realtimeConnectionStatus,
        isLoading,
        isRefreshing,
        hasUnsavedChanges,
        errorMessage,
      );
}
