/// Supabase implementation of [AuthRemoteDataSource].
library;

import 'package:ai_hustle_copilot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ai_hustle_copilot/features/auth/data/dtos/auth_user_dto.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Concrete [AuthRemoteDataSource] implementation communicating directly with Supabase GoTrue API.
class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  /// Constructs a [SupabaseAuthRemoteDataSource] with injected [SupabaseClient].
  SupabaseAuthRemoteDataSource({
    required this.supabaseClient,
  });

  /// The injected Supabase client instance.
  final SupabaseClient supabaseClient;

  GoTrueClient get _auth => supabaseClient.auth;

  @override
  Future<AuthUserDto> signIn({
    required String email,
    required String password,
  }) async {
    final response = await _auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) {
      throw const AuthException('Sign in failed: No user object returned.');
    }

    return AuthUserDto.fromSupabaseUser(user);
  }

  @override
  Future<AuthUserDto> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final response = await _auth.signUp(
      email: email,
      password: password,
      emailRedirectTo: 'aihustlecopilot://login-callback',
      data: displayName != null ? {'display_name': displayName} : null,
    );

    final user = response.user;
    if (user == null) {
      throw const AuthException('Sign up failed: No user object returned.');
    }

    return AuthUserDto.fromSupabaseUser(user);
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<AuthUserDto?> currentUser() async {
    final user = _auth.currentUser;
    if (user == null) return null;
    return AuthUserDto.fromSupabaseUser(user);
  }

  @override
  Stream<AuthUserDto?> authStateChanges() {
    return _auth.onAuthStateChange.map((data) {
      final user = data.session?.user ?? _auth.currentUser;
      if (user == null) return null;
      return AuthUserDto.fromSupabaseUser(user);
    });
  }

  @override
  Future<void> resetPassword({required String email}) async {
    await _auth.resetPasswordForEmail(
      email,
      redirectTo: 'aihustlecopilot://login-callback',
    );
  }

  @override
  Future<void> resendVerification({required String email}) async {
    await _auth.resend(
      type: OtpType.signup,
      email: email,
    );
  }

  @override
  Future<AuthUserDto?> refreshSession() async {
    final response = await _auth.refreshSession();
    final user = response.user ?? _auth.currentUser;
    if (user == null) return null;
    return AuthUserDto.fromSupabaseUser(user);
  }
}
