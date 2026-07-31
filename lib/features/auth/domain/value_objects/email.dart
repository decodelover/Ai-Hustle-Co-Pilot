/// Immutable Email Value Object enforcing domain constraints.
library;

import 'package:ai_hustle_copilot/features/auth/domain/value_objects/value_object_exception.dart';
import 'package:meta/meta.dart';

/// Immutable Value Object encapsulating a validated, normalized email address.
///
/// Invariants:
/// - Must not be empty or whitespace-only
/// - Trimmed of leading/trailing whitespace
/// - Normalized to lower case
/// - Must match RFC 5322 pattern
@immutable
class Email {
  /// Constructs an [Email] Value Object after validating invariants.
  ///
  /// Throws [AuthValidationException] if [input] fails RFC 5322 validation.
  factory Email(String input) {
    final trimmed = input.trim();
    if (trimmed.isEmpty) {
      throw const AuthValidationException('Email address cannot be empty.');
    }

    final normalized = trimmed.toLowerCase();

    if (!_emailRegex.hasMatch(normalized)) {
      throw const AuthValidationException(
        'Please enter a valid email address.',
      );
    }

    final parts = normalized.split('@');
    if (parts.length != 2) {
      throw const AuthValidationException(
        'Please enter a valid email address.',
      );
    }

    final localPart = parts[0];
    final domainPart = parts[1];

    if (localPart.isEmpty ||
        localPart.startsWith('.') ||
        localPart.endsWith('.') ||
        localPart.contains('..')) {
      throw const AuthValidationException(
        'Please enter a valid email address.',
      );
    }

    if (domainPart.isEmpty ||
        domainPart.startsWith('-') ||
        domainPart.endsWith('-') ||
        domainPart.contains('..')) {
      throw const AuthValidationException(
        'Please enter a valid email address.',
      );
    }

    return Email._(normalized);
  }

  /// Internal private constructor.
  const Email._(this.value);

  /// Standard RFC 5322 compliant email regex pattern.
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)+$",
  );

  /// The normalized, validated raw email string.
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Email &&
          runtimeType == other.runtimeType &&
          value == other.value;

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
