/// Framework-independent sealed AuthFailure domain hierarchy.
///
/// Encapsulates authentication failure cases safe for UI and domain logic.
/// Decoupled from backend-specific exceptions (Supabase, Firebase, HTTP).
library;

import 'package:meta/meta.dart';

/// Sealed base class for domain authentication failures.
@immutable
sealed class AuthFailure implements Exception {
  /// Base constructor for [AuthFailure].
  const AuthFailure({required this.message, this.code});

  /// User-facing error message describing the failure.
  final String message;

  /// Optional machine-readable error code.
  final int? code;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthFailure &&
          runtimeType == other.runtimeType &&
          message == other.message &&
          code == other.code;

  @override
  int get hashCode => Object.hash(message, code);

  @override
  String toString() => '$runtimeType(message: $message, code: $code)';
}

/// Failure when provided credentials (email/password) are incorrect.
final class InvalidCredentialsFailure extends AuthFailure {
  /// Creates an [InvalidCredentialsFailure].
  const InvalidCredentialsFailure({
    super.message = 'Invalid email or password. Please try again.',
    super.code = 400,
  });
}

/// Failure when trying to register an email address that is already registered.
final class EmailAlreadyExistsFailure extends AuthFailure {
  /// Creates an [EmailAlreadyExistsFailure].
  const EmailAlreadyExistsFailure({
    super.message = 'An account with this email address already exists.',
    super.code = 409,
  });
}

/// Failure when the user's email address has not been verified yet.
final class EmailNotVerifiedFailure extends AuthFailure {
  /// Creates an [EmailNotVerifiedFailure].
  const EmailNotVerifiedFailure({
    super.message = 'Please verify your email address before signing in.',
    super.code = 403,
  });
}

/// Failure when password provided during sign-up does not meet requirements.
final class WeakPasswordFailure extends AuthFailure {
  /// Creates a [WeakPasswordFailure].
  const WeakPasswordFailure({
    super.message = 'Password does not meet required strength criteria.',
    super.code = 422,
  });
}

/// Failure due to network connectivity issues or timeouts.
final class NetworkFailure extends AuthFailure {
  /// Creates a [NetworkFailure].
  const NetworkFailure({
    super.message =
        'Network connection unavailable. Please check your connection.',
    super.code = 1001,
  });
}

/// Failure when a user session or token has expired.
final class SessionExpiredFailure extends AuthFailure {
  /// Creates a [SessionExpiredFailure].
  const SessionExpiredFailure({
    super.message = 'Your session has expired. Please sign in again.',
    super.code = 401,
  });
}

/// Fallback failure for unexpected or unhandled authentication errors.
final class UnknownAuthFailure extends AuthFailure {
  /// Creates an [UnknownAuthFailure].
  const UnknownAuthFailure({
    super.message = 'An unexpected authentication error occurred.',
    super.code = 500,
  });
}
