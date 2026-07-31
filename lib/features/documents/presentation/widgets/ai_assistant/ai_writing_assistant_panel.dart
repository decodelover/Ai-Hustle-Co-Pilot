/// AI Assistant Widget: AiWritingAssistantPanel.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/ai_prompt_intent.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/ai_assistant/ai_action_chip_group.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/ai_assistant/ai_context_indicator_bar.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Desktop right panel / mobile bottom sheet AI writing assistant.
class AiWritingAssistantPanel extends ConsumerStatefulWidget {
  /// Creates an [AiWritingAssistantPanel].
  const AiWritingAssistantPanel({this.projectContext, super.key});

  final Project? projectContext;

  @override
  ConsumerState<AiWritingAssistantPanel> createState() =>
      _AiWritingAssistantPanelState();
}

class _AiWritingAssistantPanelState
    extends ConsumerState<AiWritingAssistantPanel> {
  final TextEditingController _promptController = TextEditingController();

  @override
  void dispose() {
    _promptController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isGenerating = ref.watch(isAiGeneratingProvider);
    final selectedBlockId = ref.watch(selectedBlockIdProvider);
    final controller = ref.read(documentEditorControllerProvider.notifier);

    return Container(
      width: 320,
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(left: BorderSide(color: AppColors.outline)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                const Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.auto_awesome,
                        size: 18,
                        color: AppColors.secondary,
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'AI Writing Assistant',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 16),
                  onPressed: () => controller.toggleAiPanel(false),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Project RAG Context Indicator
                AiContextIndicatorBar(project: widget.projectContext),
                const SizedBox(height: 16),

                // Selected Block Target Info
                if (selectedBlockId != null)
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.gps_fixed,
                          size: 14,
                          color: AppColors.secondary,
                        ),
                        const SizedBox(width: 6),
                        const Expanded(
                          child: Text(
                            'Targeting selected block',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.onSurface,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () => controller.selectBlock(null),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(40, 20),
                          ),
                          child: const Text(
                            'Clear',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ],
                    ),
                  ),

                const SizedBox(height: 16),

                // Prompt Input Box
                const Text(
                  'AI DIRECTIVE OR INSTRUCTION',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _promptController,
                  maxLines: 3,
                  style: const TextStyle(fontSize: 13),
                  decoration: InputDecoration(
                    hintText:
                        'e.g. Write an executive summary outlining key metrics...',
                    hintStyle: const TextStyle(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),

                const SizedBox(height: 12),

                // Generate Button
                ElevatedButton.icon(
                  onPressed: isGenerating
                      ? null
                      : () {
                          if (_promptController.text.trim().isEmpty) return;
                          controller.generateWithAi(
                            intent: AiPromptIntent.generateDocument,
                            userPrompt: _promptController.text.trim(),
                            projectContext: widget.projectContext,
                            targetBlockId: selectedBlockId,
                          );
                        },
                  icon: isGenerating
                      ? const SizedBox(
                          width: 14,
                          height: 14,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.auto_awesome, size: 16),
                  label: Text(
                    isGenerating ? 'Streaming Content...' : 'Generate with AI',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryDarkBlue,
                    foregroundColor: Colors.white,
                    minimumSize: const Size.fromHeight(42),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Quick Action Chips
                const Text(
                  'QUICK ACTIONS',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 10),
                AiActionChipGroup(
                  onSelectIntent: (intent) {
                    controller.generateWithAi(
                      intent: intent,
                      userPrompt: _promptController.text.isNotEmpty
                          ? _promptController.text
                          : intent.label,
                      projectContext: widget.projectContext,
                      targetBlockId: selectedBlockId,
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
