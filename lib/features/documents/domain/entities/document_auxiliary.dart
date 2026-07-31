/// Domain Entities: Document Collaboration, Permissions, AI Action, and Export Models.
library;

import 'package:ai_hustle_copilot/features/documents/domain/value_objects/ai_prompt_intent.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/export_format.dart';
import 'package:flutter/foundation.dart';

/// Inline comment on a specific document block.
@immutable
final class DocumentComment {
  /// Creates a [DocumentComment].
  const DocumentComment({
    required this.id,
    required this.documentId,
    required this.blockId,
    required this.authorUserId,
    required this.authorName,
    required this.content,
    required this.createdAt,
    this.isResolved = false,
  });

  /// Unique comment identifier.
  final String id;

  /// Target document identifier.
  final String documentId;

  /// Target block identifier.
  final String blockId;

  /// Author user ID.
  final String authorUserId;

  /// Display name of author.
  final String authorName;

  /// Plain comment text body.
  final String content;

  /// Comment creation timestamp.
  final DateTime createdAt;

  /// Resolution state.
  final bool isResolved;
}

/// User access permissions for document operations.
enum DocumentAccessRole { viewer, commenter, editor, owner }

/// Domain entity representing user permission assignment.
@immutable
final class DocumentPermission {
  /// Creates a [DocumentPermission].
  const DocumentPermission({
    required this.documentId,
    required this.userId,
    required this.role,
    required this.grantedAt,
  });

  /// Target document identifier.
  final String documentId;

  /// Permitted user identifier.
  final String userId;

  /// Assigned role.
  final DocumentAccessRole role;

  /// Date permission was granted.
  final DateTime grantedAt;
}

/// Document AI Action payload.
@immutable
final class DocumentAIAction {
  /// Creates a [DocumentAIAction].
  const DocumentAIAction({
    required this.documentId,
    required this.intent,
    required this.userPrompt,
    this.targetBlockId,
    this.customOptions = const {},
  });

  /// Target document identifier.
  final String documentId;

  /// Action intent type.
  final AiPromptIntent intent;

  /// Primary user directive.
  final String userPrompt;

  /// Selected block ID (null for whole document).
  final String? targetBlockId;

  /// Additional options (e.g. target language, tone category).
  final Map<String, dynamic> customOptions;
}

/// Document Export Request model.
@immutable
final class DocumentExport {
  /// Creates a [DocumentExport].
  const DocumentExport({
    required this.documentId,
    required this.format,
    this.includeCoverPage = true,
    this.includeTableOfContents = true,
    this.customHeaderTitle,
  });

  /// Target document ID.
  final String documentId;

  /// Target export format.
  final ExportFormat format;

  /// Whether to render a cover page.
  final bool includeCoverPage;

  /// Whether to generate table of contents headers.
  final bool includeTableOfContents;

  /// Custom header title string.
  final String? customHeaderTitle;
}
