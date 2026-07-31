/// Phase 3.3 Projects & Agent Execution Unit & Widget Tests (Amendment 3.3J)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/agent_capability_registry.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/project_health_service.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/project_template_factory.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Phase 3.3 AI Projects Unit Tests', () {
    test('ProjectTemplateFactory initializes template context and starter tasks', () {
      final project = ProjectTemplateFactory.createFromCategory(
        id: 'p_test',
        title: 'Test App',
        description: 'Test Description',
        category: ProjectCategory.mobileApp,
      );

      expect(project.id, equals('p_test'));
      expect(project.category, equals(ProjectCategory.mobileApp));
      expect(project.context, isNotNull);
      expect(project.context!.techStack, contains('Flutter'));
      expect(project.tasks, isNotEmpty);
      expect(project.activeAgents, isNotEmpty);
    });

    test('ProjectHealthService calculates dynamic health scores accurately', () {
      const service = ProjectHealthService();
      final project = ProjectTemplateFactory.createFromCategory(
        id: 'p_health',
        title: 'Health Test App',
        description: 'Testing health score computation',
        category: ProjectCategory.software,
      );

      final initialScore = service.calculateHealthScore(project);
      expect(initialScore, greaterThan(0));
      expect(initialScore, lessThanOrEqualTo(100));
    });

    test('AgentCapabilityRegistry resolves default agent specs correctly', () {
      final codingAgent = AgentCapabilityRegistry.getAgentForRole(AgentRole.coding);
      final researchAgent = AgentCapabilityRegistry.getAgentForRole(AgentRole.research);

      expect(codingAgent.role, equals(AgentRole.coding));
      expect(codingAgent.supportedTools, contains('code_generation'));
      expect(researchAgent.role, equals(AgentRole.research));
      expect(researchAgent.supportedTools, contains('web_search'));
    });
  });
}
