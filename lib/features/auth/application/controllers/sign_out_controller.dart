/// Controller managing user sign-out application logic.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/application/controllers/base_auth_controller.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';

/// Riverpod controller managing sign-out execution and async state transitions.
class SignOutController extends BaseAuthController<void> {
  @override
  FutureOr<void> build() {
    // Initial state is idle data (null).
  }

  /// Executes [SignOutUseCase] to revoke session.
  ///
  /// Returns `true` if sign-out succeeded, or `false` on error.
  Future<bool> signOut() {
    return executeOperation(() async {
      final useCase = ref.read(signOutUseCaseProvider);
      await useCase();
    });
  }
}
