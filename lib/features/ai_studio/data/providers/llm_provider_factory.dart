/// LLM Provider Factory (Amendment 3.2A)
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/anthropic_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/gemini_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/local_llm_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/openai_provider_service.dart';

/// Factory class mapping model IDs to appropriate LLM Provider implementations with failover support.
final class LlmProviderFactory {
  /// Resolves the provider service for a given model ID.
  static AiProviderService getProviderForModel(String modelId, {String? apiKey}) {
    final lower = modelId.toLowerCase();
    if (lower.contains('openai') || lower.contains('gpt')) {
      return OpenAiProviderService(apiKey: apiKey);
    } else if (lower.contains('claude') || lower.contains('anthropic')) {
      return AnthropicProviderService(apiKey: apiKey);
    } else if (lower.contains('local') || lower.contains('llama')) {
      return const LocalLlmProviderService();
    }
    // Default to Google Gemini AI
    return GeminiProviderService(apiKey: apiKey);
  }
}
