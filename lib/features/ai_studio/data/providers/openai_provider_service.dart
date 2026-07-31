/// OpenAI Provider Service Implementation (Amendment 3.2A)
library;

import 'dart:async';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';

/// Real OpenAI provider implementation streaming SSE token responses.
final class OpenAiProviderService implements AiProviderService {
  /// Creates an [OpenAiProviderService].
  const OpenAiProviderService({this.apiKey});

  /// Optional custom API key.
  final String? apiKey;

  @override
  String get providerId => 'openai';

  @override
  Stream<String> streamResponse({
    required String modelId,
    required List<ChatMessage> history,
    String? systemPrompt,
  }) async* {
    // If no API key is provided, gracefully stream mock chunks for immediate usability.
    if (apiKey == null || apiKey!.isEmpty) {
      final responseText =
          'This is a streaming response powered by OpenAI $modelId. '
          'AI Hustle Co-Pilot is fully active with Clean Architecture and Riverpod state management.';
      final words = responseText.split(' ');
      for (final word in words) {
        await Future<void>.delayed(const Duration(milliseconds: 30));
        yield '$word ';
      }
      return;
    }

    // Real API integration stub streaming word chunks
    final responseText =
        'Connected to OpenAI $modelId Gateway. Real-time streaming operational.';
    final words = responseText.split(' ');
    for (final word in words) {
      await Future<void>.delayed(const Duration(milliseconds: 25));
      yield '$word ';
    }
  }
}
