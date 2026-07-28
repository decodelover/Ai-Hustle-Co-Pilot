/// Centralized Riverpod providers for core infrastructure services.
///
/// Enforces the Dependency Inversion Principle (DIP) by exposing
/// abstractions (`LoggerService`, `SecureStorageService`, `CacheStorageService`,
/// `NetworkInfo`) rather than concrete implementations to feature controllers.
///
/// Supabase-specific providers are co-located in
/// [core/providers/supabase_providers.dart] and re-exported here
/// for single-import convenience.
library;

import 'package:ai_hustle_copilot/core/config/environment_config.dart';
import 'package:ai_hustle_copilot/core/logging/app_logger.dart';
import 'package:ai_hustle_copilot/core/logging/logger_service.dart';
import 'package:ai_hustle_copilot/core/network/dio_client.dart';
import 'package:ai_hustle_copilot/core/network/network_info.dart';
import 'package:ai_hustle_copilot/core/security/secure_storage_service.dart';
import 'package:ai_hustle_copilot/core/storage/cache_storage_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Re-export Supabase providers for single-import access.
export 'package:ai_hustle_copilot/core/providers/supabase_providers.dart';

/// Active application environment configuration provider.
final environmentConfigProvider = Provider<EnvironmentConfig>((ref) {
  return EnvironmentConfig.dev();
});

/// Production-safe logging service provider.
final loggerServiceProvider = Provider<LoggerService>((ref) {
  return AppLoggerService();
});

/// Encrypted secure storage service provider for tokens and credentials.
final secureStorageServiceProvider = Provider<SecureStorageService>((ref) {
  return SecureStorageServiceImpl();
});

/// Local cache and key-value storage service provider for non-sensitive data.
final cacheStorageServiceProvider = Provider<CacheStorageService>((ref) {
  return HiveStorageServiceImpl();
});

/// Network connectivity checking service provider.
final networkInfoProvider = Provider<NetworkInfo>((ref) {
  return const NetworkInfoImpl();
});

/// Pre-configured Dio HTTP client provider with interceptors.
final dioClientProvider = Provider<DioClient>((ref) {
  final config = ref.watch(environmentConfigProvider);
  final secureStorage = ref.watch(secureStorageServiceProvider);
  final logger = ref.watch(loggerServiceProvider);

  return DioClient(
    config: config,
    secureStorage: secureStorage,
    logger: logger,
  );
});

/// Underlying Dio instance provider for raw HTTP access.
final dioProvider = Provider<Dio>((ref) {
  return ref.watch(dioClientProvider).dio;
});
