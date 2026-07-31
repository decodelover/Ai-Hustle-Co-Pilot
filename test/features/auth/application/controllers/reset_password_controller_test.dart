import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeResetPasswordRepository implements AuthRepository {
  bool shouldFail = false;

  @override
  Future<AuthUser> signIn({
    required Email email,
    required Password password,
  }) async => const AuthUser(id: '1', email: 'a@b.com');

  @override
  Future<AuthUser> signUp({
    required Email email,
    required Password password,
    String? displayName,
  }) async => const AuthUser(id: '1', email: 'a@b.com');

  @override
  Future<void> signOut() async {}

  @override
  Future<AuthUser?> getCurrentUser() async => null;

  @override
  Stream<AuthUser?> observeAuthState() => Stream.value(null);

  @override
  Future<void> sendPasswordResetEmail({required Email email}) async {
    if (shouldFail) {
      throw const NetworkFailure();
    }
  }

  @override
  Future<void> resendVerificationEmail({required Email email}) async {}

  @override
  Future<AuthUser?> refreshSession() async => null;

  @override
  Future<AuthUser> verifyOtp({
    required Email email,
    required String token,
  }) async => const AuthUser(id: 'usr_reset_1', email: 'reset@example.com');
}

void main() {
  late FakeResetPasswordRepository fakeRepository;
  late ProviderContainer container;

  setUp(() {
    fakeRepository = FakeResetPasswordRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(fakeRepository),
        resetPasswordUseCaseProvider.overrideWith(
          (ref) => ResetPasswordUseCase(ref.watch(authRepositoryProvider)),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('ResetPasswordController Unit Tests', () {
    test('resetPassword succeeds and emits AsyncData(null)', () async {
      final controller = container.read(
        resetPasswordControllerProvider.notifier,
      );

      final result = await controller.resetPassword(email: 'reset@example.com');

      expect(result, isTrue);
      final state = container.read(resetPasswordControllerProvider);
      expect(state, isA<AsyncData<void>>());
    });

    test(
      'resetPassword fails on network failure and emits AsyncError',
      () async {
        fakeRepository.shouldFail = true;
        final controller = container.read(
          resetPasswordControllerProvider.notifier,
        );

        final result = await controller.resetPassword(
          email: 'reset@example.com',
        );

        expect(result, isFalse);
        final state = container.read(resetPasswordControllerProvider);
        expect(state, isA<AsyncError<void>>());
        expect(
          state.error.toString(),
          contains('Network connection unavailable'),
        );
      },
    );
  });
}
