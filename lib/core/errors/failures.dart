/// Domain failure objects for the AI Hustle Co-Pilot application.
///
/// Failures represent domain-level error states safe to present in the UI.
/// Repositories map data-layer [AppException] instances into these typed
/// failures using `Either<Failure, T>`.
///
/// Error Flow:
/// ```
/// DataSource (Exception) → Repository (catch & map) → Failure → Provider → UI
/// ```
library;

import 'package:flutter/foundation.dart';

/// Base failure class for all domain-level errors.
@immutable
abstract base class Failure {
  const Failure({
    required this.message,
    this.code,
  });

  /// User-facing error message suitable for display in UI components.
  final String message;

  /// Optional machine-readable error code for analytics or retry logic.
  final int? code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Failure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;

  @override
  int get hashCode => Object.hash(message, code);

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

/// Failure originating from a remote server or HTTP error.
base class ServerFailure extends Failure {
  const ServerFailure({
    required super.message,
    super.code,
  });
}

/// Failure originating from a local cache or disk read/write error.
base class CacheFailure extends Failure {
  const CacheFailure({
    required super.message,
    super.code,
  });
}

/// Failure originating from network disconnection or connection timeout.
base class NetworkFailure extends Failure {
  const NetworkFailure({
    super.message = 'No internet connection. Please check your network.',
    super.code = 1001,
  });
}

/// Failure originating from invalid user credentials or authentication error.
base class AuthFailure extends Failure {
  const AuthFailure({
    required super.message,
    super.code,
  });
}

/// Failure originating from an expired session or unauthorized token (401).
base class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure({
    super.message = 'Your session has expired. Please sign in again.',
    super.code = 401,
  });
}

/// Failure originating from payload or form input validation failures.
base class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.code = 422,
    this.fieldErrors = const {},
  });

  /// Specific field error mappings.
  final Map<String, String> fieldErrors;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      super == other &&
          other is ValidationFailure &&
          mapEquals(fieldErrors, other.fieldErrors);

  @override
  int get hashCode => Object.hash(super.hashCode, mapEquals);
}

/// Failure originating when a requested resource is missing (404).
base class NotFoundFailure extends Failure {
  const NotFoundFailure({
    super.message = 'The requested item was not found.',
    super.code = 404,
  });
}

/// Failure originating from unhandled or unexpected system errors.
base class UnknownFailure extends Failure {
  const UnknownFailure({
    super.message = 'An unexpected error occurred. Please try again.',
    super.code,
  });
}

/// Extension converting [Failure] into friendly UI messages.
extension FailureMessageX on Failure {
  /// Converts any domain failure into a clear, user-friendly message.
  String toUserMessage() {
    return message.isNotEmpty ? message : 'An unexpected error occurred.';
  }
}
