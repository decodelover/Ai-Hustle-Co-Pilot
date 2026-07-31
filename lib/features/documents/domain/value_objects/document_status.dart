/// Value Object: Document Status enum.
library;

/// Status lifecycle state for documents.
enum DocumentStatus {
  /// Unfinished draft state.
  draft,

  /// Active published state.
  active,

  /// Archived read-only state.
  archived,

  /// Temporarily in trash.
  trashed,
}
