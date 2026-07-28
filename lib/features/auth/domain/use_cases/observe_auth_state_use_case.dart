/// Domain Use Case for streaming real-time authentication state.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';

/// Encapsulates subscribing to auth session state changes.
class ObserveAuthStateUseCase {
  /// Constructs an [ObserveAuthStateUseCase] with the injected [AuthRepository].
  const ObserveAuthStateUseCase(this._repository);

  final AuthRepository _repository;

  /// Returns a stream emitting the active [AuthUser] or `null`.
  Stream<AuthUser?> call() {
    return _repository.observeAuthState();
  }
}
