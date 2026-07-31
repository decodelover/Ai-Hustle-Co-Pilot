/// Domain Use Case: StreamChatResponseUseCase
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/ai_gateway_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/services/memory_injection_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/services/memory_ranking_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/services/memory_retrieval_service.dart';

/// Orchestrates chat prompt stream execution with memory retrieval and gateway routing.
final class StreamChatResponseUseCase {
  /// Creates a [StreamChatResponseUseCase].
  StreamChatResponseUseCase({
    required this.gatewayRepository,
    required this.retrievalService,
    MemoryRankingService? rankingService,
    MemoryInjectionService? injectionService,
  })  : rankingService = rankingService ?? const MemoryRankingService(),
        injectionService = injectionService ?? const MemoryInjectionService();

  /// Gateway repository.
  final AiGatewayRepository gatewayRepository;

  /// Memory retrieval service.
  final MemoryRetrievalService retrievalService;

  /// Memory ranking service.
  final MemoryRankingService rankingService;

  /// Memory injection service.
  final MemoryInjectionService injectionService;

  /// Executes prompt streaming with context memory enrichment.
  Stream<String> execute({
    required String conversationId,
    required List<ChatMessage> history,
    required String modelId,
    String? baseSystemPrompt,
  }) async* {
    var finalSystemPrompt = baseSystemPrompt ?? 'You are AI Hustle Co-Pilot, an enterprise AI assistant.';

    if (history.isNotEmpty) {
      final userPrompt = history.last.content;
      final candidateMemories = await retrievalService.fetchRelevantMemories(userPrompt);
      final rankedMemories = rankingService.rankMemories(candidateMemories);
      finalSystemPrompt = injectionService.injectMemories(
        baseSystemPrompt: finalSystemPrompt,
        memories: rankedMemories,
      );
    }

    yield* gatewayRepository.streamGatewayPrompt(
      conversationId: conversationId,
      history: history,
      modelId: modelId,
      systemPrompt: finalSystemPrompt,
    );
  }
}
