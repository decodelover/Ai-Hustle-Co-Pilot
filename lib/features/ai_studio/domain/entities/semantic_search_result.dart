/// Domain Entity: SemanticSearchResult (Amendment 3.2J)
library;

/// Immutable domain entity representing a semantic search match.
final class SemanticSearchResult {
  /// Creates a [SemanticSearchResult].
  const SemanticSearchResult({
    required this.id,
    required this.entityType,
    required this.title,
    required this.snippet,
    required this.similarityScore,
    this.route,
  });

  /// Target entity ID.
  final String id;

  /// Entity type ('conversation', 'document', 'memory', 'agent_task').
  final String entityType;

  /// Display title.
  final String title;

  /// Matching text snippet.
  final String snippet;

  /// Cosine similarity score (0.0 to 1.0).
  final double similarityScore;

  /// Optional navigation route.
  final String? route;
}
