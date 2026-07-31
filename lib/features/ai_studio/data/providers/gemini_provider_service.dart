/// Google Gemini Provider Service Implementation (Amendment 3.2A)
library;

import 'dart:async';
import 'dart:convert';

import 'package:ai_hustle_copilot/core/config/env.dart';
import 'package:ai_hustle_copilot/features/ai_studio/data/providers/ai_provider_service.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/chat_message.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/value_objects/message_role.dart';
import 'package:dio/dio.dart';

/// Real Google Gemini provider implementation streaming response content.
final class GeminiProviderService implements AiProviderService {
  /// Creates a [GeminiProviderService].
  GeminiProviderService({this.apiKey, Dio? dio}) : _dio = dio ?? Dio();

  /// Custom or configured Gemini API key.
  final String? apiKey;

  final Dio _dio;

  /// Effective API key resolving configured Env key fallback.
  String get effectiveApiKey {
    if (apiKey != null && apiKey!.isNotEmpty) return apiKey!;
    try {
      return Env.geminiApiKey;
    } catch (_) {
      return '';
    }
  }

  @override
  String get providerId => 'gemini';

  @override
  Stream<String> streamResponse({
    required String modelId,
    required List<ChatMessage> history,
    String? systemPrompt,
  }) async* {
    final activeKey = effectiveApiKey;
    if (activeKey.isEmpty) {
      throw StateError(
        'GEMINI_API_KEY is not configured. Add it to .env and regenerate env.g.dart.',
      );
    }

    final effectiveModel = modelId.startsWith('gemini-')
        ? modelId
        : 'gemini-3.6-flash';
    final contents = history
        .where(
          (message) =>
              message.role == MessageRole.user ||
              message.role == MessageRole.assistant,
        )
        .map(
          (message) => <String, dynamic>{
            'role': message.role == MessageRole.assistant ? 'model' : 'user',
            'parts': [
              {'text': message.content},
            ],
          },
        )
        .toList();

    final payload = <String, dynamic>{
      'contents': contents,
      if (systemPrompt != null && systemPrompt.trim().isNotEmpty)
        'systemInstruction': {
          'parts': [
            {'text': systemPrompt.trim()},
          ],
        },
    };

    final response = await _dio.post<ResponseBody>(
      'https://generativelanguage.googleapis.com/v1beta/models/'
      '$effectiveModel:streamGenerateContent?alt=sse',
      data: payload,
      options: Options(
        responseType: ResponseType.stream,
        headers: {
          'x-goog-api-key': activeKey,
          'content-type': 'application/json',
        },
      ),
    );

    final body = response.data;
    if (body == null) {
      throw StateError('Gemini returned an empty response stream.');
    }

    final lines = const LineSplitter().bind(utf8.decoder.bind(body.stream));
    await for (final line in lines) {
      if (!line.startsWith('data:')) continue;
      final data = line.substring(5).trim();
      if (data.isEmpty || data == '[DONE]') continue;
      final decoded = jsonDecode(data) as Map<String, dynamic>;
      final candidates = decoded['candidates'] as List<dynamic>?;
      if (candidates == null || candidates.isEmpty) continue;
      final candidate = candidates.first as Map<String, dynamic>;
      final content = candidate['content'] as Map<String, dynamic>?;
      final parts = content?['parts'] as List<dynamic>? ?? const [];
      for (final part in parts) {
        final text = (part as Map<String, dynamic>)['text'] as String?;
        if (text != null && text.isNotEmpty) yield text;
      }
    }
  }
}
