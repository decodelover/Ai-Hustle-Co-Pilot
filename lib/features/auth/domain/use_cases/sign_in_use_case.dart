/// Domain Use Case for signing in a user.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';

/// Encapsulates the user sign-in business action.
class SignInUseCase {
  /// Constructs a [SignInUseCase] with the injected [AuthRepository].
  const SignInUseCase(this._repository);

  final AuthRepository _repository;

  /// Executes user sign-in using [email] and [password].
  Future<AuthUser> call({required Email email, required Password password}) {
    return _repository.signIn(email: email, password: password);
  }
}
