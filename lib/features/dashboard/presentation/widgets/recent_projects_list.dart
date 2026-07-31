/// Active Projects Summary List — Master Design System V2.0.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/recent_project_model.dart';
import 'package:flutter/material.dart';

/// Project progress and status card list for active workspace projects.
class RecentProjectsList extends StatelessWidget {
  /// Creates a [RecentProjectsList].
  const RecentProjectsList({
    required this.projects,
    super.key,
  });

  /// Active project list.
  final List<RecentProjectModel> projects;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Projects',
                style: TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 18.0,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.3,
                ),
              ),
              Text(
                'View All (${projects.length})',
                style: const TextStyle(
                  color: Color(0xFF3A5FA0),
                  fontSize: 13.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: projects.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12.0),
            itemBuilder: (context, index) {
              final project = projects[index];

              return Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(16.0),
                  border: Border.all(color: const Color(0xFFE5E7EB)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            project.title,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8.0,
                            vertical: 3.0,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Text(
                            '${project.aiUsageScore}% AI Score',
                            style: const TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      project.clientName,
                      style: const TextStyle(
                        color: Color(0xFF6B7280),
                        fontSize: 12.5,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 12.0),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(4.0),
                      child: LinearProgressIndicator(
                        value: project.progress,
                        minHeight: 6.0,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          Color(0xFF0D1B2A),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
