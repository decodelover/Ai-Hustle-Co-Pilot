/// Custom exception classes for the AI Hustle Co-Pilot application.
///
/// These exceptions are thrown at the data layer and caught by repositories,
/// which map them into domain [Failure] objects. Raw exceptions must NEVER
/// leak directly into the presentation layer.
library;

/// Base exception for all application-specific infrastructure/data errors.
sealed class AppException implements Exception {
  const AppException({
    required this.message,
    this.statusCode,
    this.originalError,
  });

  /// Human-readable description of the error context.
  final String message;

  /// Optional HTTP or domain-specific status code.
  final int? statusCode;

  /// Underlying raw exception or object if available.
  final Object? originalError;

  @override
  String toString() => '$runtimeType(message: $message, code: $statusCode)';
}

/// Exception thrown when a remote server request fails (4xx/5xx responses).
class ServerException extends AppException {
  const ServerException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Exception thrown when a local cache operation fails (Hive / disk storage).
class CacheException extends AppException {
  const CacheException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Exception thrown when network connectivity is unavailable or times out.
class NetworkException extends AppException {
  const NetworkException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Exception thrown when authentication or credential validation fails.
class AuthException extends AppException {
  const AuthException({
    required super.message,
    super.statusCode,
    super.originalError,
  });
}

/// Exception thrown when an HTTP 401 Unauthorized status is returned.
class UnauthorizedException extends AppException {
  const UnauthorizedException({
    super.message = 'Session expired. Please log in again.',
    super.statusCode = 401,
    super.originalError,
  });
}

/// Exception thrown when input data or request payload fails validation rules.
class ValidationException extends AppException {
  const ValidationException({
    required super.message,
    super.statusCode = 422,
    super.originalError,
    this.fieldErrors = const {},
  });

  /// Map of field names to field-specific validation error messages.
  final Map<String, String> fieldErrors;
}

/// Exception thrown when a requested domain resource or endpoint does not exist.
class NotFoundException extends AppException {
  const NotFoundException({
    super.message = 'The requested resource was not found.',
    super.statusCode = 404,
    super.originalError,
  });
}

/// Exception thrown for unhandled, unexpected, or uncaught system errors.
class UnknownException extends AppException {
  const UnknownException({
    super.message = 'An unexpected error occurred.',
    super.statusCode,
    super.originalError,
  });
}
