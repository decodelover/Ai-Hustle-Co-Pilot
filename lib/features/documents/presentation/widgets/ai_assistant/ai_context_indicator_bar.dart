/// AI Assistant Widget: AiContextIndicatorBar.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';

/// Context bar showing Phase 3.3 project RAG binding and active knowledge files.
class AiContextIndicatorBar extends StatelessWidget {
  /// Creates an [AiContextIndicatorBar].
  const AiContextIndicatorBar({this.project, super.key});

  final Project? project;

  @override
  Widget build(BuildContext context) {
    if (project == null) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Row(
          children: [
            Icon(Icons.link_off, size: 14, color: AppColors.onSurfaceVariant),
            SizedBox(width: 8),
            Expanded(
              child: Text(
                'Standalone Document (No Project Context)',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.folder, size: 14, color: AppColors.secondary),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Bound to Project: ${project!.title}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Includes ${project!.knowledgeFiles.length} Knowledge Files & ${project!.activeAgents.length} Agents',
            style: const TextStyle(
              fontSize: 11,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
