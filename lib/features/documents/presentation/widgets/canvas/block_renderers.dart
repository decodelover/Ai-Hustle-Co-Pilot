/// Canvas Widgets: Heading, Paragraph, List, Callout, Quote, Code Block Renderers.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:flutter/material.dart';

/// Renders H1, H2, or H3 heading blocks.
class HeadingBlockWidget extends StatelessWidget {
  /// Creates a [HeadingBlockWidget].
  const HeadingBlockWidget({
    required this.block,
    required this.onChanged,
    super.key,
  });

  final DocumentBlock block;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final style = switch (block.type) {
      BlockType.heading1 => const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w800,
        color: AppColors.onSurface,
        letterSpacing: -0.5,
      ),
      BlockType.heading2 => const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.onSurface,
        letterSpacing: -0.3,
      ),
      _ => const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
    };

    return TextFormField(
      initialValue: block.textContent,
      style: style,
      decoration: InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText:
            'Heading ${block.type == BlockType.heading1
                ? "1"
                : block.type == BlockType.heading2
                ? "2"
                : "3"}',
        hintStyle: style.copyWith(
          color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
        ),
      ),
      onChanged: onChanged,
    );
  }
}

/// Renders standard rich-text paragraph blocks.
class ParagraphBlockWidget extends StatelessWidget {
  /// Creates a [ParagraphBlockWidget].
  const ParagraphBlockWidget({
    required this.block,
    required this.onChanged,
    super.key,
  });

  final DocumentBlock block;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: block.textContent,
      maxLines: null,
      style: const TextStyle(
        fontSize: 15,
        height: 1.6,
        color: AppColors.onSurface,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        isDense: true,
        hintText: 'Type text or press "/" for AI commands...',
        hintStyle: TextStyle(fontSize: 15, color: AppColors.onSurfaceVariant),
      ),
      onChanged: onChanged,
    );
  }
}

/// Renders Bullet, Numbered, or Checkbox list item blocks.
class ListBlockWidget extends StatelessWidget {
  /// Creates a [ListBlockWidget].
  const ListBlockWidget({
    required this.block,
    required this.onChanged,
    super.key,
  });

  final DocumentBlock block;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    final prefixWidget = switch (block.type) {
      BlockType.bulletList => const Padding(
        padding: EdgeInsets.only(right: 8, top: 4),
        child: Icon(Icons.circle, size: 6, color: AppColors.primary),
      ),
      BlockType.numberedList => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Text(
          '${block.sortOrder + 1}.',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
      ),
      BlockType.todoList => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: Checkbox(
          value: block.attributes['checked'] == true,
          activeColor: AppColors.success,
          onChanged: (_) {},
        ),
      ),
      _ => const SizedBox.shrink(),
    };

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        prefixWidget,
        Expanded(
          child: TextFormField(
            initialValue: block.textContent,
            style: const TextStyle(fontSize: 15, color: AppColors.onSurface),
            decoration: const InputDecoration(
              border: InputBorder.none,
              isDense: true,
              hintText: 'List item...',
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

/// Renders callout box with icon and subtle fill.
class CalloutBlockWidget extends StatelessWidget {
  /// Creates a [CalloutBlockWidget].
  const CalloutBlockWidget({
    required this.block,
    required this.onChanged,
    super.key,
  });

  final DocumentBlock block;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryDarkBlue.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: AppColors.primaryDarkBlue.withValues(alpha: 0.1),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('💡', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              initialValue: block.textContent,
              maxLines: null,
              style: const TextStyle(
                fontSize: 14,
                height: 1.5,
                color: AppColors.onSurface,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                hintText: 'Callout text...',
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Renders blockquotes with left border.
class QuoteBlockWidget extends StatelessWidget {
  /// Creates a [QuoteBlockWidget].
  const QuoteBlockWidget({
    required this.block,
    required this.onChanged,
    super.key,
  });

  final DocumentBlock block;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 14, top: 4, bottom: 4),
      decoration: const BoxDecoration(
        border: Border(left: BorderSide(color: AppColors.secondary, width: 3)),
      ),
      child: TextFormField(
        initialValue: block.textContent,
        maxLines: null,
        style: const TextStyle(
          fontSize: 15,
          fontStyle: FontStyle.italic,
          color: AppColors.onSurfaceVariant,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: 'Quote text...',
        ),
        onChanged: onChanged,
      ),
    );
  }
}

/// Renders formatted code block snippet.
class CodeBlockWidget extends StatelessWidget {
  /// Creates a [CodeBlockWidget].
  const CodeBlockWidget({
    required this.block,
    required this.onChanged,
    super.key,
  });

  final DocumentBlock block;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.primaryDarkBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        initialValue: block.textContent,
        maxLines: null,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 13,
          color: Color(0xFFF8FAFC),
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: '// Write code or snippet...',
          hintStyle: TextStyle(color: Color(0xFF94A3B8)),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
