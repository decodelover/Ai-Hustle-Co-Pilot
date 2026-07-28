/// Domain Use Case for requesting a password reset email.
library;

import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';

/// Encapsulates sending a password recovery email.
class ResetPasswordUseCase {
  /// Constructs a [ResetPasswordUseCase] with the injected [AuthRepository].
  const ResetPasswordUseCase(this._repository);

  final AuthRepository _repository;

  /// Sends a password reset email to [email].
  Future<void> call({required Email email}) {
    return _repository.sendPasswordResetEmail(email: email);
  }
}
