import 'dart:async';
import 'dart:io';

import 'package:ai_hustle_copilot/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:ai_hustle_copilot/features/auth/data/dtos/auth_user_dto.dart';
import 'package:ai_hustle_copilot/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Fake [AuthRemoteDataSource] implementation for unit testing.
class FakeAuthRemoteDataSource implements AuthRemoteDataSource {
  AuthUserDto? mockUser = const AuthUserDto(
    id: 'usr_repo_test',
    email: 'test@aihustle.com',
    displayName: 'Test User',
  );

  Exception? errorToThrow;
  final StreamController<AuthUserDto?> _streamController =
      StreamController<AuthUserDto?>.broadcast();

  @override
  Future<AuthUserDto> signIn({
    required String email,
    required String password,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return mockUser!;
  }

  @override
  Future<AuthUserDto> signUp({
    required String email,
    required String password,
    String? displayName,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return mockUser!;
  }

  @override
  Future<void> signOut() async {
    if (errorToThrow != null) throw errorToThrow!;
    mockUser = null;
  }

  @override
  Future<AuthUserDto?> currentUser() async {
    if (errorToThrow != null) throw errorToThrow!;
    return mockUser;
  }

  @override
  Stream<AuthUserDto?> authStateChanges() {
    return _streamController.stream;
  }

  @override
  Future<void> resetPassword({required String email}) async {
    if (errorToThrow != null) throw errorToThrow!;
  }

  @override
  Future<void> resendVerification({required String email}) async {
    if (errorToThrow != null) throw errorToThrow!;
  }

  @override
  Future<AuthUserDto?> refreshSession() async {
    if (errorToThrow != null) throw errorToThrow!;
    return mockUser;
  }

  @override
  Future<AuthUserDto> verifyOtp({
    required String email,
    required String token,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return mockUser!;
  }

  void emitState(AuthUserDto? dto) {
    _streamController.add(dto);
  }

  void emitError(Object error) {
    _streamController.addError(error);
  }

  void dispose() {
    _streamController.close();
  }
}

void main() {
  late FakeAuthRemoteDataSource dataSource;
  late AuthRepositoryImpl repository;

  final email = Email('test@aihustle.com');
  final password = Password('P@ssword123');

  setUp(() {
    dataSource = FakeAuthRemoteDataSource();
    repository = AuthRepositoryImpl(remoteDataSource: dataSource);
  });

  tearDown(() {
    dataSource.dispose();
  });

  group('AuthRepositoryImpl Unit Tests', () {
    test('signIn returns domain AuthUser on success', () async {
      final user = await repository.signIn(email: email, password: password);

      expect(user, isA<AuthUser>());
      expect(user.id, 'usr_repo_test');
      expect(user.email, 'test@aihustle.com');
    });

    test('signUp returns domain AuthUser on success', () async {
      final user = await repository.signUp(
        email: email,
        password: password,
        displayName: 'Test User',
      );

      expect(user, isA<AuthUser>());
      expect(user.displayName, 'Test User');
    });

    test('signOut revokes session cleanly', () async {
      await expectLater(repository.signOut(), completes);
      final current = await repository.getCurrentUser();
      expect(current, isNull);
    });

    test('getCurrentUser returns domain AuthUser if signed in', () async {
      final current = await repository.getCurrentUser();
      expect(current?.id, 'usr_repo_test');
    });

    test(
      'sendPasswordResetEmail and resendVerificationEmail complete',
      () async {
        await expectLater(
          repository.sendPasswordResetEmail(email: email),
          completes,
        );
        await expectLater(
          repository.resendVerificationEmail(email: email),
          completes,
        );
      },
    );

    test('refreshSession returns updated domain AuthUser', () async {
      final refreshed = await repository.refreshSession();
      expect(refreshed?.email, 'test@aihustle.com');
    });

    group('Exception to AuthFailure Mapping', () {
      test(
        'maps invalid login credentials to InvalidCredentialsFailure',
        () async {
          dataSource.errorToThrow = const supabase.AuthException(
            'Invalid login credentials',
            statusCode: '400',
          );

          expect(
            () => repository.signIn(email: email, password: password),
            throwsA(isA<InvalidCredentialsFailure>()),
          );
        },
      );

      test(
        'maps email already registered to EmailAlreadyExistsFailure',
        () async {
          dataSource.errorToThrow = const supabase.AuthException(
            'User already registered',
            statusCode: '409',
          );

          expect(
            () => repository.signUp(email: email, password: password),
            throwsA(isA<EmailAlreadyExistsFailure>()),
          );
        },
      );

      test('maps unconfirmed email to EmailNotVerifiedFailure', () async {
        dataSource.errorToThrow = const supabase.AuthException(
          'Email not confirmed',
          statusCode: '400',
        );

        expect(
          () => repository.signIn(email: email, password: password),
          throwsA(isA<EmailNotVerifiedFailure>()),
        );
      });

      test('maps weak password to WeakPasswordFailure', () async {
        dataSource.errorToThrow = const supabase.AuthException(
          'Weak password: should be longer',
          statusCode: '422',
        );

        expect(
          () => repository.signUp(email: email, password: password),
          throwsA(isA<WeakPasswordFailure>()),
        );
      });

      test('maps SocketException to NetworkFailure', () async {
        dataSource.errorToThrow = const SocketException('No Internet');

        expect(
          () => repository.signIn(email: email, password: password),
          throwsA(isA<NetworkFailure>()),
        );
      });

      test('maps 401 session expired to SessionExpiredFailure', () async {
        dataSource.errorToThrow = const supabase.AuthException(
          'JWT expired',
          statusCode: '401',
        );

        expect(
          () => repository.refreshSession(),
          throwsA(isA<SessionExpiredFailure>()),
        );
      });
    });
  });
}
