/// Repository Contract: IDocumentRepository.
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';

/// Contract interface for persistence, querying, and snapshot management of documents.
abstract interface class IDocumentRepository {
  /// Fetches list of documents with optional project ID filter.
  Future<List<Document>> getDocuments({String? projectId});

  /// Retrieves a document by its unique ID.
  Future<Document?> getDocumentById(String id);

  /// Saves or updates a document.
  Future<Document> saveDocument(Document document);

  /// Deletes a document by ID.
  Future<void> deleteDocument(String id);

  /// Saves a single document block update.
  Future<DocumentBlock> saveBlock(DocumentBlock block);

  /// Deletes a block by ID.
  Future<void> deleteBlock(String documentId, String blockId);

  /// Fetches all version snapshots for a document.
  Future<List<DocumentVersion>> getVersions(String documentId);

  /// Creates a version snapshot.
  Future<DocumentVersion> createVersionSnapshot(DocumentVersion version);

  /// Fetches available templates catalogue.
  Future<List<DocumentTemplate>> getTemplates();
}
