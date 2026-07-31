/// Domain Repository Contract: MemoryRepository (Amendment 3.2B)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_memory.dart';

/// Repository managing AI Memory read/write/retrieval operations.
abstract interface class MemoryRepository {
  /// Fetches memories by category.
  Future<List<AiMemory>> getMemories(MemoryCategory category);

  /// Saves or updates a memory.
  Future<AiMemory> saveMemory(AiMemory memory);

  /// Deletes a memory by ID.
  Future<void> deleteMemory(String id);

  /// Retrieves relevant memories for a prompt string.
  Future<List<AiMemory>> retrieveRelevantMemories(String promptText);
}
