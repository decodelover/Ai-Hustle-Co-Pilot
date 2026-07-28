/// Centralized Riverpod providers for the Authentication feature.
///
/// Exposes dependency injection bindings for remote data sources,
/// repositories, and authentication use cases.
library;

import 'package:ai_hustle_copilot/core/providers/supabase_providers.dart';
import 'package:ai_hustle_copilot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ai_hustle_copilot/features/auth/data/datasources/supabase_auth_remote_data_source.dart';
import 'package:ai_hustle_copilot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/observe_auth_state_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/refresh_session_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/resend_verification_email_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// ── Data Layer Providers ─────────────────────────────────────────────

/// Provider for [AuthRemoteDataSource] backed by Supabase.
final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  final supabaseClient = ref.watch(supabaseClientProvider);
  return SupabaseAuthRemoteDataSource(supabaseClient: supabaseClient);
});

/// Provider for [AuthRepository] bound to [AuthRepositoryImpl].
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final remoteDataSource = ref.watch(authRemoteDataSourceProvider);
  return AuthRepositoryImpl(remoteDataSource: remoteDataSource);
});

// ── Domain Use Case Providers ────────────────────────────────────────

/// Provider for [SignInUseCase].
final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

/// Provider for [SignUpUseCase].
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
});

/// Provider for [SignOutUseCase].
final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
});

/// Provider for [GetCurrentUserUseCase].
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
});

/// Provider for [ObserveAuthStateUseCase].
final observeAuthStateUseCaseProvider = Provider<ObserveAuthStateUseCase>((ref) {
  return ObserveAuthStateUseCase(ref.watch(authRepositoryProvider));
});

/// Provider for [ResetPasswordUseCase].
final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) {
  return ResetPasswordUseCase(ref.watch(authRepositoryProvider));
});

/// Provider for [ResendVerificationEmailUseCase].
final resendVerificationEmailUseCaseProvider =
    Provider<ResendVerificationEmailUseCase>((ref) {
  return ResendVerificationEmailUseCase(ref.watch(authRepositoryProvider));
});

/// Provider for [RefreshSessionUseCase].
final refreshSessionUseCaseProvider = Provider<RefreshSessionUseCase>((ref) {
  return RefreshSessionUseCase(ref.watch(authRepositoryProvider));
});
