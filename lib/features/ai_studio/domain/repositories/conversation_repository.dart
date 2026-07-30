/// Domain Repository Contract: ConversationRepository
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation_folder.dart';

/// Abstract repository contract managing conversation threads, messages, and folders.
abstract interface class ConversationRepository {
  /// Fetches all active conversations.
  Future<List<Conversation>> getConversations();

  /// Fetches a single conversation by ID.
  Future<Conversation?> getConversationById(String id);

  /// Creates a new conversation thread.
  Future<Conversation> createConversation({
    required String title,
    String? folderId,
    String modelId = 'gpt-4o',
  });

  /// Updates conversation properties.
  Future<Conversation> updateConversation(Conversation conversation);

  /// Deletes a conversation thread.
  Future<void> deleteConversation(String id);

  /// Bulk deletes a list of conversation IDs.
  Future<void> bulkDeleteConversations(List<String> ids);

  /// Fetches all messages in a conversation.
  Future<List<ChatMessage>> getMessages(String conversationId);

  /// Saves a single chat message.
  Future<ChatMessage> saveMessage(ChatMessage message);

  /// Deletes a chat message.
  Future<void> deleteMessage(String messageId);

  /// Fetches all folders.
  Future<List<ConversationFolder>> getFolders();

  /// Creates a new folder.
  Future<ConversationFolder> createFolder(String name);

  /// Deletes a folder.
  Future<void> deleteFolder(String folderId);

  /// Searches conversations by query text.
  Future<List<Conversation>> searchConversations(String query);
}
