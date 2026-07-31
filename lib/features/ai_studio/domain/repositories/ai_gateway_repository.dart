/// Domain Repository Contract: AiGatewayRepository (Amendment 3.2A)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';

/// Abstract repository contract for AI Gateway request execution & failover routing.
abstract interface class AiGatewayRepository {
  /// Stream token response through the secure AI Gateway layer.
  Stream<String> streamGatewayPrompt({
    required String conversationId,
    required List<ChatMessage> history,
    required String modelId,
    String? systemPrompt,
  });

  /// Check provider status and health.
  Future<bool> checkProviderHealth(String providerId);
}
