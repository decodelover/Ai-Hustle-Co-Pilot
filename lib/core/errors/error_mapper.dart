/// Error mapper utility for converting raw exceptions into domain Failures.
///
/// Ensures that business logic and presentation layers only interact with
/// typed [Failure] objects. Converts [AppException], [DioException],
/// Supabase [AuthException], and arbitrary exceptions into user-friendly
/// domain failures.
library;

import 'package:ai_hustle_copilot/core/errors/exceptions.dart';
import 'package:ai_hustle_copilot/core/errors/failures.dart';
import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Converts raw data exceptions into domain-level [Failure] instances.
abstract final class ErrorMapper {
  /// Maps any caught error or exception to a domain [Failure].
  ///
  /// Preserves status codes and messages while translating infrastructure
  /// exceptions into domain failure objects safe for UI presentation.
  static Failure mapToFailure(Object error, [StackTrace? stackTrace]) {
    if (error is Failure) {
      return error;
    }

    if (error is AppException) {
      return _mapAppExceptionToFailure(error);
    }

    if (error is supabase.AuthException) {
      return _mapSupabaseAuthToFailure(error);
    }

    if (error is DioException) {
      return _mapDioExceptionToFailure(error);
    }

    if (error is FormatException) {
      return ValidationFailure(
        message: 'Invalid data format received.',
        fieldErrors: {'format': error.message},
      );
    }

    return UnknownFailure(
      message: error.toString().contains('Exception:')
          ? error.toString().replaceAll('Exception:', '').trim()
          : 'An unexpected error occurred. Please try again.',
    );
  }

  /// Maps Supabase [AuthException] to domain [AuthFailure].
  ///
  /// Translates common Supabase auth error messages into
  /// clear, user-friendly failure messages.
  static Failure _mapSupabaseAuthToFailure(supabase.AuthException error) {
    final message = error.message.toLowerCase();
    final statusCode = int.tryParse(error.statusCode ?? '');

    // Invalid credentials (wrong email/password).
    if (message.contains('invalid login credentials') ||
        message.contains('invalid_credentials')) {
      return const AuthFailure(
        message: 'Invalid email or password. Please try again.',
        code: 400,
      );
    }

    // Email not confirmed.
    if (message.contains('email not confirmed') ||
        message.contains('not confirmed')) {
      return const AuthFailure(
        message: 'Please verify your email address before signing in.',
        code: 400,
      );
    }

    // User already exists.
    if (message.contains('already registered') ||
        message.contains('user already exists')) {
      return const AuthFailure(
        message: 'An account with this email already exists.',
        code: 409,
      );
    }

    // Rate limited.
    if (message.contains('rate limit') ||
        message.contains('too many requests')) {
      return const AuthFailure(
        message: 'Too many attempts. Please wait a moment and try again.',
        code: 429,
      );
    }

    // Session expired / invalid refresh token.
    if (message.contains('refresh_token') ||
        message.contains('session_not_found') ||
        statusCode == 401) {
      return UnauthorizedFailure(
        message: error.message.isNotEmpty
            ? error.message
            : 'Your session has expired. Please sign in again.',
        code: statusCode,
      );
    }

    // Generic auth failure.
    return AuthFailure(
      message: error.message.isNotEmpty
          ? error.message
          : 'Authentication failed. Please try again.',
      code: statusCode,
    );
  }

  static Failure _mapAppExceptionToFailure(AppException exception) {
    switch (exception) {
      case final ServerException e:
        return ServerFailure(message: e.message, code: e.statusCode);
      case final CacheException e:
        return CacheFailure(message: e.message, code: e.statusCode);
      case final NetworkException e:
        return NetworkFailure(message: e.message, code: e.statusCode);
      case final AuthException e:
        return AuthFailure(message: e.message, code: e.statusCode);
      case final UnauthorizedException e:
        return UnauthorizedFailure(message: e.message, code: e.statusCode);
      case final ValidationException e:
        return ValidationFailure(
          message: e.message,
          code: e.statusCode,
          fieldErrors: e.fieldErrors,
        );
      case final NotFoundException e:
        return NotFoundFailure(message: e.message, code: e.statusCode);
      case final UnknownException e:
        return UnknownFailure(message: e.message, code: e.statusCode);
    }
  }

  static Failure _mapDioExceptionToFailure(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
      case DioExceptionType.transformTimeout:
        return const NetworkFailure(
          message: 'Network connection timed out. Please try again.',
        );

      case DioExceptionType.badResponse:
        final statusCode = dioError.response?.statusCode;
        final responseData = dioError.response?.data;

        var serverMessage = 'Server error occurred.';
        if (responseData is Map<String, dynamic>) {
          serverMessage = responseData['message']?.toString() ??
              responseData['error']?.toString() ??
              serverMessage;
        }

        if (statusCode == 401) {
          return UnauthorizedFailure(
            message: serverMessage,
            code: statusCode,
          );
        }

        if (statusCode == 404) {
          return NotFoundFailure(
            message: serverMessage,
            code: statusCode,
          );
        }

        if (statusCode == 422) {
          var fieldErrors = <String, String>{};
          if (responseData is Map<String, dynamic> &&
              responseData['errors'] is Map) {
            final rawErrors = responseData['errors'] as Map;
            fieldErrors = rawErrors.map(
              (k, v) => MapEntry(k.toString(), v.toString()),
            );
          }
          return ValidationFailure(
            message: serverMessage,
            code: statusCode,
            fieldErrors: fieldErrors,
          );
        }

        return ServerFailure(
          message: serverMessage,
          code: statusCode,
        );

      case DioExceptionType.cancel:
        return const UnknownFailure(
          message: 'Request was cancelled.',
        );

      case DioExceptionType.badCertificate:
        return const NetworkFailure(
          message: 'Secure connection failed due to bad certificate.',
        );

      case DioExceptionType.unknown:
        return UnknownFailure(
          message: dioError.message ?? 'An unknown network error occurred.',
        );
    }
  }
}
