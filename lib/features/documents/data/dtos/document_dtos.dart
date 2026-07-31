/// Data DTOs: Document and DocumentBlock serialization models.
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/document_status.dart';

/// Data Transfer Object for [DocumentBlock].
final class DocumentBlockDto {
  const DocumentBlockDto({
    required this.id,
    required this.documentId,
    required this.type,
    required this.textContent,
    required this.attributes,
    required this.sortOrder,
    this.parentBlockId,
  });

  factory DocumentBlockDto.fromJson(Map<String, dynamic> json) {
    return DocumentBlockDto(
      id: json['id'] as String,
      documentId: json['documentId'] as String,
      type: json['type'] as String? ?? 'paragraph',
      textContent: json['textContent'] as String? ?? '',
      attributes: (json['attributes'] as Map<String, dynamic>?) ?? {},
      sortOrder: (json['sortOrder'] as num?)?.toInt() ?? 0,
      parentBlockId: json['parentBlockId'] as String?,
    );
  }

  factory DocumentBlockDto.fromDomain(DocumentBlock block) {
    return DocumentBlockDto(
      id: block.id,
      documentId: block.documentId,
      type: block.type.name,
      textContent: block.textContent,
      attributes: block.attributes,
      sortOrder: block.sortOrder,
      parentBlockId: block.parentBlockId,
    );
  }

  final String id;
  final String documentId;
  final String type;
  final String textContent;
  final Map<String, dynamic> attributes;
  final int sortOrder;
  final String? parentBlockId;

  Map<String, dynamic> toJson() => {
        'id': id,
        'documentId': documentId,
        'type': type,
        'textContent': textContent,
        'attributes': attributes,
        'sortOrder': sortOrder,
        'parentBlockId': parentBlockId,
      };

  DocumentBlock toDomain() {
    return DocumentBlock(
      id: id,
      documentId: documentId,
      type: BlockType.values.firstWhere(
        (e) => e.name == type,
        orElse: () => BlockType.paragraph,
      ),
      textContent: textContent,
      sortOrder: sortOrder,
      attributes: attributes,
      parentBlockId: parentBlockId,
    );
  }
}

/// Data Transfer Object for [Document].
final class DocumentDto {
  const DocumentDto({
    required this.id,
    required this.title,
    required this.blocks,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.createdByUserId,
    required this.currentVersionNumber,
    required this.metadata,
    this.projectId,
    this.emojiIcon,
    this.coverImageUrl,
    this.templateId,
  });

  factory DocumentDto.fromJson(Map<String, dynamic> json) {
    return DocumentDto(
      id: json['id'] as String,
      projectId: json['projectId'] as String?,
      title: json['title'] as String? ?? 'Untitled Document',
      emojiIcon: json['emojiIcon'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      blocks: ((json['blocks'] as List<dynamic>?) ?? [])
          .map((e) => DocumentBlockDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      status: json['status'] as String? ?? 'draft',
      templateId: json['templateId'] as String?,
      createdAt: json['createdAt'] as String? ??
          DateTime.now().toIso8601String(),
      updatedAt: json['updatedAt'] as String? ??
          DateTime.now().toIso8601String(),
      createdByUserId: json['createdByUserId'] as String? ?? 'usr_current',
      currentVersionNumber:
          (json['currentVersionNumber'] as num?)?.toInt() ?? 1,
      metadata: (json['metadata'] as Map<String, dynamic>?) ?? {},
    );
  }

  factory DocumentDto.fromDomain(Document doc) {
    return DocumentDto(
      id: doc.id,
      projectId: doc.projectId,
      title: doc.title,
      emojiIcon: doc.emojiIcon,
      coverImageUrl: doc.coverImageUrl,
      blocks: doc.blocks.map(DocumentBlockDto.fromDomain).toList(),
      status: doc.status.name,
      templateId: doc.templateId,
      createdAt: doc.createdAt.toIso8601String(),
      updatedAt: doc.updatedAt.toIso8601String(),
      createdByUserId: doc.createdByUserId,
      currentVersionNumber: doc.currentVersionNumber,
      metadata: doc.metadata,
    );
  }

  final String id;
  final String? projectId;
  final String title;
  final String? emojiIcon;
  final String? coverImageUrl;
  final List<DocumentBlockDto> blocks;
  final String status;
  final String? templateId;
  final String createdAt;
  final String updatedAt;
  final String createdByUserId;
  final int currentVersionNumber;
  final Map<String, dynamic> metadata;

  Map<String, dynamic> toJson() => {
        'id': id,
        'projectId': projectId,
        'title': title,
        'emojiIcon': emojiIcon,
        'coverImageUrl': coverImageUrl,
        'blocks': blocks.map((b) => b.toJson()).toList(),
        'status': status,
        'templateId': templateId,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'createdByUserId': createdByUserId,
        'currentVersionNumber': currentVersionNumber,
        'metadata': metadata,
      };

  Document toDomain() {
    return Document(
      id: id,
      projectId: projectId,
      title: title,
      emojiIcon: emojiIcon,
      coverImageUrl: coverImageUrl,
      blocks: blocks.map((b) => b.toDomain()).toList(),
      status: DocumentStatus.values.firstWhere(
        (e) => e.name == status,
        orElse: () => DocumentStatus.draft,
      ),
      templateId: templateId,
      createdAt: DateTime.tryParse(createdAt) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(updatedAt) ?? DateTime.now(),
      createdByUserId: createdByUserId,
      currentVersionNumber: currentVersionNumber,
      metadata: metadata,
    );
  }
}
