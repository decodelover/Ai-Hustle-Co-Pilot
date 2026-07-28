/// Domain Use Case for refreshing the active user session token.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';

/// Encapsulates refreshing the authentication session token.
class RefreshSessionUseCase {
  /// Constructs a [RefreshSessionUseCase] with the injected [AuthRepository].
  const RefreshSessionUseCase(this._repository);

  final AuthRepository _repository;

  /// Refreshes session tokens and returns updated [AuthUser].
  Future<AuthUser?> call() {
    return _repository.refreshSession();
  }
}
