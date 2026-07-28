/// Domain Use Case for registering a new user account.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';

/// Encapsulates the user sign-up business action.
class SignUpUseCase {
  /// Constructs a [SignUpUseCase] with the injected [AuthRepository].
  const SignUpUseCase(this._repository);

  final AuthRepository _repository;

  /// Executes user sign-up with [email], [password], and optional [displayName].
  Future<AuthUser> call({
    required Email email,
    required Password password,
    String? displayName,
  }) {
    return _repository.signUp(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}
