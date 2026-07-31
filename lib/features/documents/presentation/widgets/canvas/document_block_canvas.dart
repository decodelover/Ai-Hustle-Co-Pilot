/// Canvas Widget: DocumentBlockCanvas.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/block_type.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/canvas/block_item_widget.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/toolbars/floating_slash_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Central virtualized canvas rendering document cover, title, and block tree.
class DocumentBlockCanvas extends ConsumerWidget {
  /// Creates a [DocumentBlockCanvas].
  const DocumentBlockCanvas({
    required this.document,
    super.key,
  });

  final Document document;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedBlockId = ref.watch(selectedBlockIdProvider);
    final isSlashOpen = ref.watch(isSlashMenuOpenProvider);
    final controller = ref.read(documentEditorControllerProvider.notifier);

    return Stack(
      children: [
        SelectionArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            children: [
              // Emoji & Title Section
              Row(
                children: [
                  Text(
                    document.emojiIcon ?? '📄',
                    style: const TextStyle(fontSize: 40),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      initialValue: document.title,
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w800,
                        color: AppColors.onSurface,
                        letterSpacing: -0.5,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Untitled AI Document',
                      ),
                      onChanged: controller.updateTitle,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Block Tree Virtualized List
              ...document.blocks.map((block) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: BlockItemWidget(
                    key: ValueKey(block.id),
                    block: block,
                    isSelected: selectedBlockId == block.id,
                    onTap: () => controller.selectBlock(block.id),
                    onChanged: (val) {
                      controller.updateBlock(block.copyWith(textContent: val));
                    },
                    onDelete: () => controller.deleteBlock(block.id),
                    onTriggerSlash: () {
                      controller
                        ..selectBlock(block.id)
                        ..toggleSlashMenu(true);
                    },
                  ),
                );
              }),

              const SizedBox(height: 16),

              // Click-to-add Paragraph Button
              OutlinedButton.icon(
                onPressed: () => controller.addBlock(BlockType.paragraph),
                icon: const Icon(Icons.add, size: 16),
                label: const Text('Add Block (or type "/")'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.onSurfaceVariant,
                  side: BorderSide(color: AppColors.outline.withValues(alpha: 0.5)),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              const SizedBox(height: 60),
            ],
          ),
        ),

        // Floating Slash Menu Overlay
        if (isSlashOpen)
          Positioned(
            left: 60,
            top: 140,
            child: FloatingSlashMenu(
              onSelectType: (type) {
                controller
                  ..addBlock(type)
                  ..toggleSlashMenu(false);
              },
              onClose: () => controller.toggleSlashMenu(false),
            ),
          ),
      ],
    );
  }
}
