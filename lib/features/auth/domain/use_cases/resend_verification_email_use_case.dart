/// Domain Use Case for resending email verification links.
library;

import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';

/// Encapsulates resending the account verification email.
class ResendVerificationEmailUseCase {
  /// Constructs a [ResendVerificationEmailUseCase] with the injected [AuthRepository].
  const ResendVerificationEmailUseCase(this._repository);

  final AuthRepository _repository;

  /// Resends the verification email to [email].
  Future<void> call({required Email email}) {
    return _repository.resendVerificationEmail(email: email);
  }
}
