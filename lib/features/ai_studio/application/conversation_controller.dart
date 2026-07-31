/// Conversation State Controller (Amendment 3.1H, 3.1I)
library;

import 'package:ai_hustle_copilot/features/ai_studio/application/ai_workspace_providers.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/conversation_folder.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State representation for conversation list and sidebar navigation.
final class ConversationState {
  const ConversationState({
    this.conversations = const [],
    this.folders = const [],
    this.activeConversationId,
    this.searchQuery = '',
    this.isLoading = false,
    this.errorMessage,
  });

  final List<Conversation> conversations;
  final List<ConversationFolder> folders;
  final String? activeConversationId;
  final String searchQuery;
  final bool isLoading;
  final String? errorMessage;

  /// Pinned conversations subset.
  List<Conversation> get pinnedConversations =>
      conversations.where((c) => c.isPinned && !c.isArchived).toList();

  /// Unpinned conversations subset.
  List<Conversation> get unpinnedConversations =>
      conversations.where((c) => !c.isPinned && !c.isArchived).toList();

  /// Filtered conversations based on search query.
  List<Conversation> get filteredConversations {
    if (searchQuery.trim().isEmpty) return conversations;
    final lower = searchQuery.toLowerCase();
    return conversations
        .where((c) => c.title.toLowerCase().contains(lower))
        .toList();
  }

  ConversationState copyWith({
    List<Conversation>? conversations,
    List<ConversationFolder>? folders,
    String? activeConversationId,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ConversationState(
      conversations: conversations ?? this.conversations,
      folders: folders ?? this.folders,
      activeConversationId: activeConversationId ?? this.activeConversationId,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

/// Controller managing conversation list, selection, creation, folders, and search.
final class ConversationController extends StateNotifier<ConversationState> {
  ConversationController({required this.repository})
    : super(const ConversationState()) {
    loadConversations();
  }

  final ConversationRepository repository;

  /// Initial load of conversations and folders.
  Future<void> loadConversations() async {
    state = state.copyWith(isLoading: true);
    try {
      final convs = await repository.getConversations();
      final folders = await repository.getFolders();
      final activeId =
          state.activeConversationId ??
          (convs.isNotEmpty ? convs.first.id : null);
      state = state.copyWith(
        conversations: convs,
        folders: folders,
        activeConversationId: activeId,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to load conversations: $e',
      );
    }
  }

  /// Selects active conversation by ID.
  void selectConversation(String id) {
    state = state.copyWith(activeConversationId: id);
  }

  /// Updates search query with debouncing support.
  void updateSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  /// Creates a new conversation thread.
  Future<Conversation> createNewConversation({
    String title = 'New Conversation',
    String? folderId,
  }) async {
    final conv = await repository.createConversation(
      title: title,
      folderId: folderId,
    );
    await loadConversations();
    selectConversation(conv.id);
    return conv;
  }

  /// Toggles pin status of a conversation.
  Future<void> togglePin(String id) async {
    final conv = state.conversations.firstWhere((c) => c.id == id);
    final updated = conv.copyWith(isPinned: !conv.isPinned);
    await repository.updateConversation(updated);
    await loadConversations();
  }

  /// Renames a conversation.
  Future<void> renameConversation(String id, String newTitle) async {
    final conv = state.conversations.firstWhere((c) => c.id == id);
    final updated = conv.copyWith(title: newTitle, updatedAt: DateTime.now());
    await repository.updateConversation(updated);
    await loadConversations();
  }

  /// Moves conversation to a folder.
  Future<void> moveToFolder(String conversationId, String? folderId) async {
    final conv = state.conversations.firstWhere((c) => c.id == conversationId);
    final updated = conv.copyWith(folderId: folderId);
    await repository.updateConversation(updated);
    await loadConversations();
  }

  /// Deletes a conversation thread.
  Future<void> deleteConversation(String id) async {
    await repository.deleteConversation(id);
    await loadConversations();
  }

  /// Bulk deletes conversation threads.
  Future<void> bulkDelete(List<String> ids) async {
    await repository.bulkDeleteConversations(ids);
    await loadConversations();
  }

  /// Creates a new folder node.
  Future<void> createFolder(String name) async {
    await repository.createFolder(name);
    await loadConversations();
  }
}

/// Provider for [ConversationController].
final conversationControllerProvider =
    StateNotifierProvider<ConversationController, ConversationState>((ref) {
      final repo = ref.watch(conversationRepositoryProvider);
      return ConversationController(repository: repo);
    });
