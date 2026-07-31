/// Data Repository Implementation: MemoryRepositoryImpl (Amendment 3.2B)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/ai_memory.dart';
import 'package:ai_hustle_copilot/features/ai_studio/domain/repositories/memory_repository.dart';

/// Concrete memory repository storing and searching context memories.
final class MemoryRepositoryImpl implements MemoryRepository {
  final List<AiMemory> _memories = [
    AiMemory(
      id: 'mem_1',
      category: MemoryCategory.project,
      content:
          'Project uses Flutter, Riverpod, Clean Architecture, and Design System V2.0.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      tags: const ['architecture', 'flutter', 'riverpod'],
    ),
    AiMemory(
      id: 'mem_2',
      category: MemoryCategory.user,
      content:
          'User prefers concise, production-ready code with no temporary mock placeholders.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      relevanceWeight: 0.9,
      tags: const ['coding_style', 'preferences'],
    ),
  ];

  @override
  Future<List<AiMemory>> getMemories(MemoryCategory category) async {
    return _memories.where((m) => m.category == category).toList();
  }

  @override
  Future<AiMemory> saveMemory(AiMemory memory) async {
    _memories
      ..removeWhere((m) => m.id == memory.id)
      ..add(memory);
    return memory;
  }

  @override
  Future<void> deleteMemory(String id) async {
    _memories.removeWhere((m) => m.id == id);
  }

  @override
  Future<List<AiMemory>> retrieveRelevantMemories(String promptText) async {
    final lower = promptText.toLowerCase();
    return _memories.where((m) {
      if (m.tags.any((tag) => lower.contains(tag))) return true;
      final words = lower.split(' ');
      return words.any(
        (w) => w.length > 3 && m.content.toLowerCase().contains(w),
      );
    }).toList();
  }
}
