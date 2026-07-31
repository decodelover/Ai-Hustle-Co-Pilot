/// Application Controller: DocumentEditorController.
library;

import 'dart:async';
import 'dart:typed_data';
import 'package:ai_hustle_copilot/features/documents/application/services/document_ai_generation_engine.dart';
import 'package:ai_hustle_copilot/features/documents/data/datasources/document_local_datasource.dart';
import 'package:ai_hustle_copilot/features/documents/data/repositories/document_repository_impl.dart';

import 'package:ai_hustle_copilot/features/documents/data/services/document_export_services.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';
import 'package:ai_hustle_copilot/features/documents/domain/repositories/i_document_repository.dart';
import 'package:ai_hustle_copilot/features/documents/domain/usecases/document_usecases.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/ai_prompt_intent.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/document_status.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/export_format.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/state/document_editor_state.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod StateNotifier controlling the document editor, AI streaming, block tree, and snapshots.
final class DocumentEditorController
    extends StateNotifier<AsyncValue<DocumentEditorState>> {
  /// Creates a [DocumentEditorController].
  DocumentEditorController({
    IDocumentRepository? repository,
    DocumentAiGenerationEngine? aiEngine,
    CreateVersionSnapshotUseCase? snapshotUseCase,
    ApplyTemplateUseCase? templateUseCase,
  }) : _repository =
           repository ??
           DocumentRepositoryImpl(localDataSource: DocumentLocalDataSource()),
       _aiEngine = aiEngine ?? const DocumentAiGenerationEngine(),
       _snapshotUseCase = snapshotUseCase ?? CreateVersionSnapshotUseCase(),
       _templateUseCase = templateUseCase ?? ApplyTemplateUseCase(),
       super(const AsyncValue.loading());

  final IDocumentRepository _repository;
  final DocumentAiGenerationEngine _aiEngine;
  final CreateVersionSnapshotUseCase _snapshotUseCase;
  final ApplyTemplateUseCase _templateUseCase;

  Timer? _autosaveDebounce;

  /// Loads an existing document by ID or initializes default editor state.
  Future<void> loadDocument(String id) async {
    state = const AsyncValue.loading();
    try {
      final doc = await _repository.getDocumentById(id);
      final versions = await _repository.getVersions(id);

      if (doc != null) {
        state = AsyncValue.data(
          DocumentEditorState(document: doc, versions: versions),
        );
      } else {
        await createNewDocument(title: 'Untitled AI Document');
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Creates a new document, optionally attached to a project or template.
  Future<void> createNewDocument({
    String? projectId,
    String title = 'Untitled Document',
    String? emojiIcon,
    DocumentTemplate? template,
  }) async {
    state = const AsyncValue.loading();
    try {
      Document newDoc;
      if (template != null) {
        newDoc = _templateUseCase.execute(
          template: template,
          userId: 'usr_current',
          projectId: projectId,
          customTitle: title,
        );
      } else {
        final docId = 'doc_${DateTime.now().millisecondsSinceEpoch}';
        newDoc = Document(
          id: docId,
          title: title,
          blocks: [
            DocumentBlock(
              id: '${docId}_b0',
              documentId: docId,
              type: BlockType.heading1,
              textContent: title,
              sortOrder: 0,
            ),
            DocumentBlock(
              id: '${docId}_b1',
              documentId: docId,
              type: BlockType.paragraph,
              textContent: 'Start typing or press "/" for AI actions...',
              sortOrder: 1,
            ),
          ],
          status: DocumentStatus.draft,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          createdByUserId: 'usr_current',
          projectId: projectId,
          emojiIcon: emojiIcon ?? '📄',
        );
      }

      await _repository.saveDocument(newDoc);
      state = AsyncValue.data(DocumentEditorState(document: newDoc));
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Updates document title and schedules auto-save.
  void updateTitle(String newTitle) {
    final current = state.value;
    if (current == null || current.document == null) return;

    final updated = current.document!.copyWith(title: newTitle);
    state = AsyncValue.data(current.copyWith(document: updated));
    _scheduleAutosave();
  }

  /// Updates document emoji icon.
  void updateEmoji(String emoji) {
    final current = state.value;
    if (current == null || current.document == null) return;

    final updated = current.document!.copyWith(emojiIcon: emoji);
    state = AsyncValue.data(current.copyWith(document: updated));
    _scheduleAutosave();
  }

  /// Updates a specific block within the document block tree.
  void updateBlock(DocumentBlock updatedBlock) {
    final current = state.value;
    if (current == null || current.document == null) return;

    final blocks = List<DocumentBlock>.from(current.document!.blocks);
    final idx = blocks.indexWhere((b) => b.id == updatedBlock.id);
    if (idx >= 0) {
      blocks[idx] = updatedBlock;
    } else {
      blocks.add(updatedBlock);
    }

    final updatedDoc = current.document!.copyWith(blocks: blocks);
    state = AsyncValue.data(current.copyWith(document: updatedDoc));
    _scheduleAutosave();
  }

  /// Appends or inserts a new block of given type.
  void addBlock(BlockType type, {int? atIndex}) {
    final current = state.value;
    if (current == null || current.document == null) return;

    final docId = current.document!.id;
    final blocks = List<DocumentBlock>.from(current.document!.blocks);
    final insertIdx = atIndex ?? blocks.length;

    final newBlock = DocumentBlock(
      id: '${docId}_b_${DateTime.now().millisecondsSinceEpoch}',
      documentId: docId,
      type: type,
      textContent: type == BlockType.callout ? '💡 New Callout' : '',
      sortOrder: insertIdx,
    );

    blocks.insert(insertIdx, newBlock);

    // Re-index sort order
    final reindexed = blocks.asMap().entries.map((e) {
      return e.value.copyWith(sortOrder: e.key);
    }).toList();

    final updatedDoc = current.document!.copyWith(blocks: reindexed);
    state = AsyncValue.data(
      current.copyWith(
        document: updatedDoc,
        selectedBlockId: newBlock.id,
        isSlashMenuOpen: false,
      ),
    );
    _scheduleAutosave();
  }

  /// Deletes a block by ID.
  void deleteBlock(String blockId) {
    final current = state.value;
    if (current == null || current.document == null) return;

    final blocks = current.document!.blocks
        .where((b) => b.id != blockId)
        .toList();
    final updatedDoc = current.document!.copyWith(blocks: blocks);
    state = AsyncValue.data(current.copyWith(document: updatedDoc));
    _scheduleAutosave();
  }

  /// Reorders blocks during drag-and-drop.
  void reorderBlocks(int oldIndex, int newIndex) {
    final current = state.value;
    if (current == null || current.document == null) return;

    final blocks = List<DocumentBlock>.from(current.document!.blocks);
    var targetIndex = newIndex;
    if (oldIndex < targetIndex) targetIndex -= 1;
    final item = blocks.removeAt(oldIndex);
    blocks.insert(targetIndex, item);

    final reindexed = blocks.asMap().entries.map((e) {
      return e.value.copyWith(sortOrder: e.key);
    }).toList();

    final updatedDoc = current.document!.copyWith(blocks: reindexed);
    state = AsyncValue.data(current.copyWith(document: updatedDoc));
    _scheduleAutosave();
  }

  /// Selects active block ID for editing or AI toolbar targeting.
  void selectBlock(String? blockId) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(selectedBlockId: blockId));
  }

  /// Toggles floating slash menu state.
  void toggleSlashMenu(bool isOpen) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(isSlashMenuOpen: isOpen));
  }

  /// Toggles right AI panel visibility.
  void toggleAiPanel(bool isOpen) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(isAiPanelOpen: isOpen));
  }

  /// Toggles version history drawer.
  void toggleVersionDrawer(bool isOpen) {
    final current = state.value;
    if (current == null) return;
    state = AsyncValue.data(current.copyWith(isVersionDrawerOpen: isOpen));
  }

  /// Executes AI writing assistant generation stream.
  Future<void> generateWithAi({
    required AiPromptIntent intent,
    required String userPrompt,
    Project? projectContext,
    String? targetBlockId,
  }) async {
    final current = state.value;
    if (current == null || current.document == null) return;

    state = AsyncValue.data(
      current.copyWith(isGenerating: true, isStreaming: true),
    );

    try {
      final stream = _aiEngine.streamGeneration(
        document: current.document!,
        intent: intent,
        userPrompt: userPrompt,
        project: projectContext,
        targetBlockId: targetBlockId,
      );

      await for (final generatedBlocks in stream) {
        final latestState = state.value;
        if (latestState == null || latestState.document == null) break;

        List<DocumentBlock> mergedBlocks;
        if (intent == AiPromptIntent.generateDocument) {
          mergedBlocks = generatedBlocks;
        } else {
          mergedBlocks = List<DocumentBlock>.from(latestState.document!.blocks);
          if (targetBlockId != null) {
            final targetIdx = mergedBlocks.indexWhere(
              (b) => b.id == targetBlockId,
            );
            if (targetIdx >= 0 && generatedBlocks.isNotEmpty) {
              mergedBlocks[targetIdx] = generatedBlocks.first;
              if (generatedBlocks.length > 1) {
                mergedBlocks.insertAll(targetIdx + 1, generatedBlocks.skip(1));
              }
            }
          } else {
            mergedBlocks.addAll(generatedBlocks);
          }
        }

        final updatedDoc = latestState.document!.copyWith(blocks: mergedBlocks);
        state = AsyncValue.data(latestState.copyWith(document: updatedDoc));
      }

      // Generation completed -> Create auto version snapshot
      final finalState = state.value;
      if (finalState != null && finalState.document != null) {
        final snapshot = _snapshotUseCase.execute(
          document: finalState.document!,
          commitMessage: 'AI ${intent.label}: "$userPrompt"',
          userId: 'usr_ai_engine',
          isAiGenerated: true,
        );

        await _repository.createVersionSnapshot(snapshot);
        final versions = await _repository.getVersions(finalState.document!.id);

        state = AsyncValue.data(
          finalState.copyWith(
            isGenerating: false,
            isStreaming: false,
            versions: versions,
          ),
        );
        _scheduleAutosave();
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Restores document snapshot from version history.
  Future<void> restoreVersion(DocumentVersion version) async {
    final current = state.value;
    if (current == null || current.document == null) return;

    final restoredDoc = current.document!.copyWith(
      blocks: version.snapshotBlocks,
      currentVersionNumber: version.versionNumber,
    );

    await _repository.saveDocument(restoredDoc);
    state = AsyncValue.data(current.copyWith(document: restoredDoc));
  }

  /// Creates a manual version snapshot.
  Future<void> createManualSnapshot(String commitNote) async {
    final current = state.value;
    if (current == null || current.document == null) return;

    final snapshot = _snapshotUseCase.execute(
      document: current.document!,
      commitMessage: commitNote.isNotEmpty
          ? commitNote
          : 'Manual User Snapshot',
      userId: 'usr_current',
    );

    await _repository.createVersionSnapshot(snapshot);
    final versions = await _repository.getVersions(current.document!.id);
    state = AsyncValue.data(current.copyWith(versions: versions));
  }

  /// Exports current document in requested format bytes.
  Future<Uint8List?> exportDocument(ExportFormat format) async {
    final current = state.value;
    if (current == null || current.document == null) return null;

    return DocumentExportService.exportDocument(
      document: current.document!,
      format: format,
    );
  }

  void _scheduleAutosave() {
    _autosaveDebounce?.cancel();
    _autosaveDebounce = Timer(const Duration(milliseconds: 1500), () async {
      final current = state.value;
      if (current != null && current.document != null) {
        state = AsyncValue.data(current.copyWith(isAutosaving: true));
        await _repository.saveDocument(current.document!);
        final updatedState = state.value;
        if (updatedState != null) {
          state = AsyncValue.data(updatedState.copyWith(isAutosaving: false));
        }
      }
    });
  }

  @override
  void dispose() {
    _autosaveDebounce?.cancel();
    super.dispose();
  }
}
