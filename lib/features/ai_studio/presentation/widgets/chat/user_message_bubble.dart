/// User Message Bubble Component (Amendment 3.1M)
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:flutter/material.dart';

/// Presentation bubble for user-authored prompts.
class UserMessageBubble extends StatelessWidget {
  /// Creates a [UserMessageBubble].
  const UserMessageBubble({required this.message, super.key});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 48.0),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(4.0),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    blurRadius: 12.0,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Text(
                message.content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  height: 1.45,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.0),
          Container(
            width: 32.0,
            height: 32.0,
            decoration: const BoxDecoration(
              color: Color(0xFF2B323E),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person_rounded,
                color: Colors.white70,
                size: 18.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
