/// LLM Provider Factory (Amendment 3.2A)
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/gemini_provider_service.dart';

/// Factory for the production-supported Gemini provider.
final class LlmProviderFactory {
  /// Resolves the provider service for a given model ID.
  static AiProviderService getProviderForModel(
    String modelId, {
    String? apiKey,
  }) {
    final lower = modelId.toLowerCase();
    if (!lower.startsWith('gemini-')) {
      throw UnsupportedError(
        'Model "$modelId" is not enabled. This build supports Gemini models.',
      );
    }
    return GeminiProviderService(apiKey: apiKey);
  }
}
