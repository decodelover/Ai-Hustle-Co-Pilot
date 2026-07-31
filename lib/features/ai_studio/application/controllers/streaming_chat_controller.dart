/// Application Controller: StreamingChatController
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/ai_gateway_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/conversation_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/memory_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/message_attachment.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/conversation_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/services/memory_retrieval_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/use_cases/stream_chat_response_use_case.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/message_role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Riverpod StateNotifier driving streaming prompt submission, memory injection, & SSE token flow.
class StreamingChatController extends StateNotifier<AsyncValue<String?>> {
  /// Creates a [StreamingChatController].
  StreamingChatController({
    ConversationRepository? repository,
    StreamChatResponseUseCase? streamChatResponseUseCase,
  }) : _repository = repository ?? ConversationRepositoryImpl(),
       _streamChatResponseUseCase =
           streamChatResponseUseCase ??
           StreamChatResponseUseCase(
             gatewayRepository: AiGatewayRepositoryImpl(),
             retrievalService: MemoryRetrievalService(MemoryRepositoryImpl()),
           ),
       super(const AsyncData(null));

  final ConversationRepository _repository;
  final StreamChatResponseUseCase _streamChatResponseUseCase;
  StreamSubscription<String>? _streamSub;

  /// Sends user prompt message and streams AI response tokens.
  Future<void> sendPrompt({
    required String conversationId,
    required String promptText,
    String modelId = 'gpt-4o',
    List<MessageAttachment> attachments = const [],
  }) async {
    if (promptText.trim().isEmpty) return;

    // 1. Save user prompt message
    final userMsg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      conversationId: conversationId,
      role: MessageRole.user,
      content: promptText.trim(),
      createdAt: DateTime.now(),
      attachments: attachments,
    );
    await _repository.saveMessage(userMsg);

    // 2. Fetch thread message history
    final history = await _repository.getMessages(conversationId);

    // 3. Set streaming state loading
    state = const AsyncLoading();
    final buffer = StringBuffer();

    try {
      await _streamSub?.cancel();
      _streamSub = _streamChatResponseUseCase
          .execute(
            conversationId: conversationId,
            history: history,
            modelId: modelId,
          )
          .listen(
            (token) {
              buffer.write(token);
              state = AsyncData(buffer.toString());
            },
            onError: (Object error, StackTrace st) {
              state = AsyncError(error, st);
            },
            onDone: () {
              unawaited(
                _saveFinalMessage(conversationId, buffer.toString(), modelId),
              );
            },
          );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> _saveFinalMessage(
    String conversationId,
    String content,
    String modelId,
  ) async {
    final aiMsg = ChatMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      conversationId: conversationId,
      role: MessageRole.assistant,
      content: content,
      createdAt: DateTime.now(),
      modelId: modelId,
    );
    await _repository.saveMessage(aiMsg);
    state = const AsyncData(null);
  }

  /// Cancels active response stream.
  void cancelStream() {
    _streamSub?.cancel();
    state = const AsyncData(null);
  }

  @override
  void dispose() {
    _streamSub?.cancel();
    super.dispose();
  }
}
