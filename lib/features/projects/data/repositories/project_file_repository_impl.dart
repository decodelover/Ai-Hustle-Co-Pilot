/// Repository Implementation: ProjectFileRepositoryImpl
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project_file.dart';
import 'package:ai_hustle_copilot/features/projects/domain/repositories/project_file_repository.dart';

/// Concrete implementation of [ProjectFileRepository].
final class ProjectFileRepositoryImpl implements ProjectFileRepository {
  final Map<String, List<ProjectFile>> _files = {};

  @override
  Future<List<ProjectFile>> getProjectFiles(String projectId) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return _files[projectId] ?? [];
  }

  @override
  Future<ProjectFile> uploadFile(
    String projectId,
    String name,
    List<int> bytes,
  ) async {
    await Future<void>.delayed(const Duration(milliseconds: 40));
    final dotIndex = name.lastIndexOf('.');
    final ext = dotIndex != -1 ? name.substring(dotIndex) : '.txt';

    final file = ProjectFile(
      id: 'file_${DateTime.now().millisecondsSinceEpoch}',
      projectId: projectId,
      name: name,
      extension: ext,
      sizeBytes: bytes.length,
      folderPath: '/knowledge',
      createdAt: DateTime.now(),
      summary: 'Uploaded knowledge document ready for RAG indexing.',
    );

    _files.putIfAbsent(projectId, () => <ProjectFile>[]).add(file);
    return file;
  }

  @override
  Future<void> deleteFile(String fileId) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    for (final key in _files.keys) {
      _files[key]!.removeWhere((f) => f.id == fileId);
    }
  }
}
