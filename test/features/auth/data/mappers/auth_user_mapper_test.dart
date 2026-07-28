import 'package:ai_hustle_copilot/features/auth/data/dtos/auth_user_dto.dart';
import 'package:ai_hustle_copilot/features/auth/data/mappers/auth_user_mapper.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthUserMapper Unit Tests', () {
    final now = DateTime.now();

    final dto = AuthUserDto(
      id: 'usr_map_1',
      email: 'mapper@example.com',
      displayName: 'Mapper User',
      avatarUrl: 'https://example.com/avatar.png',
      emailVerified: true,
      createdAt: now,
      updatedAt: now,
    );

    final entity = AuthUser(
      id: 'usr_map_1',
      email: 'mapper@example.com',
      displayName: 'Mapper User',
      avatarUrl: 'https://example.com/avatar.png',
      emailVerified: true,
      createdAt: now,
      updatedAt: now,
    );

    test('dtoToEntity correctly transforms DTO to domain AuthUser', () {
      final result = AuthUserMapper.dtoToEntity(dto);
      expect(result, equals(entity));
    });

    test('entityToDto correctly transforms domain AuthUser to DTO', () {
      final result = AuthUserMapper.entityToDto(entity);
      expect(result, equals(dto));
    });
  });
}
