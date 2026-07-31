/// Data Source: ProjectLocalDataSource (Phase 3.3 Data Layer)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/project_template_factory.dart';

/// Local in-memory and storage data source for AI Projects.
final class ProjectLocalDataSource {
  /// Constructs [ProjectLocalDataSource] with initial seed data.
  ProjectLocalDataSource() {
    _seedProjects();
  }

  /// Internal mock storage map.
  final Map<String, Project> _projects = {};

  void _seedProjects() {
    final p1 = ProjectTemplateFactory.createFromCategory(
      id: 'proj_1',
      title: 'Mobile Banking SuperApp',
      description: 'Build enterprise Flutter banking application with biometrics, instant transfers, and AI insights.',
      category: ProjectCategory.mobileApp,
    );

    final p2 = ProjectTemplateFactory.createFromCategory(
      id: 'proj_2',
      title: 'AI Hustle Co-Pilot SaaS',
      description: 'Production-grade AI productivity platform with multi-agent orchestration.',
      category: ProjectCategory.software,
    );

    _projects[p1.id] = p1;
    _projects[p2.id] = p2;
  }

  /// Gets all projects.
  Future<List<Project>> getProjects() async {
    await Future<void>.delayed(const Duration(milliseconds: 50));
    return _projects.values.toList();
  }

  /// Gets project by ID.
  Future<Project?> getProjectById(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    return _projects[id];
  }

  /// Saves or updates project.
  Future<Project> saveProject(Project project) async {
    await Future<void>.delayed(const Duration(milliseconds: 30));
    _projects[project.id] = project;
    return project;
  }

  /// Deletes project by ID.
  Future<void> deleteProject(String id) async {
    await Future<void>.delayed(const Duration(milliseconds: 20));
    _projects.remove(id);
  }
}
