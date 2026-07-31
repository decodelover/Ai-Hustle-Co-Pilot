/// Presentation Widget: ProjectDashboardTab (Amendment 3.3F Workspace Dashboard)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';

/// Workspace main center dashboard tab displaying Health Ring, Active Agents, and Task Overview.
class ProjectDashboardTab extends StatelessWidget {
  /// Creates a [ProjectDashboardTab].
  const ProjectDashboardTab({required this.project, super.key});

  /// Active project.
  final Project project;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Title Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: const TextStyle(
                      color: Color(0xFF111827),
                      fontSize: 24.0,
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    project.description,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 14.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14.0,
                  vertical: 6.0,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D1B2A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Text(
                  project.category.name.toUpperCase(),
                  style: const TextStyle(
                    color: Color(0xFF0D1B2A),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24.0),

          // Health Score Ring & Metrics Grid
          Row(
            children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: const Color(0xFFE5E7EB)),
                  ),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 68,
                            height: 68,
                            child: CircularProgressIndicator(
                              value: project.healthScore / 100,
                              strokeWidth: 7,
                              backgroundColor: const Color(0xFFE5E7EB),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Color(0xFF10B981),
                              ),
                            ),
                          ),
                          Text(
                            '${project.healthScore}%',
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 15.0,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 16.0),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PROJECT HEALTH',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 2.0),
                          Text(
                            'Optimal Operation',
                            style: TextStyle(
                              color: Color(0xFF10B981),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                flex: 3,
                child: _buildMetricBox(
                  title: 'ACTIVE AGENTS',
                  value: '${project.activeAgents.length}',
                  icon: Icons.smart_toy_rounded,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                flex: 3,
                child: _buildMetricBox(
                  title: 'TOTAL TASKS',
                  value: '${project.tasks.length}',
                  icon: Icons.task_alt_rounded,
                ),
              ),
            ],
          ),
          const SizedBox(height: 28.0),

          // Active AI Agents Section
          const Text(
            'Assigned AI Agents',
            style: TextStyle(
              color: Color(0xFF111827),
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12.0),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 12.0,
              crossAxisSpacing: 12.0,
              childAspectRatio: 2.2,
            ),
            itemCount: project.activeAgents.length,
            itemBuilder: (context, index) {
              final agent = project.activeAgents[index];
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
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1B2A).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        Icons.smart_toy_rounded,
                        color: Color(0xFF0D1B2A),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            agent.name,
                            style: const TextStyle(
                              color: Color(0xFF111827),
                              fontSize: 13.5,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            agent.role.name.toUpperCase(),
                            style: const TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 10.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
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

  Widget _buildMetricBox({
    required String title,
    required String value,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF6B7280),
                  fontSize: 11.0,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Icon(icon, size: 18, color: const Color(0xFF0D1B2A)),
            ],
          ),
          const SizedBox(height: 8.0),
          Text(
            value,
            style: const TextStyle(
              color: Color(0xFF111827),
              fontSize: 24.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
