/// Domain Use Case for signing out the active user.
library;

import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';

/// Encapsulates the user sign-out business action.
class SignOutUseCase {
  /// Constructs a [SignOutUseCase] with the injected [AuthRepository].
  const SignOutUseCase(this._repository);

  final AuthRepository _repository;

  /// Executes sign-out and session revocation.
  Future<void> call() {
    return _repository.signOut();
  }
}
