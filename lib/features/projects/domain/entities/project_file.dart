/// Domain Entity: ProjectFile (Amendment 3.3E RAG-Ready Knowledge Index)
library;

import 'package:flutter/foundation.dart';

/// RAG indexing status of a knowledge file.
enum IndexingStatus { unindexed, indexing, ready, failed }

/// Immutable domain model representing a knowledge file or document attached to an AI project.
@immutable
final class ProjectFile {
  /// Creates a [ProjectFile].
  const ProjectFile({
    required this.id,
    required this.projectId,
    required this.name,
    required this.extension,
    required this.sizeBytes,
    required this.folderPath,
    required this.createdAt,
    this.tags = const [],
    this.summary,
    this.indexingStatus = IndexingStatus.ready,
    this.downloadUrl,
    this.version = 1,
  });

  /// File ID.
  final String id;

  /// Project ID.
  final String projectId;

  /// File basename.
  final String name;

  /// File extension (.pdf, .docx, .dart, .csv).
  final String extension;

  /// File size in bytes.
  final int sizeBytes;

  /// Folder path within project knowledge base.
  final String folderPath;

  /// Upload timestamp.
  final DateTime createdAt;

  /// Tag labels.
  final List<String> tags;

  /// AI-generated document summary.
  final String? summary;

  /// RAG indexing status.
  final IndexingStatus indexingStatus;

  /// Download URL.
  final String? downloadUrl;

  /// File version number.
  final int version;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectFile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          projectId == other.projectId &&
          name == other.name &&
          extension == other.extension &&
          sizeBytes == other.sizeBytes &&
          folderPath == other.folderPath &&
          createdAt == other.createdAt &&
          listEquals(tags, other.tags) &&
          summary == other.summary &&
          indexingStatus == other.indexingStatus &&
          downloadUrl == other.downloadUrl &&
          version == other.version;

  @override
  int get hashCode => Object.hash(
        id,
        projectId,
        name,
        extension,
        sizeBytes,
        folderPath,
        createdAt,
        Object.hashAll(tags),
        summary,
        indexingStatus,
        downloadUrl,
        version,
      );
}
