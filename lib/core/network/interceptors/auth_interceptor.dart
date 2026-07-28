/// Auth interceptor for attaching bearer tokens to outbound Dio HTTP requests.
///
/// Reads authentication tokens from [SecureStorageService] and injects the
/// `Authorization: Bearer <token>` header when a token exists.
library;

import 'package:ai_hustle_copilot/core/security/secure_storage_service.dart';
import 'package:dio/dio.dart';

/// Interceptor that attaches JWT/Bearer tokens to outbound HTTP headers.
class AuthInterceptor extends Interceptor {
  AuthInterceptor({required this.secureStorage});

  final SecureStorageService secureStorage;

  /// Key used to store the primary access token in secure storage.
  static const String tokenStorageKey = 'auth_access_token';

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // Only attach if Authorization header has not been explicitly provided
    if (!options.headers.containsKey('Authorization')) {
      try {
        final token = await secureStorage.read(tokenStorageKey);
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }
      } catch (_) {
        // Secure storage read error — proceed without token
      }
    }

    handler.next(options);
  }
}
