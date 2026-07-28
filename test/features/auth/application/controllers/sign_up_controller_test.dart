import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSignUpRepository implements AuthRepository {
  bool shouldFail = false;
  AuthUser mockUser = const AuthUser(
    id: 'usr_sign_up_123',
    email: 'newuser@example.com',
    displayName: 'New User',
  );

  @override
  Future<AuthUser> signIn({required Email email, required Password password}) async =>
      mockUser;

  @override
  Future<AuthUser> signUp({
    required Email email,
    required Password password,
    String? displayName,
  }) async {
    if (shouldFail) {
      throw const EmailAlreadyExistsFailure();
    }
    return mockUser;
  }

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
  late FakeSignUpRepository fakeRepository;
  late ProviderContainer container;

  setUp(() {
    fakeRepository = FakeSignUpRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(fakeRepository),
        signUpUseCaseProvider.overrideWith(
          (ref) => SignUpUseCase(ref.watch(authRepositoryProvider)),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('SignUpController Unit Tests', () {
    test('signUp succeeds and emits AsyncData(null)', () async {
      final controller = container.read(signUpControllerProvider.notifier);

      final result = await controller.signUp(
        email: 'newuser@example.com',
        password: 'Password123!',
        displayName: 'New User',
      );

      expect(result, isTrue);
      final state = container.read(signUpControllerProvider);
      expect(state, isA<AsyncData<void>>());
    });

    test('signUp fails when email exists and emits AsyncError', () async {
      fakeRepository.shouldFail = true;
      final controller = container.read(signUpControllerProvider.notifier);

      final result = await controller.signUp(
        email: 'newuser@example.com',
        password: 'Password123!',
      );

      expect(result, isFalse);
      final state = container.read(signUpControllerProvider);
      expect(state, isA<AsyncError<void>>());
      expect(
        state.error.toString(),
        contains('An account with this email address already exists.'),
      );
    });
  });
}
