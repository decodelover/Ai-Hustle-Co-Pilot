/// Analytics telemetry event logger.
library;

import 'package:ai_hustle_copilot/core/logging/app_logger.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provider for [AnalyticsService].
final analyticsServiceProvider = Provider<AnalyticsService>((ref) {
  return const AnalyticsService();
});

/// Analytics tracking service logging navigation and user interaction events.
class AnalyticsService {
  /// Creates an [AnalyticsService].
  const AnalyticsService();

  /// Logs a navigation event.
  void logNavigationEvent(
    String identifier, {
    Map<String, dynamic>? parameters,
  }) {
    AppLogger.info(
      'ANALYTICS: [Navigation] -> $identifier (params: $parameters)',
    );
  }

  /// Logs a command event.
  void logCommandEvent(String commandName, {Map<String, dynamic>? parameters}) {
    AppLogger.info(
      'ANALYTICS: [Command] -> $commandName (params: $parameters)',
    );
  }
}
