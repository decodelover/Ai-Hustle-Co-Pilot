/// Controller managing user sign-in application logic.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/application/controllers/base_auth_controller.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';

/// Riverpod controller managing sign-in execution and async state transitions.
class SignInController extends BaseAuthController<void> {
  @override
  FutureOr<void> build() {
    // Initial state is idle data (null).
  }

  /// Validates input credentials and executes [SignInUseCase].
  ///
  /// Returns `true` if sign-in succeeded, or `false` on error.
  Future<bool> signIn({required String email, required String password}) {
    return executeOperation(() async {
      final emailVo = Email(email);
      final passwordVo = Password(password);
      final useCase = ref.read(signInUseCaseProvider);
      await useCase(email: emailVo, password: passwordVo);
    });
  }
}
