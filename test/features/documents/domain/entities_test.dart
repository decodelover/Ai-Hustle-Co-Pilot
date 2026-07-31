import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_version.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/document_status.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/export_format.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Document Domain Entities & Value Objects', () {
    test('DocumentBlock copyWith and immutability', () {
      const block = DocumentBlock(
        id: 'b1',
        documentId: 'd1',
        type: BlockType.heading1,
        textContent: 'Initial Title',
        sortOrder: 0,
      );

      final updated = block.copyWith(textContent: 'New Title');

      expect(updated.id, equals('b1'));
      expect(updated.textContent, equals('New Title'));
      expect(updated.type, equals(BlockType.heading1));
      expect(block.textContent, equals('Initial Title'));
    });

    test('Document copyWith and block modification', () {
      final now = DateTime.now();
      final doc = Document(
        id: 'd1',
        title: 'Original Doc',
        blocks: const [
          DocumentBlock(
            id: 'b1',
            documentId: 'd1',
            type: BlockType.paragraph,
            textContent: 'Hello',
            sortOrder: 0,
          ),
        ],
        status: DocumentStatus.draft,
        createdAt: now,
        updatedAt: now,
        createdByUserId: 'u1',
      );

      final updatedDoc = doc.copyWith(title: 'Updated Doc Title');

      expect(updatedDoc.title, equals('Updated Doc Title'));
      expect(updatedDoc.blocks.length, equals(1));
      expect(updatedDoc.status, equals(DocumentStatus.draft));
    });

    test('DocumentVersion snapshot captures state', () {
      final now = DateTime.now();
      final ver = DocumentVersion(
        id: 'v1',
        documentId: 'd1',
        versionNumber: 1,
        commitMessage: 'Initial Commit',
        snapshotBlocks: const [
          DocumentBlock(
            id: 'b1',
            documentId: 'd1',
            type: BlockType.heading1,
            textContent: 'Snapshot Content',
            sortOrder: 0,
          ),
        ],
        createdByUserId: 'u1',
        isAiGenerated: false,
        createdAt: now,
      );

      expect(ver.versionNumber, equals(1));
      expect(ver.snapshotBlocks.first.textContent, equals('Snapshot Content'));
      expect(ver.isAiGenerated, isFalse);
    });

    test('ExportFormat extension properties', () {
      expect(ExportFormat.pdf.extension, equals('pdf'));
      expect(ExportFormat.docx.extension, equals('docx'));
      expect(ExportFormat.markdown.mimeType, equals('text/markdown'));
    });

    test('BlockType markdown prefix formatting', () {
      expect(BlockType.heading1.markdownPrefix, equals('# '));
      expect(BlockType.bulletList.markdownPrefix, equals('- '));
      expect(BlockType.quote.markdownPrefix, equals('> '));
    });
  });
}
