/// Repository Implementation: TaskRepositoryImpl
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';
import 'package:ai_hustle_copilot/features/projects/domain/repositories/task_repository.dart';

/// Concrete implementation of [TaskRepository].
final class TaskRepositoryImpl implements TaskRepository {
  final Map<String, List<ProjectTask>> _tasks = {};

  @override
  Future<List<ProjectTask>> getTasks(String projectId) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return _tasks[projectId] ?? [];
  }

  @override
  Future<ProjectTask> createTask(ProjectTask task) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    _tasks.putIfAbsent(task.projectId, () => <ProjectTask>[]).add(task);
    return task;
  }

  @override
  Future<void> updateTaskStatus(String taskId, ProjectTaskStatus status) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    for (final key in _tasks.keys) {
      final list = _tasks[key]!;
      for (var i = 0; i < list.length; i++) {
        if (list[i].id == taskId) {
          list[i] = list[i].copyWith(
            status: status,
            completedAt: status == ProjectTaskStatus.completed ? DateTime.now() : null,
          );
          return;
        }
      }
    }
  }

  @override
  Future<void> cancelTask(String taskId) async {
    await updateTaskStatus(taskId, ProjectTaskStatus.cancelled);
  }
}
