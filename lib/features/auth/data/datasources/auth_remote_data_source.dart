/// Abstract contract for remote authentication data operations.
///
/// Defines remote operations for authenticating, registering, and managing user sessions
/// against remote backend services (e.g., Supabase, Firebase).
library;

import 'package:ai_hustle_copilot/features/auth/data/dtos/auth_user_dto.dart';

/// Contract interface for remote authentication datasources.
///
/// Returns data transfer objects ([AuthUserDto]) or primitives.
/// Implementation-specific exceptions (e.g., Supabase [AuthException]) are thrown
/// by concrete implementations and handled by repository layers.
abstract interface class AuthRemoteDataSource {
  /// Authenticates a user with [email] and [password].
  ///
  /// Returns the authenticated [AuthUserDto] on success.
  Future<AuthUserDto> signIn({
    required String email,
    required String password,
  });

  /// Registers a new user with [email], [password], and optional [displayName].
  ///
  /// Returns the newly created [AuthUserDto] on success.
  Future<AuthUserDto> signUp({
    required String email,
    required String password,
    String? displayName,
  });

  /// Signs out the active user session remotely.
  Future<void> signOut();

  /// Fetches the currently authenticated user DTO, or `null` if unauthenticated.
  Future<AuthUserDto?> currentUser();

  /// Streams real-time authentication session changes as [AuthUserDto] or `null`.
  Stream<AuthUserDto?> authStateChanges();

  /// Initiates a password reset email for [email].
  Future<void> resetPassword({
    required String email,
  });

  /// Resends the signup verification email for [email].
  Future<void> resendVerification({
    required String email,
  });

  /// Refreshes the active session token and returns the updated [AuthUserDto].
  Future<AuthUserDto?> refreshSession();

  /// Verifies an OTP code for [email] with [token].
  Future<AuthUserDto> verifyOtp({
    required String email,
    required String token,
  });
}
