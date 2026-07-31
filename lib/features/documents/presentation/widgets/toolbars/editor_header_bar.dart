/// Toolbar Widget: EditorHeaderBar.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/dialogs/document_export_modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Header bar for the Document Editor with autosave state, version timeline toggle, export button, and AI sidebar toggle.
class EditorHeaderBar extends ConsumerWidget implements PreferredSizeWidget {
  /// Creates an [EditorHeaderBar].
  const EditorHeaderBar({
    required this.document,
    super.key,
  });

  final Document document;

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAutosaving = ref.watch(isAutosavingProvider);
    final isAiPanelOpen = ref.watch(isAiPanelOpenProvider);
    final isVersionOpen = ref.watch(isVersionDrawerOpenProvider);
    final controller = ref.read(documentEditorControllerProvider.notifier);

    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(bottom: BorderSide(color: AppColors.outline)),
      ),
      child: Row(
        children: [
          // Document Status Badge & Title Breadcrumb
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.surfaceVariant,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(document.emojiIcon ?? '📄', style: const TextStyle(fontSize: 14)),
                const SizedBox(width: 6),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 200),
                  child: Text(
                    document.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),

          // Autosave / Sync Indicator
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isAutosaving) ...[
                const SizedBox(
                  width: 12,
                  height: 12,
                  child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.secondary),
                ),
                const SizedBox(width: 6),
                const Text('Autosaving...', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
              ] else ...[
                const Icon(Icons.check_circle_outline, size: 14, color: AppColors.success),
                const SizedBox(width: 4),
                const Text('Saved', style: TextStyle(fontSize: 12, color: AppColors.onSurfaceVariant)),
              ],
            ],
          ),

          const Spacer(),

          // Version Snapshot History Toggle Button
          IconButton(
            icon: Icon(
              Icons.history,
              color: isVersionOpen ? AppColors.secondary : AppColors.onSurfaceVariant,
            ),
            tooltip: 'Version History (v${document.currentVersionNumber})',
            onPressed: () => controller.toggleVersionDrawer(!isVersionOpen),
          ),

          // Export Document Button
          OutlinedButton.icon(
            onPressed: () {
              showDialog<void>(
                context: context,
                builder: (_) => DocumentExportModal(document: document),
              );
            },
            icon: const Icon(Icons.download, size: 16),
            label: const Text('Export'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(width: 8),

          // AI Panel Sidebar Toggle Button
          IconButton(
            icon: Icon(
              Icons.auto_awesome,
              color: isAiPanelOpen ? AppColors.secondary : AppColors.onSurfaceVariant,
            ),
            tooltip: isAiPanelOpen ? 'Close AI Assistant' : 'Open AI Assistant',
            onPressed: () => controller.toggleAiPanel(!isAiPanelOpen),
          ),
        ],
      ),
    );
  }
}
