/// UI-specific form state model for authentication input screens.
library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_form_state.freezed.dart';

/// Immutable form state containing text values and field-level validation errors.
@freezed
class AuthFormState with _$AuthFormState {
  /// Creates an immutable [AuthFormState] instance.
  const factory AuthFormState({
    @Default('') String email,
    @Default('') String password,
    @Default('') String displayName,
    @Default(true) bool isObscured,
    String? emailError,
    String? passwordError,
  }) = _AuthFormState;
}
