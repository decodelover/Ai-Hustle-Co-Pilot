/// Conversation Sidebar Component (Amendment 3.1H, 3.1I, 3.1M)
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/conversation_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Enterprise Conversation Sidebar supporting search, folders, pinning, and new chat creation.
class ConversationSidebar extends ConsumerWidget {
  /// Creates a [ConversationSidebar].
  const ConversationSidebar({
    super.key,
    this.onConversationSelected,
  });

  /// Optional callback when a conversation is tapped (for mobile drawer closure).
  final VoidCallback? onConversationSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(conversationControllerProvider);
    final controller = ref.read(conversationControllerProvider.notifier);

    return Container(
      width: 290.0,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFF1E242E),
        border: Border(
          right: BorderSide(
            color: Color(0xFF2B323E),
          ),
        ),
      ),
      child: Column(
        children: [
          // ── Header: New Chat Button ──────────────────────────────────────
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 44.0,
              child: ElevatedButton.icon(
                onPressed: () async {
                  await controller.createNewConversation();
                  onConversationSelected?.call();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                icon: const Icon(Icons.add_rounded, size: 20.0),
                label: const Text(
                  'New Chat',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),

          // ── Search Input ────────────────────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              onChanged: controller.updateSearchQuery,
              style: const TextStyle(color: Colors.white, fontSize: 13.0),
              decoration: InputDecoration(
                hintText: 'Search chats (Cmd + K)...',
                hintStyle: const TextStyle(
                  color: Color(0xFF777777),
                  fontSize: 13.0,
                ),
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  color: Color(0xFF777777),
                  size: 18.0,
                ),
                filled: true,
                fillColor: const Color(0xFF262D38),
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12.0),

          // ── Conversation List (Pinned + Recent) ─────────────────────────
          Expanded(
            child: state.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2.0,
                    ),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    children: [
                      // Pinned Group
                      if (state.pinnedConversations.isNotEmpty) ...[
                        const Padding(
                          padding: EdgeInsets.only(
                            left: 12.0,
                            top: 8.0,
                            bottom: 6.0,
                          ),
                          child: Text(
                            'PINNED',
                            style: TextStyle(
                              color: Color(0xFF777777),
                              fontSize: 11.0,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                        ),
                        ...state.pinnedConversations.map(
                          (conv) => _SidebarItem(
                            title: conv.title,
                            isPinned: true,
                            isSelected: conv.id == state.activeConversationId,
                            onTap: () {
                              controller.selectConversation(conv.id);
                              onConversationSelected?.call();
                            },
                            onPinToggle: () => controller.togglePin(conv.id),
                            onDelete: () =>
                                controller.deleteConversation(conv.id),
                          ),
                        ),
                        const Divider(
                          color: Color(0xFF2B323E),
                          height: 24.0,
                          indent: 8.0,
                          endIndent: 8.0,
                        ),
                      ],

                      // Recent Group
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 12.0,
                          top: 4.0,
                          bottom: 6.0,
                        ),
                        child: Text(
                          'RECENT CHATS',
                          style: TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 11.0,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                      ...state.filteredConversations.map(
                        (conv) => _SidebarItem(
                          title: conv.title,
                          isPinned: conv.isPinned,
                          isSelected: conv.id == state.activeConversationId,
                          onTap: () {
                            controller.selectConversation(conv.id);
                            onConversationSelected?.call();
                          },
                          onPinToggle: () => controller.togglePin(conv.id),
                          onDelete: () =>
                              controller.deleteConversation(conv.id),
                        ),
                      ),
                    ],
                  ),
          ),

          // ── Footer Token Quota Bar ───────────────────────────────────────
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Color(0xFF181D26),
              border: Border(
                top: BorderSide(
                  color: Color(0xFF2B323E),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 32.0,
                  height: 32.0,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.primary,
                    size: 16.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pro Plan Active',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '84.2k / 1M Tokens',
                        style: TextStyle(
                          color: Color(0xFF777777),
                          fontSize: 11.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItem extends StatelessWidget {
  const _SidebarItem({
    required this.title,
    required this.isPinned,
    required this.isSelected,
    required this.onTap,
    required this.onPinToggle,
    required this.onDelete,
  });

  final String title;
  final bool isPinned;
  final bool isSelected;
  final VoidCallback onTap;
  final VoidCallback onPinToggle;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4.0),
      child: Material(
        color: isSelected ? const Color(0xFF2B323E) : Colors.transparent,
        borderRadius: BorderRadius.circular(8.0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            child: Row(
              children: [
                Icon(
                  isPinned ? Icons.push_pin_rounded : Icons.chat_bubble_outline_rounded,
                  color: isSelected ? AppColors.primary : const Color(0xFF777777),
                  size: 16.0,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontSize: 13.0,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(
                    Icons.more_horiz_rounded,
                    color: Color(0xFF777777),
                    size: 16.0,
                  ),
                  color: const Color(0xFF2B323E),
                  onSelected: (val) {
                    if (val == 'pin') onPinToggle();
                    if (val == 'delete') onDelete();
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'pin',
                      child: Text(
                        isPinned ? 'Unpin Chat' : 'Pin to Top',
                        style: const TextStyle(color: Colors.white, fontSize: 12.0),
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text(
                        'Delete Chat',
                        style: TextStyle(color: Colors.redAccent, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
