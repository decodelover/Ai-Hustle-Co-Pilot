/// Presentation Screen: DocumentLibraryScreen (Document Studio Hub).
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/screens/template_gallery_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Central hub screen listing all user documents with template creation and search.
class DocumentLibraryScreen extends ConsumerStatefulWidget {
  /// Creates a [DocumentLibraryScreen].
  const DocumentLibraryScreen({this.projectId, super.key});

  final String? projectId;

  @override
  ConsumerState<DocumentLibraryScreen> createState() =>
      _DocumentLibraryScreenState();
}

class _DocumentLibraryScreenState extends ConsumerState<DocumentLibraryScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final docsAsync = ref.watch(documentListProvider(widget.projectId));
    final controller = ref.read(documentEditorControllerProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('AI Document Studio'),
        backgroundColor: AppColors.surface,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.dashboard_customize_outlined),
            tooltip: 'Templates Gallery',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => TemplateGalleryScreen(
                    onSelectTemplate: (template) async {
                      Navigator.of(context).pop();
                      await controller.createNewDocument(
                        projectId: widget.projectId,
                        template: template,
                      );
                      final active = ref.read(activeDocumentProvider);
                      if (active != null && context.mounted) {
                        context.go('${RoutePaths.documents}/${active.id}');
                      }
                    },
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 8),
            child: ElevatedButton.icon(
              onPressed: () async {
                await controller.createNewDocument(
                  projectId: widget.projectId,
                  title: 'New AI Document',
                );
                final active = ref.read(activeDocumentProvider);
                if (active != null && context.mounted) {
                  context.go('${RoutePaths.documents}/${active.id}');
                }
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('New Document'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryDarkBlue,
                foregroundColor: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search & Filter Header Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search documents by title or keyword...',
                prefixIcon: const Icon(Icons.search, size: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: AppColors.outline),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              onChanged: (val) =>
                  setState(() => _searchQuery = val.toLowerCase()),
            ),
          ),

          // Main Documents Grid / List
          Expanded(
            child: docsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) =>
                  Center(child: Text('Error loading documents: $e')),
              data: (documents) {
                final filtered = documents.where((d) {
                  return d.title.toLowerCase().contains(_searchQuery);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.description_outlined,
                          size: 48,
                          color: AppColors.onSurfaceVariant,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'No documents found',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Create a new document or pick an AI template to begin.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () async {
                            await controller.createNewDocument(
                              projectId: widget.projectId,
                              title: 'New AI Document',
                            );
                            final active = ref.read(activeDocumentProvider);
                            if (active != null && context.mounted) {
                              context.go(
                                '${RoutePaths.documents}/${active.id}',
                              );
                            }
                          },
                          icon: const Icon(Icons.add),
                          label: const Text('Create Document'),
                        ),
                      ],
                    ),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 340,
                    mainAxisExtent: 180,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final doc = filtered[index];
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: const BorderSide(color: AppColors.outline),
                      ),
                      child: InkWell(
                        onTap: () {
                          context.go('${RoutePaths.documents}/${doc.id}');
                        },
                        borderRadius: BorderRadius.circular(12),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    doc.emojiIcon ?? '📄',
                                    style: const TextStyle(fontSize: 28),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      doc.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.onSurface,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Text(
                                '${doc.blocks.length} Blocks • v${doc.currentVersionNumber}',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.surfaceVariant,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      doc.status.name.toUpperCase(),
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.secondary,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Updated ${doc.updatedAt.day}/${doc.updatedAt.month}',
                                    style: const TextStyle(
                                      fontSize: 11,
                                      color: AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
