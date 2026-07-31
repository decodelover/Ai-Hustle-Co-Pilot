/// Domain Entity: DocumentVersion (Version Control Snapshot).
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:flutter/foundation.dart';

/// Immutable version history snapshot of a document at a specific point in time.
@immutable
final class DocumentVersion {
  /// Creates a [DocumentVersion].
  const DocumentVersion({
    required this.id,
    required this.documentId,
    required this.versionNumber,
    required this.commitMessage,
    required this.snapshotBlocks,
    required this.createdByUserId,
    required this.isAiGenerated,
    required this.createdAt,
  });

  /// Unique version identifier.
  final String id;

  /// Parent document identifier.
  final String documentId;

  /// Sequential version number.
  final int versionNumber;

  /// Descriptive commit note or automated snapshot title.
  final String commitMessage;

  /// Immutable deep copy list of blocks captured at snapshot time.
  final List<DocumentBlock> snapshotBlocks;

  /// User or AI service ID responsible for snapshot creation.
  final String createdByUserId;

  /// Whether this version was created by an automated AI generation run.
  final bool isAiGenerated;

  /// Snapshot creation timestamp.
  final DateTime createdAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentVersion &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          documentId == other.documentId &&
          versionNumber == other.versionNumber &&
          commitMessage == other.commitMessage &&
          listEquals(snapshotBlocks, other.snapshotBlocks) &&
          createdByUserId == other.createdByUserId &&
          isAiGenerated == other.isAiGenerated &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(
    id,
    documentId,
    versionNumber,
    commitMessage,
    Object.hashAll(snapshotBlocks),
    createdByUserId,
    isAiGenerated,
    createdAt,
  );
}
