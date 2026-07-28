/// Riverpod providers exposing Supabase infrastructure services.
///
/// These providers follow the Dependency Inversion Principle by
/// centralizing Supabase client access. Feature layers depend on
/// these providers rather than importing `supabase_flutter` directly.
///
/// ## Provider Dependency Chain
/// ```
/// supabaseClientProvider
///   └─ goTrueClientProvider
///       └─ authStateChangesProvider (Stream)
/// ```
library;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Provides the initialized [SupabaseClient] singleton.
///
/// Requires [Supabase.initialize] to have been called in
/// [AppInitializer] before the widget tree builds. All
/// Supabase operations (auth, database, storage, functions)
/// flow through this client.
final supabaseClientProvider = Provider<SupabaseClient>((ref) {
  return Supabase.instance.client;
});

/// Provides the [GoTrueClient] for authentication operations.
///
/// Exposes sign-in, sign-up, sign-out, session management,
/// and user metadata APIs. Feature-layer auth repositories
/// should depend on this provider.
final goTrueClientProvider = Provider<GoTrueClient>((ref) {
  return ref.watch(supabaseClientProvider).auth;
});

/// Streams real-time authentication state changes.
///
/// Emits [AuthState] events whenever the user's session changes:
/// - `signedIn` — user authenticated successfully
/// - `signedOut` — user signed out or session expired
/// - `tokenRefreshed` — access token was automatically refreshed
/// - `passwordRecovery` — password reset flow initiated
/// - `userUpdated` — user profile metadata changed
///
/// The stream is automatically managed by Riverpod — it subscribes
/// on first listen and disposes when no longer watched.
final authStateChangesProvider = StreamProvider<AuthState>((ref) {
  final goTrue = ref.watch(goTrueClientProvider);
  return goTrue.onAuthStateChange;
});
