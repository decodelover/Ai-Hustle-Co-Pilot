/// Versioning Widget: VersionHistoryDrawer.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Version control history snapshot drawer.
class VersionHistoryDrawer extends ConsumerWidget {
  const VersionHistoryDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final versions = ref.watch(documentVersionsProvider);
    final controller = ref.read(documentEditorControllerProvider.notifier);

    return Container(
      width: 300,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(left: BorderSide(color: AppColors.outline)),
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: AppColors.outline)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Icon(Icons.history, size: 18, color: AppColors.secondary),
                    SizedBox(width: 8),
                    Text(
                      'Version History',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () => controller.toggleVersionDrawer(false),
                ),
              ],
            ),
          ),

          // Snapshot List
          Expanded(
            child: versions.isEmpty
                ? const Center(
                    child: Text(
                      'No version snapshots recorded yet.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: versions.length,
                    itemBuilder: (context, index) {
                      final ver = versions[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                          side: const BorderSide(color: AppColors.outline),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: ver.isAiGenerated
                                          ? AppColors.secondary.withValues(
                                              alpha: 0.1,
                                            )
                                          : AppColors.surfaceVariant,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'v${ver.versionNumber}',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                        color: ver.isAiGenerated
                                            ? AppColors.secondary
                                            : AppColors.onSurface,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '${ver.createdAt.hour}:${ver.createdAt.minute.toString().padLeft(2, '0')}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                ver.commitMessage,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${ver.snapshotBlocks.length} blocks • ${ver.isAiGenerated ? "AI Snapshot" : "Manual Commit"}',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Align(
                                alignment: Alignment.centerRight,
                                child: TextButton.icon(
                                  onPressed: () =>
                                      controller.restoreVersion(ver),
                                  icon: const Icon(Icons.restore, size: 14),
                                  label: const Text(
                                    'Restore Version',
                                    style: TextStyle(fontSize: 11),
                                  ),
                                  style: TextButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 4,
                                    ),
                                    minimumSize: Size.zero,
                                    tapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
