/// Abstract AI Provider Service Contract (Amendment 3.1A)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';

/// Abstract service contract isolating LLM providers from application controllers.
abstract interface class AiProviderService {
  /// Provider name identifier (e.g. 'openai', 'gemini', 'claude', 'mock').
  String get providerId;

  /// Stream tokens for a prompt and message history.
  Stream<String> streamResponse({
    required String modelId,
    required List<ChatMessage> history,
    String? systemPrompt,
  });
}
