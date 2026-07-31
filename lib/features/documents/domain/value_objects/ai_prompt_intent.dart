/// Value Object: AI Writing Assistant Action Intent enum.
library;

/// Categorises inline and document-wide AI actions.
enum AiPromptIntent {
  /// Rewrite selected block(s) for clarity.
  rewrite,

  /// Expand content with detailed sub-points.
  expand,

  /// Condense and summarize content.
  summarize,

  /// Correct grammar and spelling typos.
  fixGrammar,

  /// Adjust tone (Professional, Executive, Friendly, etc.).
  changeTone,

  /// Translate block to another target language.
  translate,

  /// Predictively continue writing next paragraph.
  continueWriting,

  /// Generate new outline or section content.
  generateSection,

  /// Generate a complete document from prompt.
  generateDocument,
}

/// Extension methods for [AiPromptIntent].
extension AiPromptIntentX on AiPromptIntent {
  /// Human-readable label for UI buttons and chips.
  String get label => switch (this) {
    AiPromptIntent.rewrite => 'Rewrite',
    AiPromptIntent.expand => 'Expand',
    AiPromptIntent.summarize => 'Summarize',
    AiPromptIntent.fixGrammar => 'Fix Grammar',
    AiPromptIntent.changeTone => 'Change Tone',
    AiPromptIntent.translate => 'Translate',
    AiPromptIntent.continueWriting => 'Continue Writing',
    AiPromptIntent.generateSection => 'Generate Section',
    AiPromptIntent.generateDocument => 'Generate Document',
  };
}
