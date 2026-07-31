/// Domain Failure: GatewayFailure (Amendment 3.2A)
library;

import 'package:ai_hustle_copilot/core/errors/failures.dart';

/// Base class for AI Gateway errors.
abstract base class GatewayFailure extends Failure {
  /// Creates a [GatewayFailure].
  const GatewayFailure({required super.message, super.code});
}

/// Rate limit quota exceeded (HTTP 429).
final class RateLimitExceededFailure extends GatewayFailure {
  /// Creates a [RateLimitExceededFailure].
  const RateLimitExceededFailure({
    super.message = 'AI rate limit exceeded. Please wait a moment.',
    super.code = 429,
  });
}

/// Insufficient AI wallet credits.
final class InsufficientCreditsFailure extends GatewayFailure {
  /// Creates an [InsufficientCreditsFailure].
  const InsufficientCreditsFailure({
    super.message = 'Insufficient AI credits. Upgrade your plan to continue.',
    super.code = 402,
  });
}

/// Prompt injection or security moderation trigger.
final class ContentSecurityViolationFailure extends GatewayFailure {
  /// Creates a [ContentSecurityViolationFailure].
  const ContentSecurityViolationFailure({
    super.message = 'Request flagged by safety moderation filter.',
    super.code = 403,
  });
}
