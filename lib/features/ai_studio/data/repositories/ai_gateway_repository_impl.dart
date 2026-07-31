/// Data Repository Implementation: AiGatewayRepositoryImpl (Amendment 3.2A)
library;

import 'package:ai_hustle_copilot/features/ai_studio/data/services/ai_gateway_client.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/ai_gateway_repository.dart';

/// Concrete repository implementation routing requests through [AiGatewayClient].
final class AiGatewayRepositoryImpl implements AiGatewayRepository {
  /// Creates an [AiGatewayRepositoryImpl].
  AiGatewayRepositoryImpl({AiGatewayClient? gatewayClient})
      : _gatewayClient = gatewayClient ?? AiGatewayClient();

  final AiGatewayClient _gatewayClient;

  @override
  Stream<String> streamGatewayPrompt({
    required String conversationId,
    required List<ChatMessage> history,
    required String modelId,
    String? systemPrompt,
  }) {
    return _gatewayClient.streamPrompt(
      modelId: modelId,
      history: history,
      systemPrompt: systemPrompt,
    );
  }

  @override
  Future<bool> checkProviderHealth(String providerId) async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return true;
  }
}
