/// Presentation Screen: TemplateGalleryScreen.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:ai_hustle_copilot/features/documents/domain/entities/document_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Preset Document Template Selection Gallery.
class TemplateGalleryScreen extends ConsumerWidget {
  /// Creates a [TemplateGalleryScreen].
  const TemplateGalleryScreen({this.onSelectTemplate, super.key});

  final ValueChanged<DocumentTemplate>? onSelectTemplate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final templatesAsync = ref.watch(documentTemplatesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Document Templates Gallery'),
        backgroundColor: AppColors.surface,
      ),
      body: templatesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error loading templates: $e')),
        data: (templates) {
          return GridView.builder(
            padding: const EdgeInsets.all(24),
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 320,
              mainAxisExtent: 200,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: templates.length,
            itemBuilder: (context, index) {
              final tpl = templates[index];
              return Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: AppColors.outline),
                ),
                child: InkWell(
                  onTap: () {
                    if (onSelectTemplate != null) {
                      onSelectTemplate!(tpl);
                    }
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
                              tpl.iconName,
                              style: const TextStyle(fontSize: 28),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                tpl.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          tpl.description,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceVariant,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            tpl.category,
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: AppColors.secondary,
                            ),
                          ),
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
    );
  }
}
