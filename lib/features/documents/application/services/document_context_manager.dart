/// Application Service: DocumentContextManager.
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';

/// Manages context injection from Phase 3.3 Project Workspace into document AI generation calls.
final class DocumentContextManager {
  /// Creates a [DocumentContextManager].
  const DocumentContextManager();

  /// Constructs a comprehensive AI system prompt grounding the generation run in Project context.
  String buildGroundedSystemPrompt({
    required Document document,
    Project? project,
    String? templatePrompt,
    String? userDirectives,
  }) {
    final buffer = StringBuffer()
      ..writeln(
        'YOU ARE AN ENTERPRISE AI WRITING ASSISTANT AND SAAS DOCUMENT ENGINE.',
      )
      ..writeln(
        'Produce output formatted cleanly as semantic Markdown headings (#, ##, ###), lists (- or 1.), callouts (💡), quotes (>), and code snippets (```).',
      )
      ..writeln();

    if (templatePrompt != null && templatePrompt.isNotEmpty) {
      buffer
        ..writeln('TEMPLATE STRUCTURE INSTRUCTIONS:')
        ..writeln(templatePrompt)
        ..writeln();
    }

    if (project != null) {
      buffer
        ..writeln('PROJECT KNOWLEDGE CONTEXT (Phase 3.3):')
        ..writeln('- Project Title: ${project.title}')
        ..writeln('- Category: ${project.category.name}')
        ..writeln('- Description: ${project.description}');

      if (project.context != null) {
        buffer.writeln(
          '- System Instructions: ${project.context!.systemInstructions}',
        );
        if (project.context!.targetAudience != null) {
          buffer.writeln(
            '- Target Audience: ${project.context!.targetAudience}',
          );
        }
        if (project.context!.architectureNotes != null) {
          buffer.writeln(
            '- Architecture Guidelines: ${project.context!.architectureNotes}',
          );
        }
      }

      if (project.knowledgeFiles.isNotEmpty) {
        buffer.writeln(
          '- Active Knowledge Files (${project.knowledgeFiles.length}):',
        );
        for (final file in project.knowledgeFiles.take(5)) {
          buffer.writeln('  * [${file.name}] (${file.extension})');
        }
      }
      buffer.writeln();
    }

    if (userDirectives != null && userDirectives.isNotEmpty) {
      buffer
        ..writeln('USER STYLE & INSTRUCTION DIRECTIVES:')
        ..writeln(userDirectives)
        ..writeln();
    }

    buffer
      ..writeln('DOCUMENT METADATA:')
      ..writeln('- Target Document Title: "${document.title}"')
      ..writeln('- Current Version: v${document.currentVersionNumber}')
      ..writeln('- Total Blocks: ${document.blocks.length}');

    return buffer.toString();
  }
}
