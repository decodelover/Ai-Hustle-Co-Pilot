/// Concrete Implementation of [ConversationRepository]
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/datasources/ai_studio_local_data_source.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation_folder.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/conversation_repository.dart';

/// Repository implementation routing conversation operations to local storage.
final class ConversationRepositoryImpl implements ConversationRepository {
  /// Constructs [ConversationRepositoryImpl] with optional injected [AiStudioLocalDataSource].
  ConversationRepositoryImpl({AiStudioLocalDataSource? localDataSource})
    : localDataSource = localDataSource ?? AiStudioLocalDataSource();

  /// Injected local data source.
  final AiStudioLocalDataSource localDataSource;

  @override
  Future<List<Conversation>> getConversations() async {
    return localDataSource.getConversations();
  }

  @override
  Future<Conversation?> getConversationById(String id) async {
    return localDataSource.getConversationById(id);
  }

  @override
  Future<Conversation> createConversation({
    required String title,
    String? folderId,
    String modelId = 'gpt-4o',
  }) async {
    final now = DateTime.now();
    final conv = Conversation(
      id: 'conv-${now.millisecondsSinceEpoch}',
      title: title,
      folderId: folderId,
      modelId: modelId,
      createdAt: now,
      updatedAt: now,
    );
    return localDataSource.saveConversation(conv);
  }

  @override
  Future<Conversation> updateConversation(Conversation conversation) async {
    return localDataSource.saveConversation(conversation);
  }

  @override
  Future<void> deleteConversation(String id) async {
    localDataSource.deleteConversation(id);
  }

  @override
  Future<void> bulkDeleteConversations(List<String> ids) async {
    localDataSource.bulkDeleteConversations(ids);
  }

  @override
  Future<List<ChatMessage>> getMessages(String conversationId) async {
    return localDataSource.getMessages(conversationId);
  }

  @override
  Future<ChatMessage> saveMessage(ChatMessage message) async {
    return localDataSource.saveMessage(message);
  }

  @override
  Future<void> deleteMessage(String messageId) async {
    localDataSource.deleteMessage(messageId);
  }

  @override
  Future<List<ConversationFolder>> getFolders() async {
    return localDataSource.getFolders();
  }

  @override
  Future<ConversationFolder> createFolder(String name) async {
    final folder = ConversationFolder(
      id: 'folder-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      createdAt: DateTime.now(),
    );
    return localDataSource.saveFolder(folder);
  }

  @override
  Future<void> deleteFolder(String folderId) async {
    localDataSource.deleteFolder(folderId);
  }

  @override
  Future<List<Conversation>> searchConversations(String query) async {
    final all = localDataSource.getConversations();
    if (query.trim().isEmpty) return all;

    final lower = query.toLowerCase();
    return all.where((c) {
      if (c.title.toLowerCase().contains(lower)) return true;
      final msgs = localDataSource.getMessages(c.id);
      return msgs.any((m) => m.content.toLowerCase().contains(lower));
    }).toList();
  }
}
