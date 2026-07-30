/// Domain Entity: ChatMessage
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/message_attachment.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/message_role.dart';

/// Immutable domain entity representing a single chat message in a conversation.
final class ChatMessage {
  /// Creates a [ChatMessage].
  const ChatMessage({
    required this.id,
    required this.conversationId,
    required this.role,
    required this.content,
    required this.createdAt,
    this.attachments = const [],
    this.tokenCount = 0,
    this.modelId,
    this.isError = false,
    this.isBookmarked = false,
    this.isPinned = false,
    this.thinkingDurationMs,
  });

  /// Unique message ID.
  final String id;

  /// Parent conversation ID.
  final String conversationId;

  /// Message role (user, assistant, system).
  final MessageRole role;

  /// Text content of message.
  final String content;

  /// Creation timestamp.
  final DateTime createdAt;

  /// List of attached files or images.
  final List<MessageAttachment> attachments;

  /// Token count of message text.
  final int tokenCount;

  /// ID of model used for generation (if assistant role).
  final String? modelId;

  /// Whether message encountered a generation error.
  final bool isError;

  /// Whether user bookmarked this message.
  final bool isBookmarked;

  /// Whether user pinned this message.
  final bool isPinned;

  /// Optional AI reasoning/thinking duration in milliseconds.
  final int? thinkingDurationMs;

  /// Creates a copy with modified properties.
  ChatMessage copyWith({
    String? id,
    String? conversationId,
    MessageRole? role,
    String? content,
    DateTime? createdAt,
    List<MessageAttachment>? attachments,
    int? tokenCount,
    String? modelId,
    bool? isError,
    bool? isBookmarked,
    bool? isPinned,
    int? thinkingDurationMs,
  }) {
    return ChatMessage(
      id: id ?? this.id,
      conversationId: conversationId ?? this.conversationId,
      role: role ?? this.role,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      attachments: attachments ?? this.attachments,
      tokenCount: tokenCount ?? this.tokenCount,
      modelId: modelId ?? this.modelId,
      isError: isError ?? this.isError,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      isPinned: isPinned ?? this.isPinned,
      thinkingDurationMs: thinkingDurationMs ?? this.thinkingDurationMs,
    );
  }
}
