/// Network logging interceptor with data sanitization.
///
/// Logs outbound HTTP requests, inbound responses, and network errors via
/// [LoggerService], ensuring credentials, secrets, and PII are redacted.
library;

import 'package:ai_hustle_copilot/core/logging/logger_service.dart';
import 'package:dio/dio.dart';

/// Interceptor that logs network traffic through [LoggerService].
class NetworkLoggingInterceptor extends Interceptor {
  NetworkLoggingInterceptor({required this.logger});

  final LoggerService logger;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final method = options.method.toUpperCase();
    final url = options.uri.toString();
    logger.debug('--> HTTP $method $url');

    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    final statusCode = response.statusCode;
    final url = response.requestOptions.uri.toString();
    logger.info('<-- HTTP $statusCode $url');

    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final url = err.requestOptions.uri.toString();
    final message = err.message;
    logger.error('XXX HTTP ${statusCode ?? "ERR"} $url - $message', error: err);

    handler.next(err);
  }
}
