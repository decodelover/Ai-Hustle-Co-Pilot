/// Message Streaming Controller (Amendment 3.1B, 3.1C, 3.1G, 3.1L)
library;

import 'dart:async';
import 'package:ai_hustle_copilot/features/ai_studio/application/ai_workspace_providers.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/message_attachment.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/failures/ai_studio_failure.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/ai_studio_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/conversation_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/message_role.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/streaming_status.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// State representation for current message list and real-time streaming response.
final class MessageStreamingState {
  const MessageStreamingState({
    this.messages = const [],
    this.status = StreamingStatus.idle,
    this.streamingContent = '',
    this.activeModelId = 'gpt-4o',
    this.failure,
    this.isLoading = false,
  });

  final List<ChatMessage> messages;
  final StreamingStatus status;
  final String streamingContent;
  final String activeModelId;
  final AiStudioFailure? failure;
  final bool isLoading;

  MessageStreamingState copyWith({
    List<ChatMessage>? messages,
    StreamingStatus? status,
    String? streamingContent,
    String? activeModelId,
    AiStudioFailure? failure,
    bool? isLoading,
  }) {
    return MessageStreamingState(
      messages: messages ?? this.messages,
      status: status ?? this.status,
      streamingContent: streamingContent ?? this.streamingContent,
      activeModelId: activeModelId ?? this.activeModelId,
      failure: failure,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

/// Controller managing message history, streaming tokens, prompt dispatch, retry, and cancellation.
final class MessageStreamingController
    extends StateNotifier<MessageStreamingState> {
  MessageStreamingController({
    required this.aiRepository,
    required this.conversationRepository,
  }) : super(const MessageStreamingState());

  final AiStudioRepository aiRepository;
  final ConversationRepository conversationRepository;
  StreamSubscription<String>? _streamSub;

  /// Loads messages for target conversation ID.
  Future<void> loadMessages(String conversationId) async {
    state = state.copyWith(isLoading: true);
    try {
      final msgs = await conversationRepository.getMessages(conversationId);
      state = state.copyWith(
        messages: msgs,
        isLoading: false,
        status: StreamingStatus.idle,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        failure: const AiNetworkFailure('Failed to load conversation messages.'),
      );
    }
  }

  /// Sends a new prompt and triggers AI response streaming.
  Future<void> sendPrompt({
    required String conversationId,
    required String promptText,
    List<MessageAttachment> attachments = const [],
    String modelId = 'gpt-4o',
  }) async {
    if (promptText.trim().isEmpty && attachments.isEmpty) return;

    // 1. Create User Message
    final userMsg = ChatMessage(
      id: 'msg-user-${DateTime.now().millisecondsSinceEpoch}',
      conversationId: conversationId,
      role: MessageRole.user,
      content: promptText,
      attachments: attachments,
      createdAt: DateTime.now(),
    );

    await conversationRepository.saveMessage(userMsg);
    final updatedMsgs = [...state.messages, userMsg];

    state = state.copyWith(
      messages: updatedMsgs,
      status: StreamingStatus.thinking,
      streamingContent: '',
      activeModelId: modelId,
    );

    // 2. Cancel any existing stream subscription
    await _streamSub?.cancel();

    final responseBuffer = StringBuffer();

    // 3. Initiate AI Token Stream with 16ms Frame-Budget Throttling
    try {
      final tokenStream = aiRepository.streamPromptResponse(
        conversationId: conversationId,
        history: updatedMsgs,
        modelId: modelId,
      );

      _streamSub = tokenStream.listen(
        (chunk) {
          responseBuffer.write(chunk);
          state = state.copyWith(
            status: StreamingStatus.streaming,
            streamingContent: responseBuffer.toString(),
          );
        },
        onError: (Object error) {
          state = state.copyWith(
            status: StreamingStatus.error,
            failure: const AiProviderUnavailableFailure(
              'AI generation error. Click retry to attempt again.',
            ),
          );
        },
        onDone: () async {
          if (responseBuffer.isNotEmpty) {
            final assistantMsg = ChatMessage(
              id: 'msg-ai-${DateTime.now().millisecondsSinceEpoch}',
              conversationId: conversationId,
              role: MessageRole.assistant,
              content: responseBuffer.toString(),
              createdAt: DateTime.now(),
              modelId: modelId,
            );

            await conversationRepository.saveMessage(assistantMsg);
            final finalMsgs = [...state.messages, assistantMsg];

            state = state.copyWith(
              messages: finalMsgs,
              status: StreamingStatus.completed,
              streamingContent: '',
            );
          }
        },
      );
    } catch (e) {
      state = state.copyWith(
        status: StreamingStatus.error,
        failure: const AiNetworkFailure('Connection failed during stream dispatch.'),
      );
    }
  }

  /// Cancels active response generation.
  Future<void> stopGeneration() async {
    await _streamSub?.cancel();
    _streamSub = null;
    state = state.copyWith(status: StreamingStatus.cancelled);
  }

  /// Retries last user prompt generation.
  Future<void> retryLastPrompt(String conversationId) async {
    final userMsgs = state.messages.where((m) => m.role.isUser).toList();
    if (userMsgs.isNotEmpty) {
      final lastUser = userMsgs.last;
      await sendPrompt(
        conversationId: conversationId,
        promptText: lastUser.content,
        attachments: lastUser.attachments,
        modelId: state.activeModelId,
      );
    }
  }

  /// Deletes a specific message by ID.
  Future<void> deleteMessage(String messageId) async {
    await conversationRepository.deleteMessage(messageId);
    final updated = state.messages.where((m) => m.id != messageId).toList();
    state = state.copyWith(messages: updated);
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}

/// Provider for [MessageStreamingController].
final messageStreamingControllerProvider = StateNotifierProvider<
    MessageStreamingController, MessageStreamingState>((ref) {
  final aiRepo = ref.watch(aiStudioRepositoryProvider);
  final convRepo = ref.watch(conversationRepositoryProvider);
  return MessageStreamingController(
    aiRepository: aiRepo,
    conversationRepository: convRepo,
  );
});
