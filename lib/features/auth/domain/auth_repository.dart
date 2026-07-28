/// Authentication repository contract for the auth feature.
///
/// Defines the domain-level interface for all authentication operations.
/// Repository implementations live in `features/auth/data/` and handle
/// Supabase GoTrue interactions, mapping raw exceptions into domain
/// [Failure] objects.
///
/// ## Error Handling Strategy
/// Methods throw [AppException] subtypes on failure. The presentation
/// layer catches these via Riverpod's [AsyncValue.guard] or try-catch,
/// and the [ErrorMapper] converts them into user-facing [Failure] objects.
///
/// A shared `Result<T>` type will be introduced in a future milestone
/// to standardize success/failure return types across all repositories.
library;

import 'package:supabase_flutter/supabase_flutter.dart' show AuthState, User;

/// Contract for authentication data operations.
///
/// Implementations must:
/// - Map Supabase [AuthException] to domain [AppException] subtypes
/// - Never expose raw Supabase types beyond [User] and [AuthState]
/// - Never log credentials, tokens, or sensitive user data
abstract interface class AuthRepository {
  /// Signs in a user with email and password.
  ///
  /// Returns the authenticated [User] on success.
  /// Throws [AuthException] if credentials are invalid.
  /// Throws [NetworkException] if the device is offline.
  Future<User> signInWithEmail({
    required String email,
    required String password,
  });

  /// Creates a new user account with email and password.
  ///
  /// Returns the newly created [User] on success.
  /// Throws [AuthException] if the email is already registered.
  /// Throws [ValidationException] if inputs fail server validation.
  Future<User> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Signs out the current user and clears the session.
  ///
  /// Throws [AuthException] if sign-out fails on the server.
  Future<void> signOut();

  /// Returns the currently authenticated user, or `null` if
  /// no valid session exists.
  Future<User?> getCurrentUser();

  /// Streams real-time authentication state changes.
  ///
  /// Emits events for sign-in, sign-out, token refresh,
  /// password recovery, and user metadata updates.
  Stream<AuthState> onAuthStateChange();

  /// Sends a password reset email to the specified address.
  ///
  /// Throws [AuthException] if the email is not registered.
  Future<void> sendPasswordReset({required String email});
}
