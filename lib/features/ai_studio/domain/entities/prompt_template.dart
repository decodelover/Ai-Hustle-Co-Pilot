/// Domain Entity: PromptTemplate
library;

/// Immutable domain entity representing a reusable prompt template in the library.
final class PromptTemplate {
  /// Creates a [PromptTemplate].
  const PromptTemplate({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.promptText,
    this.variables = const [],
    this.isFavorite = false,
    this.useCount = 0,
  });

  /// Unique prompt template identifier.
  final String id;

  /// Display title of prompt.
  final String title;

  /// Category grouping (e.g. 'Coding', 'Marketing', 'Writing', 'Business').
  final String category;

  /// Short description of what this prompt accomplishes.
  final String description;

  /// The raw prompt template text.
  final String promptText;

  /// Dynamic template variables (e.g. ['language', 'feature']).
  final List<String> variables;

  /// Whether user marked this prompt as a favorite.
  final bool isFavorite;

  /// Total number of times used.
  final int useCount;

  /// Creates a copy with updated properties.
  PromptTemplate copyWith({
    String? id,
    String? title,
    String? category,
    String? description,
    String? promptText,
    List<String>? variables,
    bool? isFavorite,
    int? useCount,
  }) {
    return PromptTemplate(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      description: description ?? this.description,
      promptText: promptText ?? this.promptText,
      variables: variables ?? this.variables,
      isFavorite: isFavorite ?? this.isFavorite,
      useCount: useCount ?? this.useCount,
    );
  }
}
