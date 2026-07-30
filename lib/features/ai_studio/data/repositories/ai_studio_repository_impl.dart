/// Concrete Implementation of [AiStudioRepository]
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/datasources/ai_studio_local_data_source.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/datasources/sse_stream_client.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_model.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/prompt_template.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/ai_studio_repository.dart';

/// Repository implementation providing available models, prompt templates, and streaming tokens.
final class AiStudioRepositoryImpl implements AiStudioRepository {
  /// Constructs [AiStudioRepositoryImpl].
  AiStudioRepositoryImpl({
    required this.localDataSource,
    required this.aiProviderService,
  });

  /// Injected local data source.
  final AiStudioLocalDataSource localDataSource;

  /// Injected AI provider service.
  final AiProviderService aiProviderService;

  @override
  Future<List<AiModel>> getAvailableModels() async {
    return localDataSource.getModels();
  }

  @override
  Future<List<PromptTemplate>> getPromptTemplates() async {
    return localDataSource.getPromptTemplates();
  }

  @override
  Stream<String> streamPromptResponse({
    required String conversationId,
    required List<ChatMessage> history,
    required String modelId,
    String? systemPrompt,
  }) {
    final rawStream = aiProviderService.streamResponse(
      modelId: modelId,
      history: history,
      systemPrompt: systemPrompt,
    );

    // Apply 16ms frame-budget throttling for 60/120 FPS rendering
    return SseStreamClient.frameThrottle(rawStream);
  }
}
