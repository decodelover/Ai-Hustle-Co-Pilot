/// Data layer implementation of domain [DashboardRepository].
library;

import 'package:ai_hustle_copilot/features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/repositories/dashboard_repository.dart';

/// Concrete repository handling dashboard persistence and API calls.
class DashboardRepositoryImpl implements DashboardRepository {
  /// Constructs a [DashboardRepositoryImpl].
  DashboardRepositoryImpl({required this.remoteDataSource});

  /// Injected remote data source.
  final DashboardRemoteDataSource remoteDataSource;

  @override
  Future<DashboardState> getDashboardState() async {
    return remoteDataSource.fetchDashboardData();
  }

  @override
  Future<DashboardState> refreshDashboardState() async {
    return remoteDataSource.fetchDashboardData();
  }
}
