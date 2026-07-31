/// Presentation Screen: DocumentEditorScreen (Phase 3.4 Master Workspace).
library;

import 'package:ai_hustle_copilot/core/theme/app_breakpoints.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/documents/application/providers/document_providers.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/ai_assistant/ai_writing_assistant_panel.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/canvas/document_block_canvas.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/toolbars/editor_header_bar.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/widgets/versioning/version_history_drawer.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Full-screen production editor supporting responsive 3-panel layout, AI streaming, version control, and block editing.
class DocumentEditorScreen extends ConsumerStatefulWidget {
  /// Creates a [DocumentEditorScreen].
  const DocumentEditorScreen({
    required this.documentId,
    this.projectContext,
    super.key,
  });

  final String documentId;
  final Project? projectContext;

  @override
  ConsumerState<DocumentEditorScreen> createState() => _DocumentEditorScreenState();
}

class _DocumentEditorScreenState extends ConsumerState<DocumentEditorScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(documentEditorControllerProvider.notifier).loadDocument(widget.documentId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(documentEditorControllerProvider);
    final isAiPanelOpen = ref.watch(isAiPanelOpenProvider);
    final isVersionOpen = ref.watch(isVersionDrawerOpenProvider);
    final screenWidth = MediaQuery.sizeOf(context).width;
    final isMobile = AppBreakpoints.isCompactWidth(screenWidth);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: asyncState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.secondary),
        ),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: AppColors.danger),
              const SizedBox(height: 12),
              Text(
                'Error loading document: $err',
                style: const TextStyle(color: AppColors.danger),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref
                    .read(documentEditorControllerProvider.notifier)
                    .loadDocument(widget.documentId),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
        data: (editorState) {
          final doc = editorState.document;
          if (doc == null) {
            return const Center(child: Text('Document not found'));
          }

          return Column(
            children: [
              // Top Header Bar
              EditorHeaderBar(document: doc),

              // Main Responsive Body Area
              Expanded(
                child: Row(
                  children: [
                    // Center Document Canvas
                    Expanded(
                      child: DocumentBlockCanvas(document: doc),
                    ),

                    // Version History Drawer (if open)
                    if (isVersionOpen) const VersionHistoryDrawer(),

                    // Desktop / Tablet Right AI Assistant Sidebar
                    if (!isMobile && isAiPanelOpen)
                      AiWritingAssistantPanel(projectContext: widget.projectContext),
                  ],
                ),
              ),
            ],
          );
        },
      ),

      // Mobile Bottom Sheet AI Assistant Trigger Floating Action Button
      floatingActionButton: isMobile
          ? FloatingActionButton.extended(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  builder: (_) => SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.85,
                    child: AiWritingAssistantPanel(projectContext: widget.projectContext),
                  ),
                );
              },
              backgroundColor: AppColors.primaryDarkBlue,
              icon: const Icon(Icons.auto_awesome, color: Colors.white),
              label: const Text('AI Assistant', style: TextStyle(color: Colors.white)),
            )
          : null,
    );
  }
}
