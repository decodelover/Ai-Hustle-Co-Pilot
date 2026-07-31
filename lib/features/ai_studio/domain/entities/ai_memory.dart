/// Domain Entity: AiMemory (Amendment 3.2B)
library;

/// Category of AI Memory.
enum MemoryCategory {
  /// User preferences, coding/writing style, workflow choices.
  user,

  /// Project guidelines, stack choices, architectural rules.
  project,

  /// Long-term conversation decisions and takeaways.
  conversation,
}

/// Immutable domain entity representing an AI memory item.
final class AiMemory {
  /// Creates an [AiMemory].
  const AiMemory({
    required this.id,
    required this.category,
    required this.content,
    required this.createdAt,
    this.relevanceWeight = 1.0,
    this.tags = const [],
    this.sourceId,
  });

  /// Unique memory identifier.
  final String id;

  /// Memory category.
  final MemoryCategory category;

  /// Content text of the memory.
  final String content;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Relevance weight multiplier (0.0 to 1.0).
  final double relevanceWeight;

  /// Associated search tags.
  final List<String> tags;

  /// Optional source conversation or document ID.
  final String? sourceId;
}
