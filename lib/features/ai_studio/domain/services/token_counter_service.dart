/// Domain Service: TokenCounterService (Amendment 3.2I & Billing)
library;

/// Helper service calculating character/token estimation and cost calculations per model.
final class TokenCounterService {
  /// Estimates token count based on standard ~4 characters per token heuristic.
  static int estimateTokenCount(String text) {
    if (text.isEmpty) return 0;
    return (text.length / 4.0).ceil();
  }

  /// Calculates estimated cost in USD based on input & output token counts and model pricing.
  static double calculateCostUsd({
    required String modelId,
    required int inputTokens,
    required int outputTokens,
  }) {
    var inputRate = 0.0025; // Default per 1k input tokens
    var outputRate = 0.0100; // Default per 1k output tokens

    if (modelId.contains('gpt-4o-mini') || modelId.contains('flash')) {
      inputRate = 0.00015;
      outputRate = 0.0006;
    } else if (modelId.contains('claude-3-5') || modelId.contains('gpt-4o')) {
      inputRate = 0.003;
      outputRate = 0.012;
    }

    final inputCost = (inputTokens / 1000.0) * inputRate;
    final outputCost = (outputTokens / 1000.0) * outputRate;

    return inputCost + outputCost;
  }
}
