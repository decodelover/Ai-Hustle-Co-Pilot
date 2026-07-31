/// Domain Service: MemoryRetrievalService (Amendment 3.2B)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_memory.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/memory_repository.dart';

/// Service retrieving relevant context memories for a prompt.
final class MemoryRetrievalService {
  /// Creates a [MemoryRetrievalService].
  const MemoryRetrievalService(this._memoryRepository);

  final MemoryRepository _memoryRepository;

  /// Fetches top relevant memories for prompt execution.
  Future<List<AiMemory>> fetchRelevantMemories(String promptText) async {
    return _memoryRepository.retrieveRelevantMemories(promptText);
  }
}
