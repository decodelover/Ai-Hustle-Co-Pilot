/// Controller managing password reset application logic.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/application/controllers/base_auth_controller.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';

/// Riverpod controller managing password recovery email requests.
class ResetPasswordController extends BaseAuthController<void> {
  @override
  FutureOr<void> build() {
    // Initial state is idle data (null).
  }

  /// Validates [email] and executes [ResetPasswordUseCase].
  ///
  /// Returns `true` if password reset email was sent, or `false` on error.
  Future<bool> resetPassword({required String email}) {
    return executeOperation(() async {
      final emailVo = Email(email);
      final useCase = ref.read(resetPasswordUseCaseProvider);
      await useCase(email: emailVo);
    });
  }
}
