/// Central Riverpod controller managing unified [DashboardState].
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:ai_hustle_copilot/features/dashboard/data/repositories/dashboard_repository_impl.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider exposing the concrete [DashboardRepository] contract.
final dashboardRepositoryProvider = Provider<DashboardRepository>((ref) {
  return DashboardRepositoryImpl(
    remoteDataSource: DashboardRemoteDataSourceImpl(),
  );
});

/// Riverpod controller managing state transitions and interactions for the Dashboard.
class DashboardController extends AutoDisposeAsyncNotifier<DashboardState> {
  @override
  FutureOr<DashboardState> build() async {
    final repository = ref.watch(dashboardRepositoryProvider);
    return repository.getDashboardState();
  }

  /// Triggers a pull-to-refresh or explicit sync refresh.
  Future<void> refresh() async {
    final currentState = state.valueOrNull;
    if (currentState != null) {
      state = AsyncData(currentState.copyWith(isRefreshing: true));
    } else {
      state = const AsyncLoading();
    }

    try {
      final repository = ref.read(dashboardRepositoryProvider);
      final refreshed = await repository.refreshDashboardState();
      state = AsyncData(refreshed.copyWith(isRefreshing: false));
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    }
  }

  /// Changes the active analytics chart timeframe filter.
  void setChartTimeframe(ChartTimeframe timeframe) {
    final current = state.valueOrNull;
    if (current == null) return;
    state = AsyncData(current.copyWith(selectedTimeframe: timeframe));
  }

  /// Dismisses an AI insight card.
  void dismissInsight(String insightId) {
    final current = state.valueOrNull;
    if (current == null) return;

    final updatedInsights = current.insights
        .map((item) =>
            item.id == insightId ? item.copyWith(isDismissed: true) : item)
        .toList();

    state = AsyncData(current.copyWith(insights: updatedInsights));
  }

  /// Toggles favorite bookmark status on an AI insight card.
  void toggleFavoriteInsight(String insightId) {
    final current = state.valueOrNull;
    if (current == null) return;

    final updatedInsights = current.insights
        .map((item) => item.id == insightId
            ? item.copyWith(isFavorite: !item.isFavorite)
            : item)
        .toList();

    state = AsyncData(current.copyWith(insights: updatedInsights));
  }
}

/// Main controller provider for the Dashboard feature.
final dashboardControllerProvider =
    AsyncNotifierProvider.autoDispose<DashboardController, DashboardState>(
  DashboardController.new,
);
