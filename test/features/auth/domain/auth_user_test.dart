import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthUser Entity', () {
    final now = DateTime.now();
    final user1 = AuthUser(
      id: 'usr_123',
      email: 'alex@example.com',
      displayName: 'Alex Developer',
      avatarUrl: 'https://example.com/avatar.png',
      emailVerified: true,
      createdAt: now,
      updatedAt: now,
    );

    test('value equality and hashcode work correctly', () {
      final user2 = AuthUser(
        id: 'usr_123',
        email: 'alex@example.com',
        displayName: 'Alex Developer',
        avatarUrl: 'https://example.com/avatar.png',
        emailVerified: true,
        createdAt: now,
        updatedAt: now,
      );

      const user3 = AuthUser(
        id: 'usr_456',
        email: 'alex@example.com',
      );

      expect(user1, equals(user2));
      expect(user1.hashCode, equals(user2.hashCode));
      expect(user1, isNot(equals(user3)));
    });

    test('copyWith modifies requested fields while preserving others', () {
      final updated = user1.copyWith(
        displayName: 'Alex Senior Dev',
        emailVerified: false,
      );

      expect(updated.id, 'usr_123');
      expect(updated.email, 'alex@example.com');
      expect(updated.displayName, 'Alex Senior Dev');
      expect(updated.emailVerified, isFalse);
      expect(updated.avatarUrl, 'https://example.com/avatar.png');
      expect(updated.createdAt, now);
      expect(updated.updatedAt, now);
    });

    test('toString produces readable output', () {
      expect(
        user1.toString(),
        contains('AuthUser(id: usr_123, email: alex@example.com'),
      );
    });
  });
}
