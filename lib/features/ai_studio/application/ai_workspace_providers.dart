/// Riverpod Providers for AI Workspace Infrastructure & Dependency Injection
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/datasources/ai_studio_local_data_source.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/mock_ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/agent_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/ai_studio_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/repositories/conversation_repository_impl.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/agent_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/ai_studio_repository.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/conversation_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Singleton provider for local Hive/memory storage & session recovery.
final aiStudioLocalDataSourceProvider = Provider<AiStudioLocalDataSource>((ref) {
  return AiStudioLocalDataSource();
});

/// Singleton provider for AI provider service (Mock/OpenAI/Gemini/Claude).
final aiProviderServiceProvider = Provider<AiProviderService>((ref) {
  return MockAiProviderService();
});

/// Provider for [ConversationRepository].
final conversationRepositoryProvider = Provider<ConversationRepository>((ref) {
  final local = ref.watch(aiStudioLocalDataSourceProvider);
  return ConversationRepositoryImpl(localDataSource: local);
});

/// Provider for [AiStudioRepository].
final aiStudioRepositoryProvider = Provider<AiStudioRepository>((ref) {
  final local = ref.watch(aiStudioLocalDataSourceProvider);
  final providerService = ref.watch(aiProviderServiceProvider);
  return AiStudioRepositoryImpl(
    localDataSource: local,
    aiProviderService: providerService,
  );
});

/// Provider for [AgentRepository].
final agentRepositoryProvider = Provider<AgentRepository>((ref) {
  final local = ref.watch(aiStudioLocalDataSourceProvider);
  return AgentRepositoryImpl(localDataSource: local);
});
