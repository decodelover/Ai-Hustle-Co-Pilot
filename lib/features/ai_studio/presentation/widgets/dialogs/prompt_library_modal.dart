/// Prompt Library Modal Dialog Component (Amendment 3.1M)
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/ai_workspace_providers.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/prompt_template.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Modal dialog for browsing and selecting prompt templates from the library.
class PromptLibraryModal extends ConsumerWidget {
  /// Creates a [PromptLibraryModal].
  const PromptLibraryModal({required this.onSelectPrompt, super.key});

  final ValueChanged<PromptTemplate> onSelectPrompt;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final aiRepo = ref.watch(aiStudioRepositoryProvider);

    return Dialog(
      backgroundColor: const Color(0xFF1E242E),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        width: 560.0,
        height: 520.0,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title Bar
            Row(
              children: [
                const Icon(
                  Icons.auto_awesome_motion_rounded,
                  color: AppColors.primary,
                  size: 22.0,
                ),
                const SizedBox(width: 10.0),
                const Text(
                  'Prompt Library',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                ),
              ],
            ),

            const SizedBox(height: 16.0),

            // Prompt List View
            Expanded(
              child: FutureBuilder<List<PromptTemplate>>(
                future: aiRepo.getPromptTemplates(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ),
                    );
                  }

                  final templates = snapshot.data!;

                  return ListView.builder(
                    itemCount: templates.length,
                    itemBuilder: (context, index) {
                      final template = templates[index];

                      return Card(
                        color: const Color(0xFF262D38),
                        margin: const EdgeInsets.only(bottom: 12.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: const BorderSide(color: Color(0xFF3D4655)),
                        ),
                        child: ListTile(
                          title: Text(
                            template.title,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            template.description,
                            style: const TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 12.0,
                            ),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: AppColors.primary,
                            size: 14.0,
                          ),
                          onTap: () {
                            onSelectPrompt(template);
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
