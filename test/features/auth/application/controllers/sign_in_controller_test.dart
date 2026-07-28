import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSignInRepository implements AuthRepository {
  bool shouldFail = false;
  AuthUser mockUser = const AuthUser(
    id: 'usr_sign_in_123',
    email: 'user@example.com',
  );

  @override
  Future<AuthUser> signIn({
    required Email email,
    required Password password,
  }) async {
    if (shouldFail) {
      throw const InvalidCredentialsFailure();
    }
    return mockUser;
  }

  @override
  Future<AuthUser> signUp({
    required Email email,
    required Password password,
    String? displayName,
  }) async =>
      mockUser;

  @override
  Future<void> signOut() async {}

  @override
  Future<AuthUser?> getCurrentUser() async => mockUser;

  @override
  Stream<AuthUser?> observeAuthState() => Stream.value(mockUser);

  @override
  Future<void> sendPasswordResetEmail({required Email email}) async {}

  @override
  Future<void> resendVerificationEmail({required Email email}) async {}

  @override
  Future<AuthUser?> refreshSession() async => mockUser;
}

void main() {
  late FakeSignInRepository fakeRepository;
  late ProviderContainer container;

  setUp(() {
    fakeRepository = FakeSignInRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(fakeRepository),
        signInUseCaseProvider.overrideWith(
          (ref) => SignInUseCase(ref.watch(authRepositoryProvider)),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('SignInController Unit Tests', () {
    test('signIn succeeds and emits AsyncData(null)', () async {
      final controller = container.read(signInControllerProvider.notifier);

      final result = await controller.signIn(
        email: 'user@example.com',
        password: 'Password123!',
      );

      expect(result, isTrue);
      final state = container.read(signInControllerProvider);
      expect(state, isA<AsyncData<void>>());
    });

    test('signIn fails on invalid credentials and emits AsyncError', () async {
      fakeRepository.shouldFail = true;
      final controller = container.read(signInControllerProvider.notifier);

      final result = await controller.signIn(
        email: 'user@example.com',
        password: 'WrongPassword123!',
      );

      expect(result, isFalse);
      final state = container.read(signInControllerProvider);
      expect(state, isA<AsyncError<void>>());
      expect(
        state.error.toString(),
        contains('Invalid email or password.'),
      );
    });

    test('signIn fails on invalid email format and emits validation error', () async {
      final controller = container.read(signInControllerProvider.notifier);

      final result = await controller.signIn(
        email: 'invalid-email-format',
        password: 'Password123!',
      );

      expect(result, isFalse);
      final state = container.read(signInControllerProvider);
      expect(state, isA<AsyncError<void>>());
      expect(
        state.error.toString(),
        contains('Please enter a valid email address.'),
      );
    });
  });
}
