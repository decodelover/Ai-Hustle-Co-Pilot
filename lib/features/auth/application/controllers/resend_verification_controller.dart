/// Controller managing email verification resend application logic.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/application/controllers/base_auth_controller.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';

/// Riverpod controller managing email verification link resend requests.
class ResendVerificationController extends BaseAuthController<void> {
  @override
  FutureOr<void> build() {
    // Initial state is idle data (null).
  }

  /// Validates [email] and executes [ResendVerificationEmailUseCase].
  ///
  /// Returns `true` if verification email was resent, or `false` on error.
  Future<bool> resendVerification({required String email}) {
    return executeOperation(() async {
      final emailVo = Email(email);
      final useCase = ref.read(resendVerificationEmailUseCaseProvider);
      await useCase(email: emailVo);
    });
  }
}
