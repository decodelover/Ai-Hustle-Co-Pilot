/// Supabase data source for the dashboard command center.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/quick_action_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/recent_project_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Data source interface for dashboard network APIs.
abstract class DashboardRemoteDataSource {
  /// Fetches dashboard state from the authenticated data boundary.
  Future<DashboardState> fetchDashboardData();
}

/// Supabase-backed implementation with an honest no-cache fallback.
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  /// Creates a dashboard source. A null client is useful for isolated tests.
  DashboardRemoteDataSourceImpl({this.supabaseClient});

  /// Authenticated production data client.
  final SupabaseClient? supabaseClient;

  @override
  Future<DashboardState> fetchDashboardData() async {
    final client = supabaseClient;
    if (client != null && client.auth.currentUser != null) {
      try {
        return await _fetchLiveState(client);
      } catch (_) {
        // The UI remains usable and explains that no cached data is available.
      }
    }
    return _emptyState();
  }

  Future<DashboardState> _fetchLiveState(SupabaseClient client) async {
    final results = await Future.wait<dynamic>([
      client
          .from('projects')
          .select('id,title,progress,updated_at')
          .order('updated_at', ascending: false)
          .limit(5),
      client.from('documents').select('id'),
      client.from('applications').select('id,status'),
    ]);
    final projectRows = results[0] as List<dynamic>;
    final documentRows = results[1] as List<dynamic>;
    final applicationRows = results[2] as List<dynamic>;
    final activeApplications = applicationRows.where((row) {
      final status = (row as Map<String, dynamic>)['status'] as String?;
      return status != 'archived' && status != 'rejected';
    }).length;

    final metadata =
        client.auth.currentUser?.userMetadata ?? <String, dynamic>{};
    final displayName = (metadata['display_name'] ??
            metadata['full_name'] ??
            metadata['name'] ??
            '')
        .toString()
        .trim();
    final projects = projectRows.map(_mapProject).toList();

    return DashboardState(
      userName: displayName.isEmpty ? 'there' : displayName,
      metrics: [
        DashboardMetricCardModel(
          id: 'active_projects',
          title: 'Active projects',
          value: '${projectRows.length}',
          trendPercentage: 0,
          isPositiveTrend: true,
          icon: Icons.folder_open_outlined,
        ),
        DashboardMetricCardModel(
          id: 'documents',
          title: 'Documents',
          value: '${documentRows.length}',
          trendPercentage: 0,
          isPositiveTrend: true,
          icon: Icons.description_outlined,
        ),
        DashboardMetricCardModel(
          id: 'applications',
          title: 'Active applications',
          value: '$activeApplications',
          trendPercentage: 0,
          isPositiveTrend: true,
          icon: Icons.track_changes_outlined,
        ),
      ],
      projects: projects,
      quickActions: _quickActions(),
      lastUpdated: DateTime.now(),
    );
  }

  DashboardState _emptyState() {
    return DashboardState(quickActions: _quickActions());
  }

  RecentProjectModel _mapProject(dynamic row) {
    final json = row as Map<String, dynamic>;
    final progress = (json['progress'] as num?)?.toDouble() ?? 0;
    return RecentProjectModel(
      id: json['id'].toString(),
      title: json['title'] as String? ?? 'Untitled project',
      clientName: 'Personal workspace',
      progress: progress.clamp(0, 1).toDouble(),
      status: progress >= 1
          ? ProjectStatus.completed
          : ProjectStatus.inProgress,
      lastUpdated:
          DateTime.tryParse(json['updated_at'] as String? ?? '') ??
          DateTime.now(),
      tags: const [],
      aiUsageScore: 0,
    );
  }

  List<QuickActionModel> _quickActions() {
    return const [
      QuickActionModel(
        id: 'find_opportunities',
        label: 'Find work',
        icon: Icons.explore_outlined,
        route: RoutePaths.discover,
        isFeatured: true,
        analyticsEvent: 'dashboard_quick_action_find_opportunities',
      ),
      QuickActionModel(
        id: 'ai_workspace',
        label: 'AI Studio',
        icon: Icons.auto_awesome_outlined,
        route: RoutePaths.aiStudio,
        isFeatured: true,
        analyticsEvent: 'dashboard_quick_action_ai_studio',
      ),
      QuickActionModel(
        id: 'create_document',
        label: 'New document',
        icon: Icons.note_add_outlined,
        route: RoutePaths.documents,
        analyticsEvent: 'dashboard_quick_action_create_document',
      ),
      QuickActionModel(
        id: 'projects',
        label: 'Projects',
        icon: Icons.folder_open_outlined,
        route: RoutePaths.projects,
        analyticsEvent: 'dashboard_quick_action_projects',
      ),
    ];
  }
}
