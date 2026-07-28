/// Domain repository contract for authentication data operations.
///
/// Defines the framework-independent interface for authentication tasks.
/// Concrete data-layer implementations (e.g., Supabase, Firebase) live in `features/auth/data/`
/// and implement this interface.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';

/// Abstract contract for authentication operations.
///
/// Methods throw typed [AuthFailure] instances on failure.
/// In a future milestone, this return contract can be migrated to `Result<T>`
/// without breaking presentation layer callers.
abstract interface class AuthRepository {
  /// Authenticates a user using their [email] and [password].
  ///
  /// Returns the authenticated [AuthUser] on success.
  /// Throws [InvalidCredentialsFailure] if email/password mismatch.
  /// Throws [NetworkFailure] if network connection fails.
  Future<AuthUser> signIn({
    required Email email,
    required Password password,
  });

  /// Registers a new user account with [email], [password], and optional [displayName].
  ///
  /// Returns the newly created [AuthUser] on success.
  /// Throws [EmailAlreadyExistsFailure] if the email is already registered.
  /// Throws [WeakPasswordFailure] if password fails server rules.
  Future<AuthUser> signUp({
    required Email email,
    required Password password,
    String? displayName,
  });

  /// Terminates the active user session and signs out locally and remotely.
  ///
  /// Throws [AuthFailure] if sign-out operation fails.
  Future<void> signOut();

  /// Returns the currently active [AuthUser] session, or `null` if unauthenticated.
  Future<AuthUser?> getCurrentUser();

  /// Streams real-time authentication state updates.
  ///
  /// Emits the active [AuthUser] when signed in, or `null` when signed out.
  Stream<AuthUser?> observeAuthState();

  /// Initiates a password reset email flow for the specified [email].
  ///
  /// Throws [AuthFailure] if sending the reset email fails.
  Future<void> sendPasswordResetEmail({
    required Email email,
  });

  /// Resends the email verification link to the specified [email].
  ///
  /// Throws [AuthFailure] if resending fails.
  Future<void> resendVerificationEmail({
    required Email email,
  });

  /// Refreshes the active session token and returns the updated [AuthUser].
  ///
  /// Returns `null` if no active session is present to refresh.
  /// Throws [SessionExpiredFailure] if token refresh is rejected.
  Future<AuthUser?> refreshSession();
}
