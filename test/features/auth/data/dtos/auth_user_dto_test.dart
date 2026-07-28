import 'package:ai_hustle_copilot/features/auth/data/dtos/auth_user_dto.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthUserDto Unit Tests', () {
    final now = DateTime.now();

    final dto = AuthUserDto(
      id: 'usr_dto_1',
      email: 'dto@example.com',
      displayName: 'DTO User',
      avatarUrl: 'https://example.com/dto.png',
      emailVerified: true,
      createdAt: now,
      updatedAt: now,
    );

    test('toJson and fromJson work bi-directionally', () {
      final json = dto.toJson();
      final reconstituted = AuthUserDto.fromJson(json);

      expect(reconstituted, equals(dto));
    });

    test('toEntity converts DTO into AuthUser entity', () {
      final entity = dto.toEntity();

      expect(entity, isA<AuthUser>());
      expect(entity.id, 'usr_dto_1');
      expect(entity.email, 'dto@example.com');
      expect(entity.displayName, 'DTO User');
      expect(entity.avatarUrl, 'https://example.com/dto.png');
      expect(entity.emailVerified, isTrue);
    });

    test('fromEntity converts AuthUser entity into DTO', () {
      final entity = AuthUser(
        id: 'usr_ent_1',
        email: 'ent@example.com',
        displayName: 'Entity User',
        avatarUrl: 'https://example.com/ent.png',
        createdAt: now,
        updatedAt: now,
      );

      final convertedDto = AuthUserDto.fromEntity(entity);

      expect(convertedDto.id, 'usr_ent_1');
      expect(convertedDto.email, 'ent@example.com');
      expect(convertedDto.displayName, 'Entity User');
      expect(convertedDto.emailVerified, isFalse);
    });
  });
}
