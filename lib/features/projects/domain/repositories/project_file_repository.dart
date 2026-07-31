/// Domain Repository Contract: ProjectFileRepository (Amendment 3.3E RAG Index)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project_file.dart';

/// Contract managing project knowledge files and RAG indexing status.
abstract interface class ProjectFileRepository {
  /// Fetches files for a project.
  Future<List<ProjectFile>> getProjectFiles(String projectId);

  /// Uploads and registers a new knowledge file.
  Future<ProjectFile> uploadFile(
    String projectId,
    String name,
    List<int> bytes,
  );

  /// Deletes a file from the project index.
  Future<void> deleteFile(String fileId);
}
