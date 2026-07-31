/// Centralized Dio HTTP client for the AI Hustle Co-Pilot application.
///
/// Features:
/// - Base URL & timeouts from [EnvironmentConfig]
/// - Standard JSON content headers
/// - Outbound `Authorization: Bearer <token>` injection via [AuthInterceptor]
/// - Sanitized HTTP request/response logging via [NetworkLoggingInterceptor]
/// - Automatic [DioException] to [AppException] mapping via [NetworkErrorInterceptor]
library;

import 'package:ai_hustle_copilot/core/config/environment_config.dart';
import 'package:ai_hustle_copilot/core/logging/logger_service.dart';
import 'package:ai_hustle_copilot/core/network/interceptors/auth_interceptor.dart';
import 'package:ai_hustle_copilot/core/network/interceptors/error_interceptor.dart';
import 'package:ai_hustle_copilot/core/network/interceptors/logging_interceptor.dart';
import 'package:ai_hustle_copilot/core/security/secure_storage_service.dart';
import 'package:dio/dio.dart';

/// Pre-configured Dio HTTP client.
class DioClient {
  /// Constructs a [DioClient] configured with timeouts and interceptor pipeline.
  DioClient({
    required EnvironmentConfig config,
    required SecureStorageService secureStorage,
    required LoggerService logger,
    Dio? dio,
  }) : _dio = dio ?? Dio() {
    _dio.options = BaseOptions(
      baseUrl: config.apiBaseUrl,
      connectTimeout: config.connectTimeout,
      receiveTimeout: config.receiveTimeout,
      headers: const {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    _dio.interceptors.addAll([
      AuthInterceptor(secureStorage: secureStorage),
      if (config.enableHttpLogging) NetworkLoggingInterceptor(logger: logger),
      const NetworkErrorInterceptor(),
    ]);
  }

  final Dio _dio;

  /// The underlying Dio instance.
  Dio get dio => _dio;

  /// Dynamically registers a custom interceptor.
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }
}
