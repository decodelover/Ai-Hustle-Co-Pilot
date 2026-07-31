/// Domain Repository Contract: VectorRepository (Amendment 3.2J)
library;

import 'package:ai_hustle_copilot/features/ai_studio/domain/entities/semantic_search_result.dart';

/// Repository managing local vector embeddings and semantic search.
abstract interface class VectorRepository {
  /// Stores document or text chunk embedding.
  Future<void> storeEmbedding({
    required String id,
    required String text,
    required List<double> vector,
    required String entityType,
  });

  /// Performs semantic search over vector storage.
  Future<List<SemanticSearchResult>> semanticSearch({
    required String query,
    int limit = 10,
  });
}
