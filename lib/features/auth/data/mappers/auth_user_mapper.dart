/// Static mapper utility for translating user models across architecture layers.
library;

import 'package:ai_hustle_copilot/features/auth/data/dtos/auth_user_dto.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;

/// Static mapper for translating between Supabase User models, DTOs, and Domain Entities.
abstract final class AuthUserMapper {
  /// Converts a Supabase SDK [User] instance into an [AuthUserDto].
  static AuthUserDto supabaseUserToDto(User user) {
    return AuthUserDto.fromSupabaseUser(user);
  }

  /// Converts an [AuthUserDto] into a pure domain [AuthUser] entity.
  static AuthUser dtoToEntity(AuthUserDto dto) {
    return dto.toEntity();
  }

  /// Converts a pure domain [AuthUser] entity into an [AuthUserDto].
  static AuthUserDto entityToDto(AuthUser entity) {
    return AuthUserDto.fromEntity(entity);
  }

  /// Converts a Supabase SDK [User] instance directly into a domain [AuthUser] entity.
  static AuthUser supabaseUserToEntity(User user) {
    return dtoToEntity(supabaseUserToDto(user));
  }
}
