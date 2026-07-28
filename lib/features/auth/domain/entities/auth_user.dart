/// Framework-independent user domain entity.
///
/// Encapsulates user identity and core profile data across the application.
/// This entity is completely decoupled from Supabase, Firebase, or any remote DTO models.
library;

import 'package:meta/meta.dart';

/// Immutable domain entity representing an authenticated or profile user.
@immutable
class AuthUser {
  /// Creates an [AuthUser] domain entity.
  const AuthUser({
    required this.id,
    required this.email,
    this.displayName,
    this.avatarUrl,
    this.emailVerified = false,
    this.createdAt,
    this.updatedAt,
  });

  /// Unique identifier for the user (UUID format).
  final String id;

  /// User's primary email address.
  final String email;

  /// User's optional display or full name.
  final String? displayName;

  /// Optional URL pointing to the user's avatar image.
  final String? avatarUrl;

  /// Whether the user's email address has been verified.
  final bool emailVerified;

  /// Timestamp when the user account was created.
  final DateTime? createdAt;

  /// Timestamp when the user profile was last updated.
  final DateTime? updatedAt;

  /// Returns a copy of this [AuthUser] with the given fields replaced.
  AuthUser copyWith({
    String? id,
    String? email,
    String? displayName,
    String? avatarUrl,
    bool? emailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      emailVerified: emailVerified ?? this.emailVerified,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          displayName == other.displayName &&
          avatarUrl == other.avatarUrl &&
          emailVerified == other.emailVerified &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode => Object.hash(
        id,
        email,
        displayName,
        avatarUrl,
        emailVerified,
        createdAt,
        updatedAt,
      );

  @override
  String toString() => 'AuthUser('
      'id: $id, '
      'email: $email, '
      'displayName: $displayName, '
      'emailVerified: $emailVerified'
      ')';
}
