/// Centralized Riverpod Providers: Document Studio (Phase 3.4).
library;

import 'package:ai_hustle_copilot/features/documents/application/controllers/document_editor_controller.dart';
import 'package:ai_hustle_copilot/features/documents/application/services/document_ai_generation_engine.dart';
import 'package:ai_hustle_copilot/features/documents/data/datasources/document_local_datasource.dart';
import 'package:ai_hustle_copilot/features/documents/data/repositories/document_repository_impl.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';
import 'package:ai_hustle_copilot/features/documents/domain/repositories/i_document_repository.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/state/document_editor_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Single instance local data source provider.
final documentLocalDataSourceProvider = Provider<DocumentLocalDataSource>((ref) {
  return DocumentLocalDataSource();
});

/// Document repository provider.
final documentRepositoryProvider = Provider<IDocumentRepository>((ref) {
  return DocumentRepositoryImpl(
    localDataSource: ref.watch(documentLocalDataSourceProvider),
  );
});

/// Document AI Generation Engine provider.
final documentAiEngineProvider = Provider<DocumentAiGenerationEngine>((ref) {
  return const DocumentAiGenerationEngine();
});

/// Document List Future Provider.
final documentListProvider = FutureProvider.family<List<Document>, String?>((ref, projectId) async {
  final repo = ref.watch(documentRepositoryProvider);
  return repo.getDocuments(projectId: projectId);
});

/// Preset Templates Gallery Future Provider.
final documentTemplatesProvider = FutureProvider<List<DocumentTemplate>>((ref) async {
  final repo = ref.watch(documentRepositoryProvider);
  return repo.getTemplates();
});

/// Master Document Editor Controller Provider.
final documentEditorControllerProvider =
    StateNotifierProvider<DocumentEditorController, AsyncValue<DocumentEditorState>>((ref) {
  return DocumentEditorController(
    repository: ref.watch(documentRepositoryProvider),
    aiEngine: ref.watch(documentAiEngineProvider),
  );
});

/// Derived Slice Provider: Active Document entity.
final activeDocumentProvider = Provider<Document?>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      return asyncState.asData?.value.document;
    }),
  );
});

/// Derived Slice Provider: Selected Block ID.
final selectedBlockIdProvider = Provider<String?>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      return asyncState.asData?.value.selectedBlockId;
    }),
  );
});

/// Derived Slice Provider: Floating slash menu visibility.
final isSlashMenuOpenProvider = Provider<bool>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      return asyncState.asData?.value.isSlashMenuOpen ?? false;
    }),
  );
});

/// Derived Slice Provider: Right AI panel visibility.
final isAiPanelOpenProvider = Provider<bool>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      return asyncState.asData?.value.isAiPanelOpen ?? true;
    }),
  );
});

/// Derived Slice Provider: Version history drawer visibility.
final isVersionDrawerOpenProvider = Provider<bool>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      return asyncState.asData?.value.isVersionDrawerOpen ?? false;
    }),
  );
});

/// Derived Slice Provider: Background autosaving state.
final isAutosavingProvider = Provider<bool>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      return asyncState.asData?.value.isAutosaving ?? false;
    }),
  );
});

/// Derived Slice Provider: AI generation / streaming active.
final isAiGeneratingProvider = Provider<bool>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      final s = asyncState.asData?.value;
      return (s?.isGenerating ?? false) || (s?.isStreaming ?? false);
    }),
  );
});

/// Derived Slice Provider: Document Version History list.
final documentVersionsProvider = Provider<List<DocumentVersion>>((ref) {
  return ref.watch(
    documentEditorControllerProvider.select((asyncState) {
      return asyncState.asData?.value.versions ?? const [];
    }),
  );
});
