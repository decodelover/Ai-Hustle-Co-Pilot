/// Presentation Widget: ProjectTaskBoardTab (Phase 3.3 Task Kanban)
library;

import 'package:ai_hustle_copilot/features/projects/application/providers/project_providers.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Task Kanban board & list widget for executing AI agent tasks.
class ProjectTaskBoardTab extends ConsumerWidget {
  /// Creates a [ProjectTaskBoardTab].
  const ProjectTaskBoardTab({
    required this.project,
    super.key,
  });

  /// Active project.
  final Project project;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      padding: const EdgeInsets.all(24.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'AI Tasks & Execution Flow',
              style: TextStyle(
                color: Color(0xFF111827),
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF0D1B2A),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
              ),
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Add Task'),
            ),
          ],
        ),
        const SizedBox(height: 16.0),

        if (project.tasks.isEmpty)
          const Padding(
            padding: EdgeInsets.all(32.0),
            child: Center(
              child: Text(
                'No tasks created yet.',
                style: TextStyle(color: Color(0xFF6B7280)),
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: project.tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) {
              final task = project.tasks[index];

              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: _getStatusColor(task.status).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _getStatusIcon(task.status),
                        color: _getStatusColor(task.status),
                        size: 18,
                      ),
                    ),
                    const SizedBox(width: 14.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            task.title,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 2.0),
                          Text(
                            task.description,
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12.0),

                    // Run AI Task Trigger
                    ElevatedButton.icon(
                      onPressed: () {
                        if (project.activeAgents.isNotEmpty) {
                          ref.read(projectWorkspaceControllerProvider.notifier).executeTask(
                                task,
                                project.activeAgents.first,
                              );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF10B981),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                      ),
                      icon: const Icon(Icons.play_arrow_rounded, size: 16),
                      label: const Text('Run Task'),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    );
  }

  Color _getStatusColor(ProjectTaskStatus status) {
    return switch (status) {
      ProjectTaskStatus.pending => const Color(0xFF3A5FA0),
      ProjectTaskStatus.running => const Color(0xFFF59E0B),
      ProjectTaskStatus.completed => const Color(0xFF10B981),
      ProjectTaskStatus.failed => const Color(0xFFEF4444),
      ProjectTaskStatus.cancelled => const Color(0xFF6B7280),
    };
  }

  IconData _getStatusIcon(ProjectTaskStatus status) {
    return switch (status) {
      ProjectTaskStatus.pending => Icons.schedule_rounded,
      ProjectTaskStatus.running => Icons.sync_rounded,
      ProjectTaskStatus.completed => Icons.check_circle_rounded,
      ProjectTaskStatus.failed => Icons.error_rounded,
      ProjectTaskStatus.cancelled => Icons.cancel_rounded,
    };
  }
}
