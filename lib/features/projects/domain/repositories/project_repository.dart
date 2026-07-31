/// Domain Repository Contract: ProjectRepository
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';

/// Contract abstracting project CRUD, searching, and template creation.
abstract interface class ProjectRepository {
  /// Fetches all active workspace projects.
  Future<List<Project>> getProjects();

  /// Retrieves a specific project by ID.
  Future<Project> getProjectById(String id);

  /// Creates a new project.
  Future<Project> createProject(Project project);

  /// Updates an existing project.
  Future<void> updateProject(Project project);

  /// Deletes a project by ID.
  Future<void> deleteProject(String id);
}
