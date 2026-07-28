/// Immutable Password Value Object enforcing domain constraints.
library;

import 'package:ai_hustle_copilot/features/auth/domain/value_objects/value_object_exception.dart';
import 'package:meta/meta.dart';

/// Immutable Value Object encapsulating a validated password.
///
/// Invariants:
/// - Must meet configurable minimum length (default 8 characters)
/// - Provides helper methods to evaluate uppercase, lowercase, digit, and special character presence
@immutable
class Password {
  /// Constructs a [Password] Value Object after validating minimum length.
  ///
  /// Throws [AuthValidationException] if [input] length is less than [minLength].
  factory Password(String input, {int minLength = 8}) {
    if (input.length < minLength) {
      throw AuthValidationException(
        'Password must be at least $minLength characters long.',
      );
    }
    return Password._(input);
  }

  /// Internal private constructor.
  const Password._(this.value);

  /// The raw password string value.
  final String value;

  /// Whether the password contains at least one uppercase letter (A-Z).
  bool get hasUppercase => _uppercaseRegex.hasMatch(value);

  /// Whether the password contains at least one lowercase letter (a-z).
  bool get hasLowercase => _lowercaseRegex.hasMatch(value);

  /// Whether the password contains at least one numeric digit (0-9).
  bool get hasDigit => _digitRegex.hasMatch(value);

  /// Whether the password contains at least one special character.
  bool get hasSpecialCharacter => _specialCharRegex.hasMatch(value);

  /// Returns `true` if the password satisfies strong password criteria:
  /// length >= 8, uppercase, lowercase, digit, and special character.
  bool get isStrong =>
      value.length >= 8 &&
      hasUppercase &&
      hasLowercase &&
      hasDigit &&
      hasSpecialCharacter;

  static final RegExp _uppercaseRegex = RegExp('[A-Z]');
  static final RegExp _lowercaseRegex = RegExp('[a-z]');
  static final RegExp _digitRegex = RegExp('[0-9]');
  static final RegExp _specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Password &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => '[REDACTED_PASSWORD]';
}
