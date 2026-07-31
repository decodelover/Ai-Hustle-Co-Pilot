/// Session Recovery Service (Amendment 3.1K)
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/datasources/ai_studio_local_data_source.dart';

/// Class managing persistence & restoration of workspace state across app restarts.
final class SessionRecoveryService {
  /// Constructs [SessionRecoveryService].
  SessionRecoveryService({required this.localDataSource});

  /// Injected local data source.
  final AiStudioLocalDataSource localDataSource;

  /// Restores last active conversation ID.
  String? get lastActiveConversationId =>
      localDataSource.lastActiveConversationId;

  /// Restores draft prompt text.
  String? get draftPromptText => localDataSource.draftPromptText;

  /// Restores selected AI model ID.
  String get selectedModelId => localDataSource.selectedModelId;

  /// Restores last scroll offset.
  double get lastScrollOffset => localDataSource.lastScrollOffset;

  /// Restores sidebar expansion state.
  bool get isSidebarExpanded => localDataSource.isSidebarExpanded;

  /// Saves current workspace session state.
  void persistSession({
    String? conversationId,
    String? draftPrompt,
    String? modelId,
    double? scrollOffset,
    bool? sidebarExpanded,
  }) {
    if (conversationId != null) {
      localDataSource.lastActiveConversationId = conversationId;
    }
    if (draftPrompt != null) localDataSource.draftPromptText = draftPrompt;
    if (modelId != null) localDataSource.selectedModelId = modelId;
    if (scrollOffset != null) localDataSource.lastScrollOffset = scrollOffset;
    if (sidebarExpanded != null) {
      localDataSource.isSidebarExpanded = sidebarExpanded;
    }
    localDataSource.persistSession();
  }
}
