/// Domain Repository Contract: AiStudioRepository
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_model.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/prompt_template.dart';

/// Abstract repository contract handling AI model streaming, models, and prompt templates.
abstract interface class AiStudioRepository {
  /// Fetches available AI models.
  Future<List<AiModel>> getAvailableModels();

  /// Fetches available prompt templates.
  Future<List<PromptTemplate>> getPromptTemplates();

  /// Streams token responses from the selected AI model provider.
  Stream<String> streamPromptResponse({
    required String conversationId,
    required List<ChatMessage> history,
    required String modelId,
    String? systemPrompt,
  });
}
