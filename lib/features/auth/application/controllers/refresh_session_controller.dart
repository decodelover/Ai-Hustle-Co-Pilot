/// Controller managing token session refresh application logic.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/application/controllers/base_auth_controller.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';

/// Riverpod controller managing session token refreshes.
class RefreshSessionController extends BaseAuthController<void> {
  @override
  FutureOr<void> build() {
    // Initial state is idle data (null).
  }

  /// Executes [RefreshSessionUseCase] to refresh session tokens.
  ///
  /// Returns `true` if session token refresh succeeded, or `false` on error.
  Future<bool> refreshSession() {
    return executeOperation(() async {
      final useCase = ref.read(refreshSessionUseCaseProvider);
      await useCase();
    });
  }
}
