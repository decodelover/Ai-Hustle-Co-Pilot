/// Data Repository Implementation: DocumentRepositoryImpl.
library;

import 'package:ai_hustle_copilot/features/documents/data/datasources/document_local_datasource.dart';
import 'package:ai_hustle_copilot/features/documents/data/dtos/document_dtos.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';
import 'package:ai_hustle_copilot/features/documents/domain/repositories/i_document_repository.dart';

/// Production repository implementation connecting local storage datasource to the domain layer.
final class DocumentRepositoryImpl implements IDocumentRepository {
  /// Creates a [DocumentRepositoryImpl].
  const DocumentRepositoryImpl({
    required this.localDataSource,
  });

  final DocumentLocalDataSource localDataSource;

  @override
  Future<List<Document>> getDocuments({String? projectId}) async {
    final dtos = await localDataSource.getDocuments(projectId: projectId);
    return dtos.map((d) => d.toDomain()).toList();
  }

  @override
  Future<Document?> getDocumentById(String id) async {
    final dto = await localDataSource.getDocumentById(id);
    return dto?.toDomain();
  }

  @override
  Future<Document> saveDocument(Document document) async {
    final dto = DocumentDto.fromDomain(document);
    final saved = await localDataSource.saveDocument(dto);
    return saved.toDomain();
  }

  @override
  Future<void> deleteDocument(String id) async {
    await localDataSource.deleteDocument(id);
  }

  @override
  Future<DocumentBlock> saveBlock(DocumentBlock block) async {
    final doc = await getDocumentById(block.documentId);
    if (doc == null) return block;

    final updatedBlocks = List<DocumentBlock>.from(doc.blocks);
    final idx = updatedBlocks.indexWhere((b) => b.id == block.id);
    if (idx >= 0) {
      updatedBlocks[idx] = block;
    } else {
      updatedBlocks.add(block);
    }

    final updatedDoc = doc.copyWith(blocks: updatedBlocks);
    await saveDocument(updatedDoc);
    return block;
  }

  @override
  Future<void> deleteBlock(String documentId, String blockId) async {
    final doc = await getDocumentById(documentId);
    if (doc == null) return;

    final updatedBlocks = doc.blocks.where((b) => b.id != blockId).toList();
    final updatedDoc = doc.copyWith(blocks: updatedBlocks);
    await saveDocument(updatedDoc);
  }

  @override
  Future<List<DocumentVersion>> getVersions(String documentId) async {
    return localDataSource.getVersions(documentId);
  }

  @override
  Future<DocumentVersion> createVersionSnapshot(DocumentVersion version) async {
    return localDataSource.createVersionSnapshot(version);
  }

  @override
  Future<List<DocumentTemplate>> getTemplates() async {
    return localDataSource.getTemplates();
  }
}
