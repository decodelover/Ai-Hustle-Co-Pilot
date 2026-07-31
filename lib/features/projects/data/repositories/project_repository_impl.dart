/// Repository Implementation: ProjectRepositoryImpl
library;

import 'package:ai_hustle_copilot/features/projects/data/datasources/project_local_data_source.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/failures/project_failure.dart';
import 'package:ai_hustle_copilot/features/projects/domain/repositories/project_repository.dart';

/// Concrete implementation of [ProjectRepository].
final class ProjectRepositoryImpl implements ProjectRepository {
  /// Constructs [ProjectRepositoryImpl].
  ProjectRepositoryImpl({ProjectLocalDataSource? localDataSource})
      : _localDataSource = localDataSource ?? ProjectLocalDataSource();

  final ProjectLocalDataSource _localDataSource;

  @override
  Future<List<Project>> getProjects() async {
    return _localDataSource.getProjects();
  }

  @override
  Future<Project> getProjectById(String id) async {
    final proj = await _localDataSource.getProjectById(id);
    if (proj == null) throw const ProjectNotFoundFailure();
    return proj;
  }

  @override
  Future<Project> createProject(Project project) async {
    return _localDataSource.saveProject(project);
  }

  @override
  Future<void> updateProject(Project project) async {
    await _localDataSource.saveProject(project);
  }

  @override
  Future<void> deleteProject(String id) async {
    await _localDataSource.deleteProject(id);
  }
}
