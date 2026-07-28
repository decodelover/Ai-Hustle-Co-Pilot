/// Error interceptor mapping Dio exceptions to typed AppException instances.
///
/// Ensures HTTP error responses and timeouts are immediately converted into
/// structured [AppException] subtypes before reaching repositories.
library;

import 'package:ai_hustle_copilot/core/errors/exceptions.dart';
import 'package:dio/dio.dart';

/// Interceptor that translates [DioException] into [AppException].
class NetworkErrorInterceptor extends Interceptor {
  const NetworkErrorInterceptor();

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final appException = _mapDioExceptionToAppException(err);

    handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        response: err.response,
        type: err.type,
        error: appException,
        message: appException.message,
      ),
    );
  }

  AppException _mapDioExceptionToAppException(DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.transformTimeout:
        return NetworkException(
          message: 'Connection timed out. Please check your network.',
          originalError: err,
        );

      case DioExceptionType.badResponse:
        final statusCode = err.response?.statusCode;
        final data = err.response?.data;

        var serverMessage = 'Server returned an error.';
        if (data is Map<String, dynamic>) {
          serverMessage = data['message']?.toString() ??
              data['error']?.toString() ??
              serverMessage;
        }

        if (statusCode == 401) {
          return UnauthorizedException(
            message: serverMessage,
            originalError: err,
          );
        }

        if (statusCode == 404) {
          return NotFoundException(
            message: serverMessage,
            originalError: err,
          );
        }

        if (statusCode == 422) {
          var fieldErrors = <String, String>{};
          if (data is Map<String, dynamic> && data['errors'] is Map) {
            final raw = data['errors'] as Map;
            fieldErrors = raw.map(
              (k, v) => MapEntry(k.toString(), v.toString()),
            );
          }
          return ValidationException(
            message: serverMessage,
            originalError: err,
            fieldErrors: fieldErrors,
          );
        }

        return ServerException(
          message: serverMessage,
          statusCode: statusCode,
          originalError: err,
        );

      case DioExceptionType.cancel:
        return UnknownException(
          message: 'Request was cancelled.',
          originalError: err,
        );

      case DioExceptionType.badCertificate:
        return NetworkException(
          message: 'Secure connection certificate validation failed.',
          originalError: err,
        );

      case DioExceptionType.unknown:
        return UnknownException(
          message: err.message ?? 'An unknown network error occurred.',
          originalError: err,
        );
    }
  }
}
