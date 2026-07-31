/// Canvas Widget: BlockItemWidget (Master Block Wrapper).
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_block.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/canvas/block_renderers.dart';
import 'package:flutter/material.dart';

/// Master block wrapper with [RepaintBoundary] isolation, hover controls, and slash menu trigger.
class BlockItemWidget extends StatefulWidget {
  /// Creates a [BlockItemWidget].
  const BlockItemWidget({
    required this.block,
    required this.isSelected,
    required this.onTap,
    required this.onChanged,
    required this.onDelete,
    required this.onTriggerSlash,
    super.key,
  });

  final DocumentBlock block;
  final bool isSelected;
  final VoidCallback onTap;
  final ValueChanged<String> onChanged;
  final VoidCallback onDelete;
  final VoidCallback onTriggerSlash;

  @override
  State<BlockItemWidget> createState() => _BlockItemWidgetState();
}

class _BlockItemWidgetState extends State<BlockItemWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(6),
          hoverColor: AppColors.hoverOverlay,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: widget.isSelected
                    ? AppColors.secondary.withValues(alpha: 0.4)
                    : Colors.transparent,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hover Action Handle
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 150),
                  opacity: (_isHovered || widget.isSelected) ? 1.0 : 0.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.drag_indicator, size: 16, color: AppColors.onSurfaceVariant),
                        onPressed: () {},
                        tooltip: 'Drag block',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                      ),
                      IconButton(
                        icon: const Icon(Icons.auto_awesome, size: 14, color: AppColors.secondary),
                        onPressed: widget.onTriggerSlash,
                        tooltip: 'AI Actions (Type "/")',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 4),

                // Main Block Content Renderer
                Expanded(
                  child: _buildBlockContent(widget.block),
                ),

                // Delete handle on hover
                if (_isHovered)
                  IconButton(
                    icon: const Icon(Icons.close, size: 14, color: AppColors.danger),
                    onPressed: widget.onDelete,
                    tooltip: 'Delete Block',
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBlockContent(DocumentBlock block) {
    void handleTextChanged(String val) {
      if (val.trim() == '/') {
        widget.onTriggerSlash();
      }
      widget.onChanged(val);
    }

    switch (block.type) {
      case BlockType.heading1:
      case BlockType.heading2:
      case BlockType.heading3:
        return HeadingBlockWidget(block: block, onChanged: handleTextChanged);
      case BlockType.paragraph:
        return ParagraphBlockWidget(block: block, onChanged: handleTextChanged);
      case BlockType.bulletList:
      case BlockType.numberedList:
      case BlockType.todoList:
        return ListBlockWidget(block: block, onChanged: handleTextChanged);
      case BlockType.callout:
        return CalloutBlockWidget(block: block, onChanged: handleTextChanged);
      case BlockType.quote:
        return QuoteBlockWidget(block: block, onChanged: handleTextChanged);
      case BlockType.code:
        return CodeBlockWidget(block: block, onChanged: handleTextChanged);
      case BlockType.divider:
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(color: AppColors.outline, height: 1),
        );
      default:
        return ParagraphBlockWidget(block: block, onChanged: handleTextChanged);
    }
  }
}
