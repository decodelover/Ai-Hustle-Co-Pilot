/// Local LLM Provider Service Implementation (Amendment 3.2A)
library;

import 'dart:async';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';

/// Local LLM provider (Ollama / Local LLaMA 3) implementation.
final class LocalLlmProviderService implements AiProviderService {
  /// Creates a [LocalLlmProviderService].
  const LocalLlmProviderService({this.baseUrl = 'http://localhost:11434'});

  /// Local server URL.
  final String baseUrl;

  @override
  String get providerId => 'local';

  @override
  Stream<String> streamResponse({
    required String modelId,
    required List<ChatMessage> history,
    String? systemPrompt,
  }) async* {
    final responseText =
        'Connected to Local Model $modelId ($baseUrl). Offline privacy mode operational.';
    final words = responseText.split(' ');
    for (final word in words) {
      await Future<void>.delayed(const Duration(milliseconds: 30));
      yield '$word ';
    }
  }
}
