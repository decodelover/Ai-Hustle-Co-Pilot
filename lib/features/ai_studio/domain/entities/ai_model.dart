/// Domain Entity: AiModel
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/model_provider.dart';

/// Immutable domain entity representing an available AI language model.
final class AiModel {
  /// Creates an [AiModel].
  const AiModel({
    required this.id,
    required this.name,
    required this.provider,
    required this.description,
    required this.contextWindowTokens,
    required this.maxOutputTokens,
    this.isDefault = false,
    this.isBeta = false,
    this.supportsVision = false,
    this.supportsStreaming = true,
  });

  /// Unique model identifier (e.g. 'gpt-4o', 'gemini-1.5-pro').
  final String id;

  /// Display name of the model.
  final String name;

  /// Upstream LLM provider.
  final ModelProvider provider;

  /// Short description of capabilities.
  final String description;

  /// Maximum context window size in tokens (e.g. 128,000).
  final int contextWindowTokens;

  /// Maximum single-response token limit (e.g. 4,096).
  final int maxOutputTokens;

  /// Whether this is the default selected model.
  final bool isDefault;

  /// Whether this model is in beta preview.
  final bool isBeta;

  /// Whether this model supports image/vision attachments.
  final bool supportsVision;

  /// Whether this model supports token streaming responses.
  final bool supportsStreaming;

  /// Formatted context window label (e.g. '128k tokens').
  String get contextWindowLabel {
    if (contextWindowTokens >= 1000000) {
      return '${(contextWindowTokens / 1000000).toStringAsFixed(0)}M tokens';
    }
    return '${(contextWindowTokens / 1000).toStringAsFixed(0)}k tokens';
  }
}
