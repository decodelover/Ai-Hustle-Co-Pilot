/// UseCase: GenerateDocumentUseCase.
library;

import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';

/// Pure domain UseCase parsing raw AI generated response strings into structured document blocks.
final class GenerateDocumentUseCase {
  /// Creates a [GenerateDocumentUseCase].
  const GenerateDocumentUseCase();

  /// Parses raw streaming or completed AI markdown text into a sequence of [DocumentBlock]s.
  List<DocumentBlock> parseMarkdownToBlocks({
    required String documentId,
    required String markdownContent,
  }) {
    final lines = markdownContent.split('\n');
    final blocks = <DocumentBlock>[];
    var sortOrder = 0;

    for (final line in lines) {
      final trimmed = line.trim();
      if (trimmed.isEmpty) continue;

      var type = BlockType.paragraph;
      var textContent = trimmed;

      if (trimmed.startsWith('# ')) {
        type = BlockType.heading1;
        textContent = trimmed.substring(2).trim();
      } else if (trimmed.startsWith('## ')) {
        type = BlockType.heading2;
        textContent = trimmed.substring(3).trim();
      } else if (trimmed.startsWith('### ')) {
        type = BlockType.heading3;
        textContent = trimmed.substring(4).trim();
      } else if (trimmed.startsWith('- [ ] ') || trimmed.startsWith('* [ ] ')) {
        type = BlockType.todoList;
        textContent = trimmed.substring(6).trim();
      } else if (trimmed.startsWith('- ') || trimmed.startsWith('* ')) {
        type = BlockType.bulletList;
        textContent = trimmed.substring(2).trim();
      } else if (RegExp(r'^\d+\.\s').hasMatch(trimmed)) {
        type = BlockType.numberedList;
        textContent = trimmed.replaceFirst(RegExp(r'^\d+\.\s'), '').trim();
      } else if (trimmed.startsWith('> ')) {
        type = BlockType.quote;
        textContent = trimmed.substring(2).trim();
      } else if (trimmed.startsWith('💡 ')) {
        type = BlockType.callout;
        textContent = trimmed.substring(2).trim();
      } else if (trimmed.startsWith('```')) {
        type = BlockType.code;
        textContent = trimmed.replaceAll('```', '').trim();
      } else if (trimmed == '---' || trimmed == '***') {
        type = BlockType.divider;
        textContent = '';
      }

      blocks.add(
        DocumentBlock(
          id: '${documentId}_b_$sortOrder',
          documentId: documentId,
          type: type,
          textContent: textContent,
          sortOrder: sortOrder++,
        ),
      );
    }

    if (blocks.isEmpty) {
      blocks.add(
        DocumentBlock(
          id: '${documentId}_b_0',
          documentId: documentId,
          type: BlockType.paragraph,
          textContent: markdownContent,
          sortOrder: 0,
        ),
      );
    }

    return blocks;
  }
}
