/// Domain Service: MemoryRankingService (Amendment 3.2B)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_memory.dart';

/// Service ranking candidate memories based on relevance weight and recency.
final class MemoryRankingService {
  /// Creates a [MemoryRankingService].
  const MemoryRankingService();

  /// Sorts and ranks memories, returning the top-k highest priority context memories.
  List<AiMemory> rankMemories(List<AiMemory> candidates, {int topK = 5}) {
    final sorted = List<AiMemory>.from(candidates)
      ..sort((a, b) {
        final scoreA = a.relevanceWeight * (a.category == MemoryCategory.project ? 1.2 : 1.0);
        final scoreB = b.relevanceWeight * (b.category == MemoryCategory.project ? 1.2 : 1.0);
        return scoreB.compareTo(scoreA);
      });

    return sorted.take(topK).toList();
  }
}
