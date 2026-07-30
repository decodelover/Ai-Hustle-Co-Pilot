import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:ai_hustle_copilot/features/auth/domain/failures/auth_failure.dart';
import 'package:ai_hustle_copilot/features/auth/domain/repositories/auth_repository.dart';
import 'package:ai_hustle_copilot/features/auth/domain/use_cases/refresh_session_use_case.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/email.dart';
import 'package:ai_hustle_copilot/features/auth/domain/value_objects/password.dart';
import 'package:ai_hustle_copilot/features/auth/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeRefreshSessionRepository implements AuthRepository {
  bool shouldFail = false;
  AuthUser mockUser = const AuthUser(
    id: 'usr_refreshed_123',
    email: 'refresh@example.com',
  );

  @override
  Future<AuthUser> signIn({required Email email, required Password password}) async =>
      mockUser;

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
  Future<AuthUser?> refreshSession() async {
    if (shouldFail) {
      throw const SessionExpiredFailure();
    }
    return mockUser;
  }

  @override
  Future<AuthUser> verifyOtp({
    required Email email,
    required String token,
  }) async => mockUser;
}

void main() {
  late FakeRefreshSessionRepository fakeRepository;
  late ProviderContainer container;

  setUp(() {
    fakeRepository = FakeRefreshSessionRepository();
    container = ProviderContainer(
      overrides: [
        authRepositoryProvider.overrideWithValue(fakeRepository),
        refreshSessionUseCaseProvider.overrideWith(
          (ref) => RefreshSessionUseCase(ref.watch(authRepositoryProvider)),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('RefreshSessionController Unit Tests', () {
    test('refreshSession succeeds and emits AsyncData(null)', () async {
      final controller =
          container.read(refreshSessionControllerProvider.notifier);

      final result = await controller.refreshSession();

      expect(result, isTrue);
      final state = container.read(refreshSessionControllerProvider);
      expect(state, isA<AsyncData<void>>());
    });

    test('refreshSession fails on session expiration and emits AsyncError', () async {
      fakeRepository.shouldFail = true;
      final controller =
          container.read(refreshSessionControllerProvider.notifier);

      final result = await controller.refreshSession();

      expect(result, isFalse);
      final state = container.read(refreshSessionControllerProvider);
      expect(state, isA<AsyncError<void>>());
      expect(
        state.error.toString(),
        contains('Your session has expired.'),
      );
    });
  });
}
