/// Data Source: ProjectLocalDataSource (Phase 3.3 Data Layer)
library;

import 'package:ai_hustle_copilot/features/projects/domain/entities/project.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_activity.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_agent.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_context.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_file.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_member.dart';
import 'package:ai_hustle_copilot/features/projects/domain/entities/project_task.dart';
import 'package:ai_hustle_copilot/features/projects/domain/services/project_template_factory.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Local in-memory and storage data source for AI Projects.
final class ProjectLocalDataSource {
  /// Constructs [ProjectLocalDataSource] with initial seed data.
  ProjectLocalDataSource({this.enablePersistence = false}) {
    _seedProjects();
  }

  /// In-memory cache mirrored to Hive in production.
  final Map<String, Project> _projects = {};
  bool _hydrated = false;

  /// Whether reads and writes are mirrored to Hive.
  final bool enablePersistence;

  bool get _canPersist {
    if (!enablePersistence) return false;
    if (kIsWeb) return true;
    try {
      return (Hive as dynamic).homePath != null;
    } catch (_) {
      return false;
    }
  }

  static const _boxName = 'projects_v1';

  Future<void> _hydrate() async {
    if (_hydrated) return;
    _hydrated = true;
    if (!_canPersist) return;
    try {
      final box = await Hive.openBox<dynamic>(_boxName);
      if (box.isEmpty) {
        await box.putAll(
          _projects.map((id, project) => MapEntry(id, _toJson(project))),
        );
        return;
      }
      _projects
        ..clear()
        ..addEntries(
          box.toMap().entries.map(
            (entry) => MapEntry(
              entry.key.toString(),
              _fromJson(Map<String, dynamic>.from(entry.value as Map)),
            ),
          ),
        );
    } catch (_) {
      // Unit tests and unsupported platforms retain the in-memory fallback.
    }
  }

  void _seedProjects() {
    final p1 = ProjectTemplateFactory.createFromCategory(
      id: 'proj_1',
      title: 'Mobile Banking SuperApp',
      description:
          'Build enterprise Flutter banking application with biometrics, instant transfers, and AI insights.',
      category: ProjectCategory.mobileApp,
    );

    final p2 = ProjectTemplateFactory.createFromCategory(
      id: 'proj_2',
      title: 'AI Hustle Co-Pilot SaaS',
      description:
          'Production-grade AI productivity platform with multi-agent orchestration.',
      category: ProjectCategory.software,
    );

    _projects[p1.id] = p1;
    _projects[p2.id] = p2;
  }

  /// Gets all projects.
  Future<List<Project>> getProjects() async {
    await _hydrate();
    return _projects.values.toList();
  }

  /// Gets project by ID.
  Future<Project?> getProjectById(String id) async {
    await _hydrate();
    return _projects[id];
  }

  /// Saves or updates project.
  Future<Project> saveProject(Project project) async {
    await _hydrate();
    _projects[project.id] = project;
    if (!_canPersist) return project;
    try {
      final box = await Hive.openBox<dynamic>(_boxName);
      await box.put(project.id, _toJson(project));
    } catch (_) {
      // Unit tests and unsupported platforms retain the in-memory fallback.
    }
    return project;
  }

  /// Deletes project by ID.
  Future<void> deleteProject(String id) async {
    await _hydrate();
    _projects.remove(id);
    if (!_canPersist) return;
    try {
      final box = await Hive.openBox<dynamic>(_boxName);
      await box.delete(id);
    } catch (_) {
      // Unit tests and unsupported platforms retain the in-memory fallback.
    }
  }

  static Map<String, dynamic> _toJson(Project project) => {
    'id': project.id,
    'title': project.title,
    'description': project.description,
    'category': project.category.name,
    'createdAt': project.createdAt.toIso8601String(),
    'updatedAt': project.updatedAt.toIso8601String(),
    'progress': project.progress,
    'healthScore': project.healthScore,
    'activeAgents': project.activeAgents
        .map(
          (agent) => {
            'id': agent.id,
            'name': agent.name,
            'role': agent.role.name,
            'systemInstructions': agent.systemInstructions,
            'avatarUrl': agent.avatarUrl,
            'supportedTools': agent.supportedTools,
            'supportedFileTypes': agent.supportedFileTypes,
            'supportedModels': agent.supportedModels,
            'isExecuting': agent.isExecuting,
            'currentTaskDescription': agent.currentTaskDescription,
          },
        )
        .toList(),
    'tasks': project.tasks
        .map(
          (task) => {
            'id': task.id,
            'projectId': task.projectId,
            'title': task.title,
            'description': task.description,
            'createdAt': task.createdAt.toIso8601String(),
            'status': task.status.name,
            'assignedAgentId': task.assignedAgentId,
            'progress': task.progress,
            'executionLogs': task.executionLogs,
            'completedAt': task.completedAt?.toIso8601String(),
          },
        )
        .toList(),
    'knowledgeFiles': project.knowledgeFiles
        .map(
          (file) => {
            'id': file.id,
            'projectId': file.projectId,
            'name': file.name,
            'extension': file.extension,
            'sizeBytes': file.sizeBytes,
            'folderPath': file.folderPath,
            'createdAt': file.createdAt.toIso8601String(),
            'tags': file.tags,
            'summary': file.summary,
            'indexingStatus': file.indexingStatus.name,
            'downloadUrl': file.downloadUrl,
            'version': file.version,
          },
        )
        .toList(),
    'activities': project.activities
        .map(
          (activity) => {
            'id': activity.id,
            'projectId': activity.projectId,
            'title': activity.title,
            'description': activity.description,
            'timestamp': activity.timestamp.toIso8601String(),
            'type': activity.type.name,
            'actorName': activity.actorName,
            'statusColor': activity.statusColor?.toARGB32(),
          },
        )
        .toList(),
    'members': project.members
        .map(
          (member) => {
            'id': member.id,
            'name': member.name,
            'email': member.email,
            'role': member.role.name,
            'avatarUrl': member.avatarUrl,
          },
        )
        .toList(),
    'context': project.context == null
        ? null
        : {
            'projectId': project.context!.projectId,
            'systemInstructions': project.context!.systemInstructions,
            'techStack': project.context!.techStack,
            'keyRules': project.context!.keyRules,
            'targetAudience': project.context!.targetAudience,
            'architectureNotes': project.context!.architectureNotes,
          },
  };

  static Project _fromJson(Map<String, dynamic> json) {
    final contextJson = json['context'] as Map?;
    return Project(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String? ?? '',
      category: ProjectCategory.values.byName(json['category'] as String),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
      healthScore: (json['healthScore'] as num?)?.toInt() ?? 100,
      activeAgents: _list(json['activeAgents'])
          .map(
            (item) => ProjectAgent(
              id: item['id'] as String,
              name: item['name'] as String,
              role: AgentRole.values.byName(item['role'] as String),
              systemInstructions: item['systemInstructions'] as String? ?? '',
              avatarUrl: item['avatarUrl'] as String?,
              supportedTools: _strings(item['supportedTools']),
              supportedFileTypes: _strings(item['supportedFileTypes']),
              supportedModels: _strings(item['supportedModels']),
              isExecuting: item['isExecuting'] as bool? ?? false,
              currentTaskDescription: item['currentTaskDescription'] as String?,
            ),
          )
          .toList(),
      tasks: _list(json['tasks'])
          .map(
            (item) => ProjectTask(
              id: item['id'] as String,
              projectId: item['projectId'] as String,
              title: item['title'] as String,
              description: item['description'] as String? ?? '',
              createdAt: DateTime.parse(item['createdAt'] as String),
              status: ProjectTaskStatus.values.byName(item['status'] as String),
              assignedAgentId: item['assignedAgentId'] as String?,
              progress: (item['progress'] as num?)?.toDouble() ?? 0,
              executionLogs: _strings(item['executionLogs']),
              completedAt: item['completedAt'] == null
                  ? null
                  : DateTime.parse(item['completedAt'] as String),
            ),
          )
          .toList(),
      knowledgeFiles: _list(json['knowledgeFiles'])
          .map(
            (item) => ProjectFile(
              id: item['id'] as String,
              projectId: item['projectId'] as String,
              name: item['name'] as String,
              extension: item['extension'] as String,
              sizeBytes: (item['sizeBytes'] as num).toInt(),
              folderPath: item['folderPath'] as String,
              createdAt: DateTime.parse(item['createdAt'] as String),
              tags: _strings(item['tags']),
              summary: item['summary'] as String?,
              indexingStatus: IndexingStatus.values.byName(
                item['indexingStatus'] as String,
              ),
              downloadUrl: item['downloadUrl'] as String?,
              version: (item['version'] as num?)?.toInt() ?? 1,
            ),
          )
          .toList(),
      activities: _list(json['activities'])
          .map(
            (item) => ProjectActivity(
              id: item['id'] as String,
              projectId: item['projectId'] as String,
              title: item['title'] as String,
              description: item['description'] as String,
              timestamp: DateTime.parse(item['timestamp'] as String),
              type: ActivityType.values.byName(item['type'] as String),
              icon: Icons.history_rounded,
              actorName: item['actorName'] as String?,
              statusColor: item['statusColor'] == null
                  ? null
                  : Color((item['statusColor'] as num).toInt()),
            ),
          )
          .toList(),
      members: _list(json['members'])
          .map(
            (item) => ProjectMember(
              id: item['id'] as String,
              name: item['name'] as String,
              email: item['email'] as String,
              role: MemberRole.values.byName(item['role'] as String),
              avatarUrl: item['avatarUrl'] as String?,
            ),
          )
          .toList(),
      context: contextJson == null
          ? null
          : ProjectContext(
              projectId: contextJson['projectId'] as String,
              systemInstructions:
                  contextJson['systemInstructions'] as String? ?? '',
              techStack: _strings(contextJson['techStack']),
              keyRules: _strings(contextJson['keyRules']),
              targetAudience: contextJson['targetAudience'] as String?,
              architectureNotes: contextJson['architectureNotes'] as String?,
            ),
    );
  }

  static List<Map<String, dynamic>> _list(Object? value) =>
      (value as List<dynamic>? ?? const [])
          .map((item) => Map<String, dynamic>.from(item as Map))
          .toList();

  static List<String> _strings(Object? value) =>
      (value as List<dynamic>? ?? const [])
          .map((item) => item.toString())
          .toList();
}
