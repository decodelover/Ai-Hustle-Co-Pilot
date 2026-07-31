/// MarkdownMessageView — Custom Markdown & Code Highlighting (Amendment 3.2E & UI)
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Clean Markdown view with syntax code blocks and copy functionality.
class MarkdownMessageView extends StatelessWidget {
  /// Creates a [MarkdownMessageView].
  const MarkdownMessageView({
    required this.content,
    super.key,
    this.textColor = const Color(0xFF111827),
  });

  /// Raw markdown text content.
  final String content;

  /// Text color.
  final Color textColor;

  void _copyToClipboard(BuildContext context, String code) {
    Clipboard.setData(ClipboardData(text: code));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code copied to clipboard!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Basic code block splitting parsing for demonstration
    final isCodeBlock = content.contains('```');
    if (!isCodeBlock) {
      return SelectableText(
        content,
        style: TextStyle(
          color: textColor,
          fontSize: 14.5,
          height: 1.5,
          fontWeight: FontWeight.w400,
        ),
      );
    }

    final parts = content.split('```');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts.map((part) {
        final trimmed = part.trim();
        if (trimmed.isEmpty) return const SizedBox.shrink();

        final lines = trimmed.split('\n');
        final firstLine = lines.isNotEmpty ? lines.first.trim() : '';
        final isLangHeader = firstLine.length <= 15 && !firstLine.contains(' ');

        if (isLangHeader && lines.length > 1) {
          final codeBody = lines.sublist(1).join('\n');
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFF0D1B2A),
              borderRadius: BorderRadius.circular(16.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Code block top header bar
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  decoration: const BoxDecoration(
                    color: Color(0xFF152A4D),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        firstLine.toUpperCase(),
                        style: const TextStyle(
                          color: Color(0xFF3A5FA0),
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      InkWell(
                        onTap: () => _copyToClipboard(context, codeBody),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.copy_rounded,
                              color: Colors.white,
                              size: 14.0,
                            ),
                            SizedBox(width: 4.0),
                            Text(
                              'Copy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SelectableText(
                    codeBody,
                    style: const TextStyle(
                      fontFamily: 'FiraCode',
                      color: Color(0xFFF8FAFC),
                      fontSize: 13.0,
                      height: 1.4,
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: SelectableText(
            trimmed,
            style: TextStyle(color: textColor, fontSize: 14.5, height: 1.5),
          ),
        );
      }).toList(),
    );
  }
}
