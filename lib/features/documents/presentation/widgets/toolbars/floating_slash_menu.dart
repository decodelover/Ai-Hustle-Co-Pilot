/// Toolbar Widget: FloatingSlashMenu (Notion-style "/" Command Palette).
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:flutter/material.dart';

/// Floating slash menu popup allowing users to convert blocks or trigger AI creation commands.
class FloatingSlashMenu extends StatelessWidget {
  /// Creates a [FloatingSlashMenu].
  const FloatingSlashMenu({
    required this.onSelectType,
    required this.onClose,
    super.key,
  });

  final ValueChanged<BlockType> onSelectType;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final items = [
      (BlockType.heading1, 'Heading 1', 'Large section heading', Icons.title),
      (
        BlockType.heading2,
        'Heading 2',
        'Medium subsection heading',
        Icons.format_size,
      ),
      (
        BlockType.heading3,
        'Heading 3',
        'Small subsection heading',
        Icons.text_fields,
      ),
      (BlockType.paragraph, 'Paragraph', 'Plain text block', Icons.short_text),
      (
        BlockType.bulletList,
        'Bullet List',
        'Unordered bullet points',
        Icons.format_list_bulleted,
      ),
      (
        BlockType.numberedList,
        'Numbered List',
        'Sequential ordered list',
        Icons.format_list_numbered,
      ),
      (
        BlockType.todoList,
        'To-Do Checkbox',
        'Task list with checkboxes',
        Icons.check_box_outlined,
      ),
      (
        BlockType.callout,
        'Callout Box',
        'Highlighted callout container',
        Icons.lightbulb_outline,
      ),
      (BlockType.quote, 'Quote', 'Stylized blockquote', Icons.format_quote),
      (
        BlockType.code,
        'Code Snippet',
        'Formatted code snippet block',
        Icons.code,
      ),
      (
        BlockType.divider,
        'Divider Line',
        'Visual horizontal line',
        Icons.horizontal_rule,
      ),
    ];

    return Container(
      width: 280,
      constraints: const BoxConstraints(maxHeight: 340),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.outline),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1F0D1B2A),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'BASIC BLOCKS & ACTIONS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: onClose,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1, color: AppColors.outline),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 4),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ListTile(
                  dense: true,
                  leading: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(item.$4, size: 16, color: AppColors.primary),
                  ),
                  title: Text(
                    item.$2,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                  subtitle: Text(
                    item.$3,
                    style: const TextStyle(
                      fontSize: 11,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  onTap: () => onSelectType(item.$1),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
