/// UI-specific action state model for authentication operations.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_action_state.freezed.dart';

/// Immutable UI action state containing contextual success messages or user payloads.
@freezed
class AuthActionState with _$AuthActionState {
  /// Idle state before an action is performed.
  const factory AuthActionState.idle() = _Idle;

  /// Action completed successfully with optional user payload and toast message.
  const factory AuthActionState.success({
    String? message,
    AuthUser? user,
  }) = _Success;

  /// Action failed with presentation-friendly error message.
  const factory AuthActionState.failure({
    required String errorMessage,
  }) = _Failure;
}
