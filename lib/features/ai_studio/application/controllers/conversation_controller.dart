/// Application Controller: ConversationController
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/conversation_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod StateNotifier managing active conversation state & list.
class ConversationController extends StateNotifier<AsyncValue<void>> {
  /// Creates a [ConversationController].
  ConversationController({ConversationRepository? repository})
    : _repository = repository ?? ConversationRepositoryImpl(),
      super(const AsyncData(null));

  final ConversationRepository _repository;

  /// Fetches all active conversations.
  Future<List<Conversation>> getConversations() async {
    return _repository.getConversations();
  }

  /// Fetches messages for a conversation thread.
  Future<List<ChatMessage>> getMessages(String conversationId) async {
    return _repository.getMessages(conversationId);
  }

  /// Creates a new conversation thread.
  Future<Conversation> createConversation({
    required String title,
    String? folderId,
    String modelId = 'gpt-4o',
  }) async {
    return _repository.createConversation(
      title: title,
      folderId: folderId,
      modelId: modelId,
    );
  }

  /// Deletes a conversation thread.
  Future<void> deleteConversation(String id) async {
    state = const AsyncLoading();
    try {
      await _repository.deleteConversation(id);
      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Searches conversations.
  Future<List<Conversation>> searchConversations(String query) async {
    return _repository.searchConversations(query);
  }
}
