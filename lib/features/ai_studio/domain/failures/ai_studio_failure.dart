/// Failure types specific to AI Studio operations.
library;

import 'package:ai_hustle_copilot/core/errors/failures.dart';

/// Base class for all AI Studio domain failures.
abstract base class AiStudioFailure extends Failure {
  /// Creates an [AiStudioFailure].
  const AiStudioFailure(String message, [int? code])
      : super(message: message, code: code);
}

/// Network connectivity loss during streaming or payload dispatch.
final class AiNetworkFailure extends AiStudioFailure {
  /// Creates an [AiNetworkFailure].
  const AiNetworkFailure([
    String message = 'Network connection lost. Please check your internet connection.',
  ]) : super(message, 1001);
}

/// API rate limit exceeded by upstream AI provider.
final class AiRateLimitFailure extends AiStudioFailure {
  /// Creates an [AiRateLimitFailure].
  const AiRateLimitFailure([
    String message = 'Rate limit exceeded. Please wait a moment before sending another prompt.',
  ]) : super(message, 429);
}

/// Token or subscription quota limit reached.
final class AiQuotaExhaustedFailure extends AiStudioFailure {
  /// Creates an [AiQuotaExhaustedFailure].
  const AiQuotaExhaustedFailure([
    String message = 'Monthly token quota exhausted. Upgrade your plan to continue.',
  ]) : super(message, 402);
}

/// Upstream AI provider is temporarily unavailable or returning 503.
final class AiProviderUnavailableFailure extends AiStudioFailure {
  /// Creates an [AiProviderUnavailableFailure].
  const AiProviderUnavailableFailure([
    String message = 'AI Provider service is temporarily unavailable. Please try again shortly.',
  ]) : super(message, 503);
}

/// Stream connection timed out.
final class AiStreamTimeoutFailure extends AiStudioFailure {
  /// Creates an [AiStreamTimeoutFailure].
  const AiStreamTimeoutFailure([
    String message = 'Response generation timed out.',
  ]) : super(message, 408);
}

/// Invalid prompt payload or model context window exceeded.
final class AiInvalidPromptFailure extends AiStudioFailure {
  /// Creates an [AiInvalidPromptFailure].
  const AiInvalidPromptFailure([
    String message = 'Prompt exceeds maximum context length for the selected model.',
  ]) : super(message, 400);
}
