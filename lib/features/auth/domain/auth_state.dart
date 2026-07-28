/// Domain-level authentication state representation.
///
/// Framework-independent sealed hierarchy consumed by presentation controllers and router.
/// Decoupled from backend-specific auth SDKs.
///
/// ## State Machine
/// ```
/// ┌──────────────┐
/// │ Initializing │──── check session ───┐
/// └──────────────┘                      │
///                    ┌──────────────────┴┐
///                    ▼                   ▼
///           ┌───────────────┐   ┌─────────────────┐
///           │ Authenticated │   │ Unauthenticated │
///           └───────────────┘   └─────────────────┘
///                    │                   │
///                    └── sign out ───────┘
/// ```
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:meta/meta.dart';

/// Represents the current authentication lifecycle state.
@immutable
sealed class AppAuthState {
  /// Base constructor for [AppAuthState].
  const AppAuthState();
}

/// The application is inspecting stored credentials on startup.
final class AuthInitializing extends AppAuthState {
  /// Creates an [AuthInitializing] state.
  const AuthInitializing();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AuthInitializing && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'AuthInitializing()';
}

/// A valid session exists with an authenticated [user].
final class Authenticated extends AppAuthState {
  /// Creates an [Authenticated] state containing the active [user].
  const Authenticated({required this.user});

  /// The currently authenticated domain user entity.
  final AuthUser user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Authenticated &&
          runtimeType == other.runtimeType &&
          user == other.user;

  @override
  int get hashCode => user.hashCode;

  @override
  String toString() => 'Authenticated(user: ${user.email})';
}

/// No valid session exists — user is unauthenticated.
final class Unauthenticated extends AppAuthState {
  /// Creates an [Unauthenticated] state.
  const Unauthenticated();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Unauthenticated && runtimeType == other.runtimeType;

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() => 'Unauthenticated()';
}
