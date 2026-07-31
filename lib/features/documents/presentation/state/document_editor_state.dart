/// Presentation State: DocumentEditorState.
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';
import 'package:flutter/foundation.dart';

/// Full state model for the Document Studio Editor canvas and sidebars.
@immutable
final class DocumentEditorState {
  const DocumentEditorState({
    this.document,
    this.selectedBlockId,
    this.isSlashMenuOpen = false,
    this.isAiPanelOpen = true,
    this.isVersionDrawerOpen = false,
    this.isAutosaving = false,
    this.isGenerating = false,
    this.isStreaming = false,
    this.errorMessage,
    this.versions = const [],
  });

  /// Currently active loaded document entity.
  final Document? document;

  /// Currently focused block ID.
  final String? selectedBlockId;

  /// Whether slash command floating menu is visible.
  final bool isSlashMenuOpen;

  /// Whether AI assistant right panel is visible.
  final bool isAiPanelOpen;

  /// Whether version history timeline drawer is visible.
  final bool isVersionDrawerOpen;

  /// Background autosave in progress.
  final bool isAutosaving;

  /// AI generation running.
  final bool isGenerating;

  /// AI streaming active.
  final bool isStreaming;

  /// User-facing error message.
  final String? errorMessage;

  /// Version history snapshot list.
  final List<DocumentVersion> versions;

  /// Copies state with modified values.
  DocumentEditorState copyWith({
    Document? document,
    String? selectedBlockId,
    bool? isSlashMenuOpen,
    bool? isAiPanelOpen,
    bool? isVersionDrawerOpen,
    bool? isAutosaving,
    bool? isGenerating,
    bool? isStreaming,
    String? errorMessage,
    List<DocumentVersion>? versions,
  }) {
    return DocumentEditorState(
      document: document ?? this.document,
      selectedBlockId: selectedBlockId ?? this.selectedBlockId,
      isSlashMenuOpen: isSlashMenuOpen ?? this.isSlashMenuOpen,
      isAiPanelOpen: isAiPanelOpen ?? this.isAiPanelOpen,
      isVersionDrawerOpen: isVersionDrawerOpen ?? this.isVersionDrawerOpen,
      isAutosaving: isAutosaving ?? this.isAutosaving,
      isGenerating: isGenerating ?? this.isGenerating,
      isStreaming: isStreaming ?? this.isStreaming,
      errorMessage: errorMessage,
      versions: versions ?? this.versions,
    );
  }
}
