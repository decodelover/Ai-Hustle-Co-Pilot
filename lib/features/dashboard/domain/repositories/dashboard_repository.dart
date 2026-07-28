/// Domain repository interface for fetching and refreshing dashboard data.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';

/// Contract interface for the Dashboard repository.
abstract class DashboardRepository {
  /// Fetches the complete dashboard state data.
  Future<DashboardState> getDashboardState();

  /// Forces a fresh sync of all dashboard metrics and items.
  Future<DashboardState> refreshDashboardState();
}
