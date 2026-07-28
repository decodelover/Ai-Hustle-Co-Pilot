import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/sign_out_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeSignOutRepository implements AuthRepository {
  bool shouldFail = false;

  @override
  Future<AuthUser> signIn({required Email email, required Password password}) async =>
      const AuthUser(id: '1', email: 'a@b.com');

  @override
  Future<AuthUser> signUp({
    required Email email,
    required Password password,
    String? displayName,
  }) async =>
      const AuthUser(id: '1', email: 'a@b.com');

  @override
  Future<void> signOut() async {
    if (shouldFail) {
      throw const UnknownAuthFailure(message: 'Sign out failed');
    }
  }

  @override
  Future<AuthUser?> getCurrentUser() async => null;

  @override
  Stream<AuthUser?> observeAuthState() => Stream.value(null);

  @override
  Future<void> sendPasswordResetEmail({required Email email}) async {}

  @override
  Future<void> resendVerificationEmail({required Email email}) async {}

  @override
  Future<AuthUser?> refreshSession() async => null;
}

void main() {
  late FakeSignOutRepository fakeRepository;
  late ProviderContainer container;

  setUp(() {
    fakeRepository = FakeSignOutRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(fakeRepository),
        signOutUseCaseProvider.overrideWith(
          (ref) => SignOutUseCase(ref.watch(authRepositoryProvider)),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('SignOutController Unit Tests', () {
    test('signOut succeeds and emits AsyncData(null)', () async {
      final controller = container.read(signOutControllerProvider.notifier);

      final result = await controller.signOut();

      expect(result, isTrue);
      final state = container.read(signOutControllerProvider);
      expect(state, isA<AsyncData<void>>());
    });

    test('signOut fails and emits AsyncError', () async {
      fakeRepository.shouldFail = true;
      final controller = container.read(signOutControllerProvider.notifier);

      final result = await controller.signOut();

      expect(result, isFalse);
      final state = container.read(signOutControllerProvider);
      expect(state, isA<AsyncError<void>>());
      expect(state.error.toString(), contains('Sign out failed'));
    });
  });
}
