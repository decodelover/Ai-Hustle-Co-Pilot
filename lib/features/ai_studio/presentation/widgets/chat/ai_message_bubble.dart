/// AI Message Bubble Component (Amendment 3.1G, 3.1M)
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/widgets/chat/message_actions_bar.dart';
import 'package:flutter/material.dart';

/// Presentation bubble for AI assistant responses featuring Markdown parsing and action controls.
class AiMessageBubble extends StatelessWidget {
  /// Creates an [AiMessageBubble].
  const AiMessageBubble({
    required this.message,
    super.key,
    this.onRetry,
    this.onDelete,
  });

  final ChatMessage message;
  final VoidCallback? onRetry;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Brand Icon
          Container(
            width: 34.0,
            height: 34.0,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, Color(0xFF1877F2)],
              ),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.3),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: const Center(
              child: Icon(
                Icons.auto_awesome_rounded,
                color: Colors.white,
                size: 18.0,
              ),
            ),
          ),

          const SizedBox(width: 12.0),

          // Message Card Surface
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFF262D38),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                ),
                border: Border.all(
                  color: const Color(0xFF3D4655).withValues(alpha: 0.5),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Model Tag
                  if (message.modelId != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        message.modelId!.toUpperCase(),
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 10.0,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),

                  // Message Body Content
                  Text(
                    message.content,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 12.0),

                  // Action Control Bar
                  MessageActionsBar(
                    messageContent: message.content,
                    onRetry: onRetry,
                    onDelete: onDelete,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
