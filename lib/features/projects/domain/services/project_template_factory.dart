/// Domain Service: ProjectTemplateFactory (Amendment 3.3G)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_context.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/agent_capability_registry.dart';

/// Factory building starter project templates pre-populated with context, tasks, and agents.
final class ProjectTemplateFactory {
  /// Builds a [Project] pre-loaded with template presets.
  static Project createFromCategory({
    required String id,
    required String title,
    required String description,
    required ProjectCategory category,
  }) {
    final now = DateTime.now();

    final (context, starterTasks, defaultRoles) = switch (category) {
      ProjectCategory.mobileApp => (
          ProjectContext(
            projectId: id,
            systemInstructions: 'Build a production Flutter app following Feature-First Clean Architecture and SOLID principles.',
            techStack: const ['Flutter', 'Riverpod', 'GoRouter', 'Supabase'],
            keyRules: const ['Zero compile errors', 'Const constructors everywhere', '4-State UI lifecycle'],
          ),
          [
            ProjectTask(
              id: 'task_1',
              projectId: id,
              title: 'Design Clean Architecture Folder Tree',
              description: 'Establish domain, data, application, presentation modules.',
              createdAt: now,
            ),
            ProjectTask(
              id: 'task_2',
              projectId: id,
              title: 'Implement Riverpod Controllers & Auth Guards',
              description: 'Configure GoRouter redirects and session persistence.',
              createdAt: now,
            ),
          ],
          [AgentRole.coding, AgentRole.design, AgentRole.analysis],
        ),
      ProjectCategory.website => (
          ProjectContext(
            projectId: id,
            systemInstructions: 'Create a responsive web product landing page with high-contrast SaaS design.',
            techStack: const ['HTML5', 'Vanilla CSS', 'JavaScript'],
            keyRules: const ['WCAG AA Contrast', 'Under 2s load time', 'Vibrant glassmorphism aesthetics'],
          ),
          [
            ProjectTask(
              id: 'task_1',
              projectId: id,
              title: 'Draft Hero Section & Topographic Header',
              description: 'Build animated navbar and call-to-action layout.',
              createdAt: now,
            ),
          ],
          [AgentRole.writing, AgentRole.design, AgentRole.marketing],
        ),
      _ => (
          ProjectContext(
            projectId: id,
            systemInstructions: 'General AI productivity project context.',
            techStack: const ['AI Hustle Engine'],
          ),
          [
            ProjectTask(
              id: 'task_1',
              projectId: id,
              title: 'Initial Requirements Analysis',
              description: 'Define core deliverables and milestone schedule.',
              createdAt: now,
            ),
          ],
          [AgentRole.research, AgentRole.writing, AgentRole.analysis],
        ),
    };

    final agents = defaultRoles.map(AgentCapabilityRegistry.getAgentForRole).toList();

    return Project(
      id: id,
      title: title,
      description: description,
      category: category,
      createdAt: now,
      updatedAt: now,
      context: context,
      tasks: starterTasks,
      activeAgents: agents,
    );
  }
}
