/// AI Assistant Widget: AiActionChipGroup.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/domain/value_objects/ai_prompt_intent.dart';
import 'package:flutter/material.dart';

/// Interactive action chip group for quick AI assistant commands.
class AiActionChipGroup extends StatelessWidget {
  /// Creates an [AiActionChipGroup].
  const AiActionChipGroup({required this.onSelectIntent, super.key});

  final ValueChanged<AiPromptIntent> onSelectIntent;

  @override
  Widget build(BuildContext context) {
    final intents = [
      AiPromptIntent.rewrite,
      AiPromptIntent.expand,
      AiPromptIntent.summarize,
      AiPromptIntent.fixGrammar,
      AiPromptIntent.changeTone,
      AiPromptIntent.translate,
      AiPromptIntent.continueWriting,
      AiPromptIntent.generateSection,
    ];

    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: intents.map((intent) {
        return ActionChip(
          avatar: Icon(
            _getIconForIntent(intent),
            size: 12,
            color: AppColors.secondary,
          ),
          label: Text(intent.label),
          labelStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
          backgroundColor: AppColors.surfaceVariant,
          side: const BorderSide(color: AppColors.outline),
          onPressed: () => onSelectIntent(intent),
        );
      }).toList(),
    );
  }

  IconData _getIconForIntent(AiPromptIntent intent) => switch (intent) {
    AiPromptIntent.rewrite => Icons.refresh,
    AiPromptIntent.expand => Icons.unfold_more,
    AiPromptIntent.summarize => Icons.compress,
    AiPromptIntent.fixGrammar => Icons.spellcheck,
    AiPromptIntent.changeTone => Icons.tune,
    AiPromptIntent.translate => Icons.translate,
    AiPromptIntent.continueWriting => Icons.forward,
    AiPromptIntent.generateSection => Icons.add_circle_outline,
    AiPromptIntent.generateDocument => Icons.auto_awesome,
  };
}
