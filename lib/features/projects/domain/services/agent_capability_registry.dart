/// Domain Service: AgentCapabilityRegistry (Amendment 3.3D)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';

/// Centralized registry defining tools, file types, and capabilities for AI Agents.
final class AgentCapabilityRegistry {
  /// Resolves default agents for a given role.
  static ProjectAgent getAgentForRole(AgentRole role) {
    return switch (role) {
      AgentRole.coding => const ProjectAgent(
          id: 'agent_coding',
          name: 'Devin Code Architect',
          role: AgentRole.coding,
          systemInstructions: 'You are an elite Flutter & Dart software architect. Write Clean Code following SOLID principles.',
          supportedTools: ['code_generation', 'refactoring', 'flutter_analyze', 'unit_test'],
          supportedFileTypes: ['.dart', '.json', '.yaml', '.md'],
          supportedModels: ['gpt-4o', 'claude-3-5-sonnet', 'gemini-1.5-pro'],
        ),
      AgentRole.research => const ProjectAgent(
          id: 'agent_research',
          name: 'Research & Intelligence Agent',
          role: AgentRole.research,
          systemInstructions: 'You are a senior domain researcher. Analyze knowledge files and synthesize facts.',
          supportedTools: ['web_search', 'pdf_extractor', 'semantic_search'],
          supportedFileTypes: ['.pdf', '.txt', '.docx', '.csv'],
          supportedModels: ['gemini-1.5-pro', 'gpt-4o'],
        ),
      AgentRole.writing => const ProjectAgent(
          id: 'agent_writing',
          name: 'Copywriter & Technical Writer',
          role: AgentRole.writing,
          systemInstructions: 'You craft compelling tech copy, user manuals, and production release notes.',
          supportedTools: ['markdown_generator', 'proofreader'],
          supportedFileTypes: ['.md', '.txt', '.docx'],
          supportedModels: ['gpt-4o-mini', 'gemini-1.5-flash'],
        ),
      AgentRole.design => const ProjectAgent(
          id: 'agent_design',
          name: 'UI/UX Pro Max Specialist',
          role: AgentRole.design,
          systemInstructions: 'You generate design tokens, widget specs, and HIG/Material 3 layouts.',
          supportedTools: ['color_palette_generator', 'wireframe_builder'],
          supportedFileTypes: ['.json', '.svg', '.png'],
          supportedModels: ['gpt-4o', 'claude-3-5-sonnet'],
        ),
      AgentRole.marketing => const ProjectAgent(
          id: 'agent_marketing',
          name: 'Growth & Strategy Agent',
          role: AgentRole.marketing,
          systemInstructions: 'You design SaaS launch strategies, SEO campaigns, and user funnel copy.',
          supportedTools: ['seo_analyzer', 'funnel_builder'],
          supportedFileTypes: ['.md', '.csv'],
          supportedModels: ['gemini-1.5-flash', 'gpt-4o-mini'],
        ),
      AgentRole.analysis => const ProjectAgent(
          id: 'agent_analysis',
          name: 'Data & Metrics Analyst',
          role: AgentRole.analysis,
          systemInstructions: 'You parse metrics, CSV logs, and compute project health analytics.',
          supportedTools: ['chart_renderer', 'csv_parser'],
          supportedFileTypes: ['.csv', '.json'],
          supportedModels: ['gemini-1.5-pro', 'gpt-4o'],
        ),
    };
  }
}
