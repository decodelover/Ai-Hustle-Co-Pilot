/// Message List View Component (Amendment 3.1C, 3.1F, 3.1M)
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/message_streaming_controller.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/streaming_status.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/chat/ai_message_bubble.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/chat/user_message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// High-performance virtualized message list with 8-state UI lifecycle handling and RepaintBoundary isolation.
class MessageListView extends ConsumerStatefulWidget {
  /// Creates a [MessageListView].
  const MessageListView({required this.conversationId, super.key});

  final String conversationId;

  @override
  ConsumerState<MessageListView> createState() => _MessageListViewState();
}

class _MessageListViewState extends ConsumerState<MessageListView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(messageStreamingControllerProvider.notifier)
          .loadMessages(widget.conversationId);
    });
  }

  @override
  void didUpdateWidget(covariant MessageListView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.conversationId != widget.conversationId) {
      ref
          .read(messageStreamingControllerProvider.notifier)
          .loadMessages(widget.conversationId);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final streamState = ref.watch(messageStreamingControllerProvider);
    final controller = ref.read(messageStreamingControllerProvider.notifier);

    // Auto-scroll when new token chunks arrive
    if (streamState.status == StreamingStatus.streaming) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }

    if (streamState.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColors.primary,
          strokeWidth: 2.0,
        ),
      );
    }

    if (streamState.messages.isEmpty && streamState.streamingContent.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 64.0,
              height: 64.0,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                color: AppColors.primary,
                size: 32.0,
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'How can AI Hustle Co-Pilot assist you today?',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6.0),
            const Text(
              'Type a prompt below or pick a template from the library.',
              style: TextStyle(color: Color(0xFF777777), fontSize: 13.0),
            ),
          ],
        ),
      );
    }

    return Stack(
      children: [
        ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          itemCount:
              streamState.messages.length +
              (streamState.streamingContent.isNotEmpty ? 1 : 0),
          itemBuilder: (context, index) {
            // Render active streaming response
            if (index == streamState.messages.length) {
              return RepaintBoundary(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 34.0,
                        height: 34.0,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.auto_awesome_rounded,
                          color: Colors.white,
                          size: 18.0,
                        ),
                      ),
                      const SizedBox(width: 12.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: const Color(0xFF262D38),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: Text(
                            streamState.streamingContent,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            final message = streamState.messages[index];

            return RepaintBoundary(
              child: message.role.isUser
                  ? UserMessageBubble(message: message)
                  : AiMessageBubble(
                      message: message,
                      onRetry: () =>
                          controller.retryLastPrompt(widget.conversationId),
                      onDelete: () => controller.deleteMessage(message.id),
                    ),
            );
          },
        ),

        // Scroll to Bottom FAB
        Positioned(
          right: 20.0,
          bottom: 20.0,
          child: FloatingActionButton.small(
            onPressed: _scrollToBottom,
            backgroundColor: const Color(0xFF2B323E),
            foregroundColor: Colors.white,
            elevation: 4,
            child: const Icon(Icons.arrow_downward_rounded, size: 18.0),
          ),
        ),
      ],
    );
  }
}
