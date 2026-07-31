/// Domain Repository Contract: TaskRepository
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';

/// Contract managing project tasks and execution state updates.
abstract interface class TaskRepository {
  /// Fetches tasks for a specific project.
  Future<List<ProjectTask>> getTasks(String projectId);

  /// Creates a new task.
  Future<ProjectTask> createTask(ProjectTask task);

  /// Updates task execution status.
  Future<void> updateTaskStatus(String taskId, ProjectTaskStatus status);

  /// Cancels a running task.
  Future<void> cancelTask(String taskId);
}
