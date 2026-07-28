/// Focused derived Riverpod providers for dashboard performance optimizations.
library;

import 'package:ai_hustle_copilot/features/dashboard/application/controllers/dashboard_controller.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/activity_feed_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/insight_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/quick_action_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/recent_project_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider watching only KPI metrics.
final dashboardMetricsProvider =
    Provider.autoDispose<List<DashboardMetricCardModel>>((ref) {
  final asyncState = ref.watch(dashboardControllerProvider);
  return asyncState.valueOrNull?.metrics ?? const [];
});

/// Provider watching only Quick Actions.
final dashboardQuickActionsProvider =
    Provider.autoDispose<List<QuickActionModel>>((ref) {
  final asyncState = ref.watch(dashboardControllerProvider);
  return asyncState.valueOrNull?.quickActions ?? const [];
});

/// Provider watching only Recent Projects.
final dashboardProjectsProvider =
    Provider.autoDispose<List<RecentProjectModel>>((ref) {
  final asyncState = ref.watch(dashboardControllerProvider);
  return asyncState.valueOrNull?.projects ?? const [];
});

/// Provider watching only Activity items.
final dashboardActivitiesProvider =
    Provider.autoDispose<List<ActivityFeedModel>>((ref) {
  final asyncState = ref.watch(dashboardControllerProvider);
  return asyncState.valueOrNull?.activities ?? const [];
});

/// Provider watching active AI Insights (excluding dismissed).
final dashboardInsightsProvider =
    Provider.autoDispose<List<InsightCardModel>>((ref) {
  final asyncState = ref.watch(dashboardControllerProvider);
  final allInsights = asyncState.valueOrNull?.insights ?? const [];
  return allInsights.where((item) => !item.isDismissed).toList();
});

/// Provider watching selected analytics chart timeframe.
final dashboardChartTimeframeProvider =
    Provider.autoDispose<ChartTimeframe>((ref) {
  final asyncState = ref.watch(dashboardControllerProvider);
  return asyncState.valueOrNull?.selectedTimeframe ?? ChartTimeframe.weekly;
});
