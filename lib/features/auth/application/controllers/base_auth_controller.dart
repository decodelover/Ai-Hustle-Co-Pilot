/// Abstract base controller for authentication application operations.
library;

import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/value_object_exception.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Abstract reusable base controller centralizing async execution, state management,
/// and failure-to-message translation for Riverpod auth controllers.
abstract class BaseAuthController<T> extends AutoDisposeAsyncNotifier<T> {
  /// Maps domain exceptions ([AuthValidationException], [AuthFailure]) into user-friendly error messages.
  String mapFailureToMessage(Object error) {
    if (error is AuthValidationException) {
      return error.message;
    }
    if (error is AuthFailure) {
      return error.message;
    }
    return 'An unexpected error occurred. Please try again.';
  }

  /// Executes an async domain [action] with standard Riverpod [AsyncValue] lifecycle handling:
  /// - Emits [AsyncLoading] before execution
  /// - Emits [AsyncData] on successful execution
  /// - Catches exceptions, maps to user message, and emits [AsyncError] on failure
  ///
  /// Returns `true` if the operation succeeded, or `false` if an error occurred.
  Future<bool> executeOperation(Future<T> Function() action) async {
    state = const AsyncLoading();
    try {
      final result = await action();
      state = AsyncData(result);
      return true;
    } catch (error, stackTrace) {
      final userMessage = mapFailureToMessage(error);
      state = AsyncError(userMessage, stackTrace);
      return false;
    }
  }
}
