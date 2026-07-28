/// Domain validation exception for Value Objects.
///
/// Thrown when a Value Object (`Email`, `Password`) fails invariant validation rules.
/// Kept lightweight to facilitate smooth future migration to a shared `Result<T>` abstraction.
library;

import 'package:meta/meta.dart';

/// Domain exception thrown when value object invariants are violated.
@immutable
class AuthValidationException implements Exception {
  /// Creates an [AuthValidationException] with a human-readable [message].
  const AuthValidationException(this.message);

  /// Description of why the value object failed validation.
  final String message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthValidationException &&
          runtimeType == other.runtimeType &&
          message == other.message;

  @override
  int get hashCode => message.hashCode;

  @override
  String toString() => 'AuthValidationException: $message';
}
