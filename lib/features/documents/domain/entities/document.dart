/// Domain Entity: Document (Master AI Document Entity).
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/document_status.dart';
import 'package:flutter/foundation.dart';

/// Immutable domain entity representing an AI-assisted document.
@immutable
final class Document {
  /// Creates a [Document].
  const Document({
    required this.id,
    required this.title,
    required this.blocks,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdByUserId,
    this.projectId,
    this.emojiIcon,
    this.coverImageUrl,
    this.templateId,
    this.currentVersionNumber = 1,
    this.metadata = const {},
  });

  /// Unique document identifier.
  final String id;

  /// Document title.
  final String title;

  /// List of block elements forming the document canvas.
  final List<DocumentBlock> blocks;

  /// Lifecycle status (draft, active, archived, trashed).
  final DocumentStatus status;

  /// Timestamp of creation.
  final DateTime createdAt;

  /// Timestamp of last update.
  final DateTime updatedAt;

  /// Creator user ID.
  final String createdByUserId;

  /// Optional project binding (connected to Phase 3.3 Project Workspace).
  final String? projectId;

  /// Optional decorative emoji icon.
  final String? emojiIcon;

  /// Optional header cover image URL.
  final String? coverImageUrl;

  /// Template identifier if generated from preset template.
  final String? templateId;

  /// Active version sequence counter.
  final int currentVersionNumber;

  /// Flexible metadata key-value pairs.
  final Map<String, dynamic> metadata;

  /// Copies this [Document] with modified properties.
  Document copyWith({
    String? title,
    String? emojiIcon,
    String? coverImageUrl,
    List<DocumentBlock>? blocks,
    DocumentStatus? status,
    String? templateId,
    DateTime? updatedAt,
    int? currentVersionNumber,
    Map<String, dynamic>? metadata,
  }) {
    return Document(
      id: id,
      title: title ?? this.title,
      blocks: blocks ?? this.blocks,
      status: status ?? this.status,
      createdAt: createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
      createdByUserId: createdByUserId,
      projectId: projectId,
      emojiIcon: emojiIcon ?? this.emojiIcon,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      templateId: templateId ?? this.templateId,
      currentVersionNumber: currentVersionNumber ?? this.currentVersionNumber,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Document &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          title == other.title &&
          emojiIcon == other.emojiIcon &&
          coverImageUrl == other.coverImageUrl &&
          listEquals(blocks, other.blocks) &&
          status == other.status &&
          templateId == other.templateId &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          createdByUserId == other.createdByUserId &&
          currentVersionNumber == other.currentVersionNumber &&
          mapEquals(metadata, other.metadata);

  @override
  int get hashCode => Object.hash(
        id,
        projectId,
        title,
        emojiIcon,
        coverImageUrl,
        Object.hashAll(blocks),
        status,
        templateId,
        createdAt,
        updatedAt,
        createdByUserId,
        currentVersionNumber,
        Object.hashAll(metadata.entries),
      );
}
