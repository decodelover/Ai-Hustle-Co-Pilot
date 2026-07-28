/// Riverpod provider for global authentication state management.
///
/// Listens to Supabase's [GoTrueClient.onAuthStateChange] stream and
/// maps raw [AuthChangeEvent] values into the domain [AppAuthState]
/// sealed hierarchy. This provider is the single source of truth for
/// authentication state across the entire application.
///
/// ## Usage
/// ```dart
/// // In a widget
/// final authState = ref.watch(authStateProvider);
/// authState.when(
///   data: (state) => switch (state) {
///     AuthInitializing() => LoadingScreen(),
///     Authenticated(:final user) => DashboardScreen(),
///     Unauthenticated() => LoginScreen(),
///   },
///   loading: () => LoadingScreen(),
///   error: (e, s) => ErrorScreen(),
/// );
/// ```
library;

import 'dart:async';

import 'package:ai_hustle_copilot/core/logging/app_logger.dart';
import 'package:ai_hustle_copilot/core/providers/supabase_providers.dart';
import 'package:ai_hustle_copilot/features/auth/domain/auth_state.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart'
    show AuthChangeEvent, AuthState, User;

/// Global authentication state provider.
///
/// Emits [AppAuthState] values reactively:
/// - [AuthInitializing] on cold start before session check completes
/// - [Authenticated] when a valid session is detected
/// - [Unauthenticated] when no session exists or after sign-out
final authStateProvider =
    StreamNotifierProvider<AuthStateNotifier, AppAuthState>(
  AuthStateNotifier.new,
);

/// Notifier that bridges Supabase auth events to [AppAuthState].
///
/// On initialization, checks for an existing session. Then subscribes
/// to the auth state change stream for real-time updates.
class AuthStateNotifier extends StreamNotifier<AppAuthState> {
  @override
  Stream<AppAuthState> build() async* {
    // Emit initializing state while checking for existing session.
    yield const AuthInitializing();

    final goTrue = ref.watch(goTrueClientProvider);

    // Check for persisted session on cold start.
    final currentSession = goTrue.currentSession;
    final currentUser = goTrue.currentUser;

    if (currentSession != null && currentUser != null) {
      AppLogger.info(
        'Existing session found for user: ${currentUser.id.substring(0, 8)}...',
      );
      yield Authenticated(user: _mapSupabaseUser(currentUser));
    } else {
      AppLogger.info('No existing session — user is unauthenticated');
      yield const Unauthenticated();
    }

    // Listen for real-time auth state changes.
    yield* goTrue.onAuthStateChange.map(_mapAuthEvent);
  }

  /// Maps a raw Supabase [AuthState] event to the domain [AppAuthState].
  AppAuthState _mapAuthEvent(AuthState event) {
    final authEvent = event.event;
    final session = event.session;

    AppLogger.debug('Auth event received: ${authEvent.name}');

    switch (authEvent) {
      case AuthChangeEvent.signedIn:
      case AuthChangeEvent.tokenRefreshed:
      case AuthChangeEvent.userUpdated:
        if (session?.user != null) {
          return Authenticated(user: _mapSupabaseUser(session!.user));
        }
        return const Unauthenticated();

      case AuthChangeEvent.signedOut:
      // ignore: deprecated_member_use
      case AuthChangeEvent.userDeleted:
        return const Unauthenticated();

      case AuthChangeEvent.passwordRecovery:
      case AuthChangeEvent.mfaChallengeVerified:
      case AuthChangeEvent.initialSession:
        if (session?.user != null) {
          return Authenticated(user: _mapSupabaseUser(session!.user));
        }
        return const Unauthenticated();
    }
  }

  /// Maps a Supabase DTO [User] into the clean domain entity [AuthUser].
  static AuthUser _mapSupabaseUser(User user) {
    final metadata = user.userMetadata ?? {};
    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      displayName: (metadata['display_name'] as String?) ??
          (metadata['full_name'] as String?),
      avatarUrl: metadata['avatar_url'] as String?,
      emailVerified: user.emailConfirmedAt != null,
      createdAt: DateTime.tryParse(user.createdAt),
      updatedAt:
          user.updatedAt != null ? DateTime.tryParse(user.updatedAt!) : null,
    );
  }
}
