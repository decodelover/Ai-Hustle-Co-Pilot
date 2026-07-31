import 'package:ai_hustle_copilot/features/documents/data/datasources/document_local_datasource.dart';
import 'package:ai_hustle_copilot/features/documents/data/repositories/document_repository_impl.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/document_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DocumentRepositoryImpl & DocumentLocalDataSource Integration', () {
    late DocumentLocalDataSource dataSource;
    late DocumentRepositoryImpl repository;

    setUp(() {
      dataSource = DocumentLocalDataSource();
      repository = DocumentRepositoryImpl(localDataSource: dataSource);
    });

    test('getDocuments returns pre-seeded mock documents', () async {
      final docs = await repository.getDocuments();

      expect(docs.isNotEmpty, isTrue);
      expect(docs.any((d) => d.id == 'doc_101'), isTrue);
    });

    test('getDocumentById fetches exact document', () async {
      final doc = await repository.getDocumentById('doc_101');

      expect(doc, isNotNull);
      expect(
        doc!.title,
        contains('AI Co-Pilot Enterprise SaaS Architecture Specification'),
      );
    });

    test('saveDocument creates or updates document', () async {
      final now = DateTime.now();
      final newDoc = Document(
        id: 'doc_custom_99',
        title: 'Fresh Test Document',
        blocks: const [],
        status: DocumentStatus.draft,
        createdAt: now,
        updatedAt: now,
        createdByUserId: 'u1',
      );

      final saved = await repository.saveDocument(newDoc);
      expect(saved.title, equals('Fresh Test Document'));

      final retrieved = await repository.getDocumentById('doc_custom_99');
      expect(retrieved, isNotNull);
      expect(retrieved!.title, equals('Fresh Test Document'));
    });

    test('getTemplates returns pre-seeded template catalog', () async {
      final templates = await repository.getTemplates();

      expect(templates.length, greaterThanOrEqualTo(5));
      expect(templates.any((t) => t.id == 'tpl_biz_plan'), isTrue);
    });
  });
}
