/// Unified Dashboard State model.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/activity_feed_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/insight_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/quick_action_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/recent_project_model.dart';
import 'package:flutter/foundation.dart';

/// Chart timeframe selection enum.
enum ChartTimeframe {
  weekly,
  monthly,
  yearly,
}

/// Unified, immutable state object containing all dashboard data,
/// loading flags, error details, and selected filters.
@immutable
class DashboardState {
  /// Creates a [DashboardState].
  const DashboardState({
    this.metrics = const [],
    this.projects = const [],
    this.activities = const [],
    this.insights = const [],
    this.quickActions = const [],
    this.selectedTimeframe = ChartTimeframe.weekly,
    this.productivityScore = 94,
    this.storageUsedPercentage = 68,
    this.creditsRemaining = 840,
    this.isRefreshing = false,
    this.lastUpdated,
  });

  /// List of KPI metrics.
  final List<DashboardMetricCardModel> metrics;

  /// Recent active projects.
  final List<RecentProjectModel> projects;

  /// Timeline activity feed.
  final List<ActivityFeedModel> activities;

  /// AI insight recommendations.
  final List<InsightCardModel> insights;

  /// Available quick action shortcuts.
  final List<QuickActionModel> quickActions;

  /// Active analytics chart timeframe.
  final ChartTimeframe selectedTimeframe;

  /// Overall AI Productivity score (0-100).
  final int productivityScore;

  /// Cloud storage usage percentage.
  final int storageUsedPercentage;

  /// AI Credits remaining count.
  final int creditsRemaining;

  /// Whether a background refresh is actively running.
  final bool isRefreshing;

  /// Last refresh timestamp.
  final DateTime? lastUpdated;

  /// Returns a copy of [DashboardState] with updated properties.
  DashboardState copyWith({
    List<DashboardMetricCardModel>? metrics,
    List<RecentProjectModel>? projects,
    List<ActivityFeedModel>? activities,
    List<InsightCardModel>? insights,
    List<QuickActionModel>? quickActions,
    ChartTimeframe? selectedTimeframe,
    int? productivityScore,
    int? storageUsedPercentage,
    int? creditsRemaining,
    bool? isRefreshing,
    DateTime? lastUpdated,
  }) {
    return DashboardState(
      metrics: metrics ?? this.metrics,
      projects: projects ?? this.projects,
      activities: activities ?? this.activities,
      insights: insights ?? this.insights,
      quickActions: quickActions ?? this.quickActions,
      selectedTimeframe: selectedTimeframe ?? this.selectedTimeframe,
      productivityScore: productivityScore ?? this.productivityScore,
      storageUsedPercentage:
          storageUsedPercentage ?? this.storageUsedPercentage,
      creditsRemaining: creditsRemaining ?? this.creditsRemaining,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardState &&
          runtimeType == other.runtimeType &&
          listEquals(metrics, other.metrics) &&
          listEquals(projects, other.projects) &&
          listEquals(activities, other.activities) &&
          listEquals(insights, other.insights) &&
          listEquals(quickActions, other.quickActions) &&
          selectedTimeframe == other.selectedTimeframe &&
          productivityScore == other.productivityScore &&
          storageUsedPercentage == other.storageUsedPercentage &&
          creditsRemaining == other.creditsRemaining &&
          isRefreshing == other.isRefreshing &&
          lastUpdated == other.lastUpdated;

  @override
  int get hashCode => Object.hash(
        Object.hashAll(metrics),
        Object.hashAll(projects),
        Object.hashAll(activities),
        Object.hashAll(insights),
        Object.hashAll(quickActions),
        selectedTimeframe,
        productivityScore,
        storageUsedPercentage,
        creditsRemaining,
        isRefreshing,
        lastUpdated,
      );
}
