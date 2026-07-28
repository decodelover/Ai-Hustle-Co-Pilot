/// Domain Use Case for retrieving the currently authenticated user.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';

/// Encapsulates fetching the active user session domain entity.
class GetCurrentUserUseCase {
  /// Constructs a [GetCurrentUserUseCase] with the injected [AuthRepository].
  const GetCurrentUserUseCase(this._repository);

  final AuthRepository _repository;

  /// Retrieves the active [AuthUser], or `null` if unauthenticated.
  Future<AuthUser?> call() {
    return _repository.getCurrentUser();
  }
}
