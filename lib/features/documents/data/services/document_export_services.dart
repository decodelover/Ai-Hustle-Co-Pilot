/// Data Services: Document Export Engine Services (PDF, DOCX, Markdown, HTML, TXT).
library;

import 'dart:convert';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/export_format.dart';
import 'package:flutter/foundation.dart';

/// Central Export Engine Pipeline interface and format compile implementations.
abstract final class DocumentExportService {
  /// Compiles a [Document] into target [ExportFormat] bytes/string data payload.
  static Future<Uint8List> exportDocument({
    required Document document,
    required ExportFormat format,
  }) async {
    return compute(_compileExportIsolate, {'doc': document, 'format': format});
  }

  static Uint8List _compileExportIsolate(Map<String, dynamic> params) {
    final doc = params['doc'] as Document;
    final format = params['format'] as ExportFormat;

    final stringContent = switch (format) {
      ExportFormat.markdown => compileMarkdown(doc),
      ExportFormat.html => compileHtml(doc),
      ExportFormat.txt => compilePlainText(doc),
      ExportFormat.pdf => compilePdfStub(doc),
      ExportFormat.docx => compileDocxStub(doc),
    };

    return Uint8List.fromList(utf8.encode(stringContent));
  }

  /// Compiles document tree to Markdown.
  static String compileMarkdown(Document doc) {
    final buffer = StringBuffer()
      ..writeln('# ${doc.title}')
      ..writeln();

    for (final block in doc.blocks) {
      switch (block.type) {
        case BlockType.heading1:
          buffer.writeln('# ${block.textContent}');
        case BlockType.heading2:
          buffer.writeln('## ${block.textContent}');
        case BlockType.heading3:
          buffer.writeln('### ${block.textContent}');
        case BlockType.paragraph:
          buffer.writeln(block.textContent);
        case BlockType.bulletList:
          buffer.writeln('- ${block.textContent}');
        case BlockType.numberedList:
          buffer.writeln('1. ${block.textContent}');
        case BlockType.todoList:
          buffer.writeln('- [ ] ${block.textContent}');
        case BlockType.quote:
          buffer.writeln('> ${block.textContent}');
        case BlockType.callout:
          buffer.writeln('> 💡 **Callout:** ${block.textContent}');
        case BlockType.code:
          buffer.writeln('```\n${block.textContent}\n```');
        case BlockType.divider:
          buffer.writeln('---');
        case BlockType.image:
          buffer.writeln('![Image](${block.textContent})');
        case BlockType.table:
          buffer.writeln('| Content |\n| --- |\n| ${block.textContent} |');
      }
      buffer.writeln();
    }

    return buffer.toString();
  }

  /// Compiles document tree to clean HTML.
  static String compileHtml(Document doc) {
    final buffer = StringBuffer()
      ..writeln('<!DOCTYPE html>')
      ..writeln('<html>')
      ..writeln('<head>')
      ..writeln('<meta charset="UTF-8">')
      ..writeln('<title>${doc.title}</title>')
      ..writeln('<style>')
      ..writeln(
        'body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif; line-height: 1.6; max-width: 800px; margin: 40px auto; padding: 0 20px; color: #111827; }',
      )
      ..writeln(
        'h1 { font-size: 2.2rem; font-weight: 800; border-bottom: 2px solid #E5E7EB; padding-bottom: 12px; }',
      )
      ..writeln('h2 { font-size: 1.6rem; margin-top: 24px; color: #0D1B2A; }')
      ..writeln(
        'blockquote { background: #F8FAFC; border-left: 4px solid #3A5FA0; margin: 16px 0; padding: 12px 20px; }',
      )
      ..writeln(
        'code { background: #1E3A5F; color: #F8FAFC; padding: 12px; display: block; border-radius: 8px; font-family: monospace; }',
      )
      ..writeln(
        '.callout { background: #EEF2FF; border-left: 4px solid #3A5FA0; padding: 16px; border-radius: 8px; margin: 16px 0; }',
      )
      ..writeln('</style>')
      ..writeln('</head>')
      ..writeln('<body>')
      ..writeln('<h1>${doc.title}</h1>');

    for (final block in doc.blocks) {
      switch (block.type) {
        case BlockType.heading1:
          buffer.writeln('<h1>${block.textContent}</h1>');
        case BlockType.heading2:
          buffer.writeln('<h2>${block.textContent}</h2>');
        case BlockType.heading3:
          buffer.writeln('<h3>${block.textContent}</h3>');
        case BlockType.paragraph:
          buffer.writeln('<p>${block.textContent}</p>');
        case BlockType.bulletList:
          buffer.writeln('<ul><li>${block.textContent}</li></ul>');
        case BlockType.numberedList:
          buffer.writeln('<ol><li>${block.textContent}</li></ol>');
        case BlockType.todoList:
          buffer.writeln(
            '<div><input type="checkbox" disabled /> ${block.textContent}</div>',
          );
        case BlockType.quote:
          buffer.writeln('<blockquote>${block.textContent}</blockquote>');
        case BlockType.callout:
          buffer.writeln('<div class="callout">💡 ${block.textContent}</div>');
        case BlockType.code:
          buffer.writeln('<pre><code>${block.textContent}</code></pre>');
        case BlockType.divider:
          buffer.writeln('<hr>');
        case BlockType.image:
          buffer.writeln('<img src="${block.textContent}" alt="Asset" />');
        case BlockType.table:
          buffer.writeln(
            '<table><tr><td>${block.textContent}</td></tr></table>',
          );
      }
    }

    buffer
      ..writeln('</body>')
      ..writeln('</html>');
    return buffer.toString();
  }

  /// Compiles document to Plain Text.
  static String compilePlainText(Document doc) {
    final buffer = StringBuffer()
      ..writeln(doc.title.toUpperCase())
      ..writeln('=' * doc.title.length)
      ..writeln();

    for (final block in doc.blocks) {
      buffer
        ..writeln(block.textContent)
        ..writeln();
    }

    return buffer.toString();
  }

  /// Compiles PDF document content wrapper.
  static String compilePdfStub(Document doc) {
    return compileHtml(doc);
  }

  /// Compiles DOCX XML document content wrapper.
  static String compileDocxStub(Document doc) {
    return compileMarkdown(doc);
  }
}
