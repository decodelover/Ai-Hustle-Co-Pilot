/// UseCases: Document Block Transformation, Version Snapshot, and Template Application.
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/document_status.dart';

/// Transforms block types or replaces text inside a target block.
final class TransformBlockUseCase {
  /// Converts a target [DocumentBlock] to a new [BlockType] or updates text.
  DocumentBlock execute({
    required DocumentBlock targetBlock,
    BlockType? newType,
    String? newTextContent,
    Map<String, dynamic>? attributes,
  }) {
    return targetBlock.copyWith(
      type: newType ?? targetBlock.type,
      textContent: newTextContent ?? targetBlock.textContent,
      attributes: attributes ?? targetBlock.attributes,
    );
  }
}

/// Creates a new immutable version snapshot for a document.
final class CreateVersionSnapshotUseCase {
  /// Builds a new [DocumentVersion] instance.
  DocumentVersion execute({
    required Document document,
    required String commitMessage,
    required String userId,
    bool isAiGenerated = false,
  }) {
    final nextVersion = document.currentVersionNumber + 1;
    return DocumentVersion(
      id: 'ver_${document.id}_$nextVersion',
      documentId: document.id,
      versionNumber: nextVersion,
      commitMessage: commitMessage,
      snapshotBlocks: List.unmodifiable(document.blocks),
      createdByUserId: userId,
      isAiGenerated: isAiGenerated,
      createdAt: DateTime.now(),
    );
  }
}

/// Applies a preset [DocumentTemplate] to generate a fresh document structure.
final class ApplyTemplateUseCase {
  /// Generates a new [Document] populated with template blocks and attributes.
  Document execute({
    required DocumentTemplate template,
    required String userId,
    String? projectId,
    String? customTitle,
  }) {
    final docId = 'doc_${DateTime.now().millisecondsSinceEpoch}';
    final mappedBlocks = template.defaultBlocks.asMap().entries.map((entry) {
      final idx = entry.key;
      final block = entry.value;
      return block.copyWith(
        id: '${docId}_b_$idx',
        documentId: docId,
        sortOrder: idx,
      );
    }).toList();

    return Document(
      id: docId,
      projectId: projectId,
      title: customTitle ?? template.name,
      emojiIcon: template.iconName,
      blocks: mappedBlocks,
      status: DocumentStatus.draft,
      templateId: template.id,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      createdByUserId: userId,
    );
  }
}
