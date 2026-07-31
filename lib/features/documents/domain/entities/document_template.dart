/// Domain Entity: DocumentTemplate (Document Preset Blueprint).
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:flutter/foundation.dart';

/// Immutable domain model representing a pre-built document template.
@immutable
final class DocumentTemplate {
  /// Creates a [DocumentTemplate].
  const DocumentTemplate({
    required this.id,
    required this.name,
    required this.category,
    required this.description,
    required this.iconName,
    required this.defaultBlocks,
    required this.aiSystemPrompt,
    this.tags = const [],
  });

  /// Unique template ID.
  final String id;

  /// Display name of template.
  final String name;

  /// Category grouping (Business, Marketing, Career, Technical, Research, etc.).
  final String category;

  /// Brief description of template usage.
  final String description;

  /// Icon identifier or symbol.
  final String iconName;

  /// Pre-populated skeleton block tree.
  final List<DocumentBlock> defaultBlocks;

  /// Custom AI system directive instructions tailored for this template.
  final String aiSystemPrompt;

  /// Keywords for search filtering.
  final List<String> tags;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DocumentTemplate &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          category == other.category &&
          description == other.description &&
          iconName == other.iconName &&
          listEquals(defaultBlocks, other.defaultBlocks) &&
          aiSystemPrompt == other.aiSystemPrompt &&
          listEquals(tags, other.tags);

  @override
  int get hashCode => Object.hash(
        id,
        name,
        category,
        description,
        iconName,
        Object.hashAll(defaultBlocks),
        aiSystemPrompt,
        Object.hashAll(tags),
      );
}
