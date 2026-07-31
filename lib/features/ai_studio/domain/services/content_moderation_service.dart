/// Domain Service: ContentModerationService (Amendment 3.2F)
library;

/// Moderation scan result.
final class ModerationResult {
  /// Creates a [ModerationResult].
  const ModerationResult({required this.isFlagged, this.reason});

  /// Whether prompt or file content was flagged as unsafe.
  final bool isFlagged;

  /// Reason for moderation flag.
  final String? reason;

  /// Safe default result.
  static const ModerationResult safe = ModerationResult(isFlagged: false);
}

/// Service scanning prompts for adversarial prompt injections, sensitive key leaks, or unsafe content.
final class ContentModerationService {
  /// Scans a prompt string for security violations.
  ModerationResult scanPrompt(String promptText) {
    final lower = promptText.toLowerCase();

    // Check prompt injection patterns
    if (lower.contains('ignore previous instructions') ||
        lower.contains('override system prompt') ||
        lower.contains('you are now in developer mode')) {
      return const ModerationResult(
        isFlagged: true,
        reason: 'Potential prompt injection attempt detected.',
      );
    }

    // Check sensitive data leaks (e.g. sk- OpenAI key patterns or JWT tokens)
    if (RegExp('sk-[a-zA-Z0-9]{32,}').hasMatch(promptText) ||
        RegExp(r'eyJhbGciOi[a-zA-Z0-9._\-]+').hasMatch(promptText)) {
      return const ModerationResult(
        isFlagged: true,
        reason: 'Sensitive API key or credential token detected in prompt.',
      );
    }

    return ModerationResult.safe;
  }
}
