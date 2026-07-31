/// Master AI Workspace Screen (Phase 3.1)
library;

import 'package:ai_hustle_copilot/features/ai_studio/application/conversation_controller.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/chat/message_list_view.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/composer/message_composer_pro.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/dialogs/prompt_library_modal.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/header/workspace_header.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/sidebar/conversation_sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Master AI Studio Screen implementing responsive 1, 2, and 3-pane layouts across Phone, Tablet, Desktop, and UltraWide screens.
class AiStudioScreen extends ConsumerStatefulWidget {
  /// Creates an [AiStudioScreen].
  const AiStudioScreen({super.key});

  @override
  ConsumerState<AiStudioScreen> createState() => _AiStudioScreenState();
}

class _AiStudioScreenState extends ConsumerState<AiStudioScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _openPromptLibrary() {
    showDialog<void>(
      context: context,
      builder: (context) => PromptLibraryModal(
        onSelectPrompt: (template) {
          final activeId = ref
              .read(conversationControllerProvider)
              .activeConversationId;
          if (activeId != null) {
            // Trigger prompt insertion
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final width = mediaQuery.size.width;

    final isPhone = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024 && width < 1440;
    final isUltraWide = width >= 1440;

    final convState = ref.watch(conversationControllerProvider);
    final activeId = convState.activeConversationId ?? 'conv-1';
    final activeConv = convState.conversations.isEmpty
        ? null
        : convState.conversations.firstWhere(
            (c) => c.id == activeId,
            orElse: () => convState.conversations.first,
          );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: const Color(0xFF141820),
      drawer: isPhone || isTablet
          ? Drawer(
              backgroundColor: const Color(0xFF1E242E),
              child: ConversationSidebar(
                onConversationSelected: () => Navigator.of(context).pop(),
              ),
            )
          : null,
      body: Row(
        children: [
          // ── Left Sidebar (Desktop & UltraWide) ───────────────────────────
          if (isDesktop || isUltraWide) const ConversationSidebar(),

          // ── Main Center Chat Canvas ──────────────────────────────────────
          Expanded(
            child: Column(
              children: [
                // Header Bar
                WorkspaceHeader(
                  conversationTitle: activeConv?.title ?? 'AI Workspace',
                  onOpenPromptLibrary: _openPromptLibrary,
                  showSidebarToggle: isPhone || isTablet,
                  onToggleSidebar: () {
                    _scaffoldKey.currentState?.openDrawer();
                  },
                ),

                // Virtualized Message Thread
                Expanded(child: MessageListView(conversationId: activeId)),

                // AI Composer Pro
                MessageComposerPro(
                  conversationId: activeId,
                  onOpenPromptLibrary: _openPromptLibrary,
                ),
              ],
            ),
          ),

          // ── Right Context & Token Stats Panel (UltraWide Only) ───────────
          if (isUltraWide)
            Container(
              width: 320.0,
              height: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFF1E242E),
                border: Border(left: BorderSide(color: Color(0xFF2B323E))),
              ),
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Workspace Metrics',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  _MetricCard(
                    title: 'Active Context Model',
                    value: activeConv?.modelId.toUpperCase() ?? 'GPT-4O',
                    icon: Icons.memory_rounded,
                  ),
                  const SizedBox(height: 12.0),
                  const _MetricCard(
                    title: 'Tokens Used (This Session)',
                    value: '1,420 tokens',
                    icon: Icons.analytics_rounded,
                  ),
                  const SizedBox(height: 12.0),
                  const _MetricCard(
                    title: 'System Latency',
                    value: '16ms frame-budget',
                    icon: Icons.speed_rounded,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  final String title;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: const Color(0xFF262D38),
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: const Color(0xFF3D4655)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF3D82F7), size: 20.0),
          const SizedBox(width: 12.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 11.0,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
