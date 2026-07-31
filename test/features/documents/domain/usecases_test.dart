import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:ai_hustle_copilot/features/documents/domain/usecases/document_usecases.dart';
import 'package:ai_hustle_copilot/features/documents/domain/usecases/generate_document_usecase.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/document_status.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Document Domain UseCases', () {
    late GenerateDocumentUseCase generateUseCase;
    late TransformBlockUseCase transformUseCase;
    late CreateVersionSnapshotUseCase snapshotUseCase;
    late ApplyTemplateUseCase templateUseCase;

    setUp(() {
      generateUseCase = const GenerateDocumentUseCase();
      transformUseCase = TransformBlockUseCase();
      snapshotUseCase = CreateVersionSnapshotUseCase();
      templateUseCase = ApplyTemplateUseCase();
    });

    test('GenerateDocumentUseCase parses markdown string into blocks', () {
      const markdown =
          '# Main Heading\n\nParagraph text here.\n\n- Item 1\n- Item 2\n\n> Quote block';
      final blocks = generateUseCase.parseMarkdownToBlocks(
        documentId: 'd1',
        markdownContent: markdown,
      );

      expect(blocks.length, equals(5));
      expect(blocks[0].type, equals(BlockType.heading1));
      expect(blocks[0].textContent, equals('Main Heading'));
      expect(blocks[1].type, equals(BlockType.paragraph));
      expect(blocks[2].type, equals(BlockType.bulletList));
      expect(blocks[4].type, equals(BlockType.quote));
    });

    test('TransformBlockUseCase modifies block type and text', () {
      const block = DocumentBlock(
        id: 'b1',
        documentId: 'd1',
        type: BlockType.paragraph,
        textContent: 'Old Text',
        sortOrder: 0,
      );

      final transformed = transformUseCase.execute(
        targetBlock: block,
        newType: BlockType.heading2,
        newTextContent: 'Transformed Heading',
      );

      expect(transformed.type, equals(BlockType.heading2));
      expect(transformed.textContent, equals('Transformed Heading'));
    });

    test('CreateVersionSnapshotUseCase increments version number', () {
      final doc = Document(
        id: 'd1',
        title: 'Title',
        blocks: const [],
        status: DocumentStatus.draft,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdByUserId: 'u1',
        currentVersionNumber: 2,
      );

      final version = snapshotUseCase.execute(
        document: doc,
        commitMessage: 'Commit Message',
        userId: 'u1',
        isAiGenerated: true,
      );

      expect(version.versionNumber, equals(3));
      expect(version.commitMessage, equals('Commit Message'));
      expect(version.isAiGenerated, isTrue);
    });

    test('ApplyTemplateUseCase populates template default blocks', () {
      const template = DocumentTemplate(
        id: 't1',
        name: 'Test Template',
        category: 'Test',
        description: 'Desc',
        iconName: '📄',
        aiSystemPrompt: 'Prompt',
        defaultBlocks: [
          DocumentBlock(
            id: 'tb0',
            documentId: '',
            type: BlockType.heading1,
            textContent: 'Template Header',
            sortOrder: 0,
          ),
        ],
      );

      final doc = templateUseCase.execute(
        template: template,
        userId: 'u1',
        customTitle: 'Custom Document Title',
      );

      expect(doc.title, equals('Custom Document Title'));
      expect(doc.templateId, equals('t1'));
      expect(doc.blocks.first.textContent, equals('Template Header'));
      expect(doc.blocks.first.documentId, equals(doc.id));
    });
  });
}
