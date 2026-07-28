/// Controller managing account registration application logic.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/application/controllers/base_auth_controller.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';

/// Riverpod controller managing user registration and async state transitions.
class SignUpController extends BaseAuthController<void> {
  @override
  FutureOr<void> build() {
    // Initial state is idle data (null).
  }

  /// Validates inputs and executes [SignUpUseCase].
  ///
  /// Returns `true` if registration succeeded, or `false` on error.
  Future<bool> signUp({
    required String email,
    required String password,
    String? displayName,
  }) {
    return executeOperation(() async {
      final emailVo = Email(email);
      final passwordVo = Password(password);
      final useCase = ref.read(signUpUseCaseProvider);
      await useCase(
        email: emailVo,
        password: passwordVo,
        displayName: displayName,
      );
    });
  }
}
