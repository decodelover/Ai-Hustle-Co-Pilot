/// Domain Entity: Conversation
library;

/// Immutable domain entity representing a chat conversation thread.
final class Conversation {
  /// Creates a [Conversation].
  const Conversation({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.updatedAt,
    this.folderId,
    this.modelId = 'gemini-3.6-flash',
    this.isPinned = false,
    this.isArchived = false,
    this.systemPrompt,
    this.messageCount = 0,
    this.totalTokens = 0,
    this.tags = const [],
  });

  /// Unique conversation identifier.
  final String id;

  /// Display title of thread.
  final String title;

  /// Optional folder assignment ID.
  final String? folderId;

  /// ID of active AI model for this conversation.
  final String modelId;

  /// Whether pinned to top of sidebar.
  final bool isPinned;

  /// Whether archived.
  final bool isArchived;

  /// Optional system prompt guidance.
  final String? systemPrompt;

  /// Creation timestamp.
  final DateTime createdAt;

  /// Last modification timestamp.
  final DateTime updatedAt;

  /// Cached total message count.
  final int messageCount;

  /// Total tokens consumed across messages.
  final int totalTokens;

  /// List of tags/labels.
  final List<String> tags;

  /// Creates a copy with modified properties.
  Conversation copyWith({
    String? id,
    String? title,
    String? folderId,
    String? modelId,
    bool? isPinned,
    bool? isArchived,
    String? systemPrompt,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? messageCount,
    int? totalTokens,
    List<String>? tags,
  }) {
    return Conversation(
      id: id ?? this.id,
      title: title ?? this.title,
      folderId: folderId ?? this.folderId,
      modelId: modelId ?? this.modelId,
      isPinned: isPinned ?? this.isPinned,
      isArchived: isArchived ?? this.isArchived,
      systemPrompt: systemPrompt ?? this.systemPrompt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      messageCount: messageCount ?? this.messageCount,
      totalTokens: totalTokens ?? this.totalTokens,
      tags: tags ?? this.tags,
    );
  }
}
