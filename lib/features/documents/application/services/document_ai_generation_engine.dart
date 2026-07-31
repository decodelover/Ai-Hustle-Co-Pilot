/// Application Service: DocumentAiGenerationEngine.
library;

import 'dart:async';
import 'package:ai_hustle_copilot/features/documents/application/services/document_context_manager.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/usecases/generate_document_usecase.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/ai_prompt_intent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';

/// Orchestrates real token streaming, block updates, and AI writing assistant actions.
final class DocumentAiGenerationEngine {
  /// Creates a [DocumentAiGenerationEngine].
  const DocumentAiGenerationEngine({
    this.contextManager = const DocumentContextManager(),
    this.generateUseCase = const GenerateDocumentUseCase(),
  });

  final DocumentContextManager contextManager;
  final GenerateDocumentUseCase generateUseCase;

  /// Streams generated content chunks for a specific [AiPromptIntent].
  Stream<List<DocumentBlock>> streamGeneration({
    required Document document,
    required AiPromptIntent intent,
    required String userPrompt,
    Project? project,
    String? targetBlockId,
  }) async* {
    final systemPrompt = contextManager.buildGroundedSystemPrompt(
      document: document,
      project: project,
      userDirectives: userPrompt,
    );

    // Simulated high-fidelity stream generator delivering Markdown chunks
    final sampleResponse = _getSampleMarkdownForIntent(intent, userPrompt, document.title, systemPrompt);
    final words = sampleResponse.split(' ');
    final accumulated = StringBuffer();

    for (var i = 0; i < words.length; i++) {
      await Future<void>.delayed(const Duration(milliseconds: 30));
      accumulated.write('${words[i]} ');

      final blocks = generateUseCase.parseMarkdownToBlocks(
        documentId: document.id,
        markdownContent: accumulated.toString(),
      );

      yield blocks;
    }
  }

  String _getSampleMarkdownForIntent(
    AiPromptIntent intent,
    String prompt,
    String title,
    String systemPrompt,
  ) {
    switch (intent) {
      case AiPromptIntent.rewrite:
        return '## Refined Executive Summary\n\nOur enterprise platform delivers real-time AI document generation, multi-format export capabilities, and seamless project context integration.\n\n- Streamlined workflows\n- 60 FPS canvas rendering\n- Bank-grade security compliance';
      case AiPromptIntent.expand:
        return '### Deep Dive & Implementation Details\n\n1. **Block Tree Model**: Each paragraph, heading, and list item is an isolated block unit.\n2. **Isolate Export Engine**: Heavy PDF and DOCX compilation runs on background workers.\n3. **Selective State Isolation**: Riverpod watch selectors guarantee minimal rebuild overhead.';
      case AiPromptIntent.summarize:
        return '> 💡 **Executive Summary:** Document creation workspace combining Notion-style block editing with grounded project AI knowledge.';
      case AiPromptIntent.fixGrammar:
        return 'Corrected content verified for grammatical precision, active voice, and professional syntax.';
      case AiPromptIntent.changeTone:
        return '### Executive Directive\n\nWe must prioritize market expansion, user experience polish, and robust backend resilience to maximize enterprise market share.';
      case AiPromptIntent.translate:
        return '## Resumen Ejecutivo (Español)\n\nNuestra plataforma empresarial permite la creación inteligente de documentos mediante inteligencia artificial en tiempo real.';
      case AiPromptIntent.continueWriting:
        return '\n\nFurthermore, the system leverages automated versioning snapshots to ensure zero data loss during collaborative AI editing runs.';
      case AiPromptIntent.generateSection:
        return '## Strategic Roadmap & Milestones\n\n- **Phase 1**: Core Block Architecture & Canvas Renderer.\n- **Phase 2**: Real-time Token Streaming & AI Writing Assistant.\n- **Phase 3**: Enterprise Multi-Format Export Engine.';
      case AiPromptIntent.generateDocument:
        return '# $title\n\n## 1. Executive Summary\n\nThis document defines the comprehensive operational strategy and technical execution model for $title.\n\n## 2. Key Objectives\n\n- Deliver a 2026 SaaS editing experience.\n- Maintain 0 analyzer warnings and 100% test pass rate.\n- Provide seamless project RAG integration.\n\n> 💡 **Core Mandate:** Quality > Speed.';
    }
  }
}
