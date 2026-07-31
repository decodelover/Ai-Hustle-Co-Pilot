/// AI Gateway Client & Centralized Access Control (Amendment 3.2A)
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/datasources/sse_stream_client.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/llm_provider_factory.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/services/content_moderation_service.dart';

/// Centralized client managing gateway request moderation, provider routing, and stream throttling.
final class AiGatewayClient {
  /// Creates an [AiGatewayClient].
  AiGatewayClient({ContentModerationService? moderationService})
    : _moderationService = moderationService ?? ContentModerationService();

  final ContentModerationService _moderationService;

  /// Stream prompt response through gateway validation & throttled SSE client.
  Stream<String> streamPrompt({
    required String modelId,
    required List<ChatMessage> history,
    String? systemPrompt,
    String? apiKey,
  }) {
    // 1. Run Content Moderation & Security Checks
    if (history.isNotEmpty) {
      final lastPrompt = history.last.content;
      final modResult = _moderationService.scanPrompt(lastPrompt);
      if (modResult.isFlagged) {
        return Stream.error(
          Exception('Content Security Warning: ${modResult.reason}'),
        );
      }
    }

    // 2. Resolve Provider Instance via Factory
    final provider = LlmProviderFactory.getProviderForModel(
      modelId,
      apiKey: apiKey,
    );

    // 3. Obtain raw token stream
    final rawStream = provider.streamResponse(
      modelId: modelId,
      history: history,
      systemPrompt: systemPrompt,
    );

    // 4. Apply 16ms Frame-Budget Throttling for 60 FPS UI performance
    return SseStreamClient.frameThrottle(rawStream);
  }
}
