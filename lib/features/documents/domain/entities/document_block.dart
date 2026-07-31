/// Domain Entity: DocumentBlock (Block-based Editor Primitive).
library;

import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:flutter/foundation.dart';

/// Immutable domain representation of a single block unit in a document.
@immutable
final class DocumentBlock {
  /// Creates a [DocumentBlock].
  const DocumentBlock({
    required this.id,
    required this.documentId,
    required this.type,
    required this.textContent,
    required this.sortOrder,
    this.attributes = const {},
    this.parentBlockId,
    this.isAiGenerating = false,
  });

  /// Unique block identifier.
  final String id;

  /// Parent document identifier.
  final String documentId;

  /// Type category of this block.
  final BlockType type;

  /// Primary plain or formatted text content inside this block.
  final String textContent;

  /// Numerical ordering sequence index inside document tree.
  final int sortOrder;

  /// Extended layout and typography attributes (bold, alignment, syntax language, etc.).
  final Map<String, dynamic> attributes;

  /// Parent block ID for nested lists and indented structures.
  final String? parentBlockId;

  /// Whether AI is actively streaming content into this block.
  final bool isAiGenerating;

  /// Copies this [DocumentBlock] with modified properties.
  DocumentBlock copyWith({
    String? id,
    String? documentId,
    BlockType? type,
    String? textContent,
    Map<String, dynamic>? attributes,
    int? sortOrder,
    String? parentBlockId,
    bool? isAiGenerating,
  }) {
    return DocumentBlock(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      type: type ?? this.type,
      textContent: textContent ?? this.textContent,
      sortOrder: sortOrder ?? this.sortOrder,
      attributes: attributes ?? this.attributes,
      parentBlockId: parentBlockId ?? this.parentBlockId,
      isAiGenerating: isAiGenerating ?? this.isAiGenerating,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentBlock &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          documentId == other.documentId &&
          type == other.type &&
          textContent == other.textContent &&
          mapEquals(attributes, other.attributes) &&
          sortOrder == other.sortOrder &&
          parentBlockId == other.parentBlockId &&
          isAiGenerating == other.isAiGenerating;

  @override
  int get hashCode => Object.hash(
        id,
        documentId,
        type,
        textContent,
        Object.hashAll(attributes.entries),
        sortOrder,
        parentBlockId,
        isAiGenerating,
      );
}
