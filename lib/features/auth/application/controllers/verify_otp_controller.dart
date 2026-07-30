/// Controller managing OTP verification tasks.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/application/controllers/base_auth_controller.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';

/// Riverpod controller managing OTP code verification and state transitions.
class VerifyOtpController extends BaseAuthController<void> {
  @override
  FutureOr<void> build() {
    // Initial idle state.
  }

  /// Verifies an OTP code for [email] with [token].
  Future<bool> verifyOtp({
    required String email,
    required String token,
  }) {
    return executeOperation(() async {
      final emailVo = Email(email);
      final repository = ref.read(authRepositoryProvider);
      await repository.verifyOtp(
        email: emailVo,
        token: token.trim(),
      );
    });
  }
}
