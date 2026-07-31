/// Domain Service: MemoryInjectionService (Amendment 3.2B)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_memory.dart';

/// Service formatting ranked memories into structured system prompt context block.
final class MemoryInjectionService {
  /// Creates a [MemoryInjectionService].
  const MemoryInjectionService();

  /// Injects memories into existing system prompt string.
  String injectMemories({
    required String baseSystemPrompt,
    required List<AiMemory> memories,
  }) {
    if (memories.isEmpty) return baseSystemPrompt;

    final buffer = StringBuffer(baseSystemPrompt)
      ..writeln('\n\n--- RELEVANT CONTEXT MEMORIES ---');

    for (final memory in memories) {
      buffer.writeln('• [${memory.category.name.toUpperCase()}]: ${memory.content}');
    }

    buffer.writeln('--- END CONTEXT MEMORIES ---');
    return buffer.toString();
  }
}
