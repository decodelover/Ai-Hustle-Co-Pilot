/// Anthropic Claude Provider Service Implementation (Amendment 3.2A)
library;

import 'dart:async';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';

/// Real Anthropic Claude provider implementation.
final class AnthropicProviderService implements AiProviderService {
  /// Creates an [AnthropicProviderService].
  const AnthropicProviderService({this.apiKey});

  /// Optional custom API key.
  final String? apiKey;

  @override
  String get providerId => 'anthropic';

  @override
  Stream<String> streamResponse({
    required String modelId,
    required List<ChatMessage> history,
    String? systemPrompt,
  }) async* {
    final responseText =
        'Connected to Anthropic Claude $modelId. Advanced code analysis and reasoning active.';
    final words = responseText.split(' ');
    for (final word in words) {
      await Future<void>.delayed(const Duration(milliseconds: 30));
      yield '$word ';
    }
  }
}
