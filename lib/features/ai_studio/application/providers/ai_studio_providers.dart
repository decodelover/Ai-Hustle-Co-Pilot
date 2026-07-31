/// Master Riverpod Providers for Phase 3.2 AI Studio & AI Gateway Architecture.
library;

import 'package:ai_hustle_copilot/features/ai_studio/application/controllers/agent_controller.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/controllers/conversation_controller.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/controllers/credit_wallet_controller.dart';
import 'package:ai_hustle_copilot/features/ai_studio/application/controllers/streaming_chat_controller.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/ai_gateway_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/ai_studio_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/conversation_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/credit_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/memory_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/agent_task.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_model.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/credit_wallet.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/prompt_template.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/ai_gateway_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/conversation_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/credit_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/memory_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/services/content_moderation_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/services/memory_retrieval_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/use_cases/execute_agent_task_use_case.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/use_cases/stream_chat_response_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Conversation Repository Provider.
final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  return ConversationRepositoryImpl();
});

/// AI Gateway Repository Provider.
final aiGatewayRepositoryProvider = Provider<AiGatewayRepository>((ref) {
  return AiGatewayRepositoryImpl();
});

/// Memory Repository Provider.
final memoryRepositoryProvider = Provider<MemoryRepository>((ref) {
  return MemoryRepositoryImpl();
});

/// Credit Repository Provider.
final creditRepositoryProvider = Provider<CreditRepository>((ref) {
  return CreditRepositoryImpl();
});

/// Content Moderation Service Provider.
final contentModerationServiceProvider = Provider<ContentModerationService>((
  ref,
) {
  return ContentModerationService();
});

/// Stream Chat Response Use Case Provider.
final streamChatResponseUseCaseProvider = Provider<StreamChatResponseUseCase>((
  ref,
) {
  return StreamChatResponseUseCase(
    gatewayRepository: ref.watch(aiGatewayRepositoryProvider),
    retrievalService: MemoryRetrievalService(
      ref.watch(memoryRepositoryProvider),
    ),
  );
});

/// Execute Agent Task Use Case Provider.
final executeAgentTaskUseCaseProvider = Provider<ExecuteAgentTaskUseCase>((
  ref,
) {
  return ExecuteAgentTaskUseCase();
});

/// Conversation Controller Provider.
final conversationControllerProvider =
    StateNotifierProvider<ConversationController, AsyncValue<void>>((ref) {
      return ConversationController(
        repository: ref.watch(conversationRepositoryProvider),
      );
    });

/// Streaming Chat Controller Provider.
final streamingChatControllerProvider =
    StateNotifierProvider<StreamingChatController, AsyncValue<String?>>((ref) {
      return StreamingChatController(
        repository: ref.watch(conversationRepositoryProvider),
        streamChatResponseUseCase: ref.watch(streamChatResponseUseCaseProvider),
      );
    });

/// Agent Controller Provider.
final agentControllerProvider =
    StateNotifierProvider<AgentController, AsyncValue<AgentTask?>>((ref) {
      return AgentController(
        executeUseCase: ref.watch(executeAgentTaskUseCaseProvider),
      );
    });

/// Credit Wallet Controller Provider.
final creditWalletControllerProvider =
    StateNotifierProvider<CreditWalletController, AsyncValue<CreditWallet>>((
      ref,
    ) {
      return CreditWalletController(
        creditRepository: ref.watch(creditRepositoryProvider),
      );
    });

/// Available Models Future Provider.
final availableModelsProvider = FutureProvider<List<AiModel>>((ref) async {
  return AiStudioRepositoryImpl().getAvailableModels();
});

/// Prompt Templates Future Provider.
final promptTemplatesProvider = FutureProvider<List<PromptTemplate>>((
  ref,
) async {
  return AiStudioRepositoryImpl().getPromptTemplates();
});
