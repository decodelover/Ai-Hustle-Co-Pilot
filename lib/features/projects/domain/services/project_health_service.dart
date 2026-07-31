/// Domain Service: ProjectHealthService (Amendment 3.3B)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';

/// Dynamically calculates project health score (0 to 100).
final class ProjectHealthService {
  /// Creates a [ProjectHealthService].
  const ProjectHealthService();

  /// Calculates dynamic health score from task completion rates, file coverage, and activities.
  int calculateHealthScore(Project project) {
    if (project.tasks.isEmpty) return 100;

    final completed = project.tasks.where((t) => t.status == ProjectTaskStatus.completed).length;
    final failed = project.tasks.where((t) => t.status == ProjectTaskStatus.failed).length;
    final total = project.tasks.length;

    final taskRatio = (completed / total) * 60; // Up to 60 points
    final failurePenalty = failed * 15; // -15 points per failed task
    final fileBonus = project.knowledgeFiles.isNotEmpty ? 20 : 5; // Up to 20 points
    final agentBonus = project.activeAgents.isNotEmpty ? 20 : 10; // Up to 20 points

    final score = (taskRatio + fileBonus + agentBonus - failurePenalty).round();
    return score.clamp(0, 100);
  }
}
