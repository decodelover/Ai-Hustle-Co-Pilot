import 'dart:async';

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/get_current_user_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/observe_auth_state_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/refresh_session_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/resend_verification_email_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:flutter_test/flutter_test.dart';

/// Fake implementation of [AuthRepository] for testing.
class FakeAuthRepository implements AuthRepository {
  AuthUser? currentUser;
  bool shouldFail = false;
  final StreamController<AuthUser?> _authStateController =
      StreamController<AuthUser?>.broadcast();

  @override
  Future<AuthUser> signIn({
    required Email email,
    required Password password,
  }) async {
    if (shouldFail) {
      throw const InvalidCredentialsFailure();
    }
    final user = AuthUser(id: 'usr_signed_in', email: email.value);
    currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<AuthUser> signUp({
    required Email email,
    required Password password,
    String? displayName,
  }) async {
    if (shouldFail) {
      throw const EmailAlreadyExistsFailure();
    }
    final user = AuthUser(
      id: 'usr_signed_up',
      email: email.value,
      displayName: displayName,
    );
    currentUser = user;
    _authStateController.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    if (shouldFail) {
      throw const UnknownAuthFailure(message: 'Sign out failed');
    }
    currentUser = null;
    _authStateController.add(null);
  }

  @override
  Future<AuthUser?> getCurrentUser() async {
    if (shouldFail) {
      throw const NetworkFailure();
    }
    return currentUser;
  }

  @override
  Stream<AuthUser?> observeAuthState() {
    return _authStateController.stream;
  }

  @override
  Future<void> sendPasswordResetEmail({required Email email}) async {
    if (shouldFail) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<void> resendVerificationEmail({required Email email}) async {
    if (shouldFail) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<AuthUser?> refreshSession() async {
    if (shouldFail) {
      throw const SessionExpiredFailure();
    }
    return currentUser;
  }

  void dispose() {
    _authStateController.close();
  }
}

void main() {
  late FakeAuthRepository repository;

  setUp(() {
    repository = FakeAuthRepository();
  });

  tearDown(() {
    repository.dispose();
  });

  group('Auth Domain Use Cases', () {
    final validEmail = Email('developer@aihustle.com');
    final validPassword = Password('P@ssword123');

    test('SignInUseCase executes repository signIn', () async {
      final useCase = SignInUseCase(repository);
      final user = await useCase(email: validEmail, password: validPassword);

      expect(user.id, 'usr_signed_in');
      expect(user.email, 'developer@aihustle.com');
    });

    test('SignInUseCase propagates AuthFailure on error', () async {
      repository.shouldFail = true;
      final useCase = SignInUseCase(repository);

      expect(
        () => useCase(email: validEmail, password: validPassword),
        throwsA(isA<InvalidCredentialsFailure>()),
      );
    });

    test('SignUpUseCase executes repository signUp', () async {
      final useCase = SignUpUseCase(repository);
      final user = await useCase(
        email: validEmail,
        password: validPassword,
        displayName: 'Dev Lead',
      );

      expect(user.id, 'usr_signed_up');
      expect(user.displayName, 'Dev Lead');
    });

    test('SignOutUseCase revokes user session', () async {
      repository.currentUser = const AuthUser(id: '1', email: 'test@a.com');
      final useCase = SignOutUseCase(repository);

      await useCase();
      expect(repository.currentUser, null);
    });

    test('GetCurrentUserUseCase retrieves active domain user', () async {
      const expected = AuthUser(id: '99', email: 'active@a.com');
      repository.currentUser = expected;

      final useCase = GetCurrentUserUseCase(repository);
      final actual = await useCase();

      expect(actual, equals(expected));
    });

    test('ObserveAuthStateUseCase streams auth user updates', () async {
      final useCase = ObserveAuthStateUseCase(repository);

      unawaited(
        expectLater(
          useCase(),
          emitsInOrder([
            const AuthUser(
              id: 'usr_signed_in',
              email: 'developer@aihustle.com',
            ),
            null,
          ]),
        ),
      );

      await repository.signIn(email: validEmail, password: validPassword);
      await repository.signOut();
    });

    test('ResetPasswordUseCase triggers password reset email', () async {
      final useCase = ResetPasswordUseCase(repository);
      await expectLater(
        useCase(email: validEmail),
        completes,
      );
    });

    test('ResendVerificationEmailUseCase triggers verification email', () async {
      final useCase = ResendVerificationEmailUseCase(repository);
      await expectLater(
        useCase(email: validEmail),
        completes,
      );
    });

    test('RefreshSessionUseCase refreshes active token session', () async {
      const expected = AuthUser(id: '77', email: 'refreshed@a.com');
      repository.currentUser = expected;

      final useCase = RefreshSessionUseCase(repository);
      final actual = await useCase();

      expect(actual, equals(expected));
    });
  });
}
