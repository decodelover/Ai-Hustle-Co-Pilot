/// Workspace Header Component (Amendment 3.1D, 3.1M)
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/model_selector_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Header bar for AI Workspace housing model selector, context window usage indicator, and prompt library trigger.
class WorkspaceHeader extends ConsumerWidget {
  /// Creates a [WorkspaceHeader].
  const WorkspaceHeader({
    required this.conversationTitle,
    required this.onOpenPromptLibrary,
    required this.onToggleSidebar,
    super.key,
    this.showSidebarToggle = false,
  });

  final String conversationTitle;
  final VoidCallback onOpenPromptLibrary;
  final VoidCallback onToggleSidebar;
  final bool showSidebarToggle;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelState = ref.watch(modelSelectorControllerProvider);
    final modelController = ref.read(modelSelectorControllerProvider.notifier);
    final selectedModel = modelState.selectedModel;

    return Container(
      height: 60.0,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: const BoxDecoration(
        color: Color(0xFF1E242E),
        border: Border(bottom: BorderSide(color: Color(0xFF2B323E))),
      ),
      child: Row(
        children: [
          // Sidebar Toggle Button (Mobile / Tablet)
          if (showSidebarToggle) ...[
            IconButton(
              onPressed: onToggleSidebar,
              icon: const Icon(
                Icons.menu_rounded,
                color: Colors.white,
                size: 20.0,
              ),
            ),
            const SizedBox(width: 8.0),
          ],

          // Title
          Expanded(
            child: Text(
              conversationTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Context Window Usage Bar
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 4.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF262D38),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                Container(
                  width: 8.0,
                  height: 8.0,
                  decoration: const BoxDecoration(
                    color: Color(0xFF10B981),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 6.0),
                Text(
                  selectedModel?.contextWindowLabel ?? '128k tokens',
                  style: const TextStyle(
                    color: Color(0xFF94A3B8),
                    fontSize: 11.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12.0),

          // AI Model Selector Dropdown
          Container(
            height: 36.0,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            decoration: BoxDecoration(
              color: const Color(0xFF262D38),
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: const Color(0xFF3D4655)),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: modelState.selectedModelId,
                dropdownColor: const Color(0xFF2B323E),
                icon: const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.white70,
                  size: 18.0,
                ),
                items: modelState.models.map((model) {
                  return DropdownMenuItem<String>(
                    value: model.id,
                    child: Text(
                      model.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (val) {
                  if (val != null) {
                    modelController.selectModel(val);
                  }
                },
              ),
            ),
          ),

          const SizedBox(width: 12.0),

          // Prompt Library Trigger Button
          IconButton(
            onPressed: onOpenPromptLibrary,
            tooltip: 'Prompt Library (Cmd + Shift + P)',
            icon: const Icon(
              Icons.auto_awesome_motion_rounded,
              color: AppColors.primary,
              size: 20.0,
            ),
          ),
        ],
      ),
    );
  }
}
