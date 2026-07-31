/// Domain Entity: PromptVersion (Amendment 3.2D)
library;

/// Immutable domain entity representing a versioned system prompt.
final class PromptVersion {
  /// Creates a [PromptVersion].
  const PromptVersion({
    required this.id,
    required this.templateId,
    required this.version,
    required this.promptText,
    required this.createdAt,
    this.author = 'System',
    this.variables = const [],
    this.isActive = true,
  });

  /// Unique version identifier.
  final String id;

  /// Parent template identifier.
  final String templateId;

  /// Version number (e.g. 1.0, 1.1).
  final double version;

  /// Raw prompt text with template placeholders (e.g. {{user_name}}).
  final String promptText;

  /// Timestamp of creation.
  final DateTime createdAt;

  /// Author of prompt version.
  final String author;

  /// List of variables in this prompt version.
  final List<String> variables;

  /// Whether this version is currently active.
  final bool isActive;
}
