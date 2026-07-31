/// Data Transfer Object for User model serialized to/from JSON or Supabase User.
library;

import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show User;

part 'auth_user_dto.freezed.dart';
part 'auth_user_dto.g.dart';

/// Data Transfer Object representing user data at the network/data source boundary.
@freezed
class AuthUserDto with _$AuthUserDto {
  /// Creates an immutable [AuthUserDto] instance.
  const factory AuthUserDto({
    required String id,
    required String email,
    String? displayName,
    String? avatarUrl,
    @Default(false) bool emailVerified,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _AuthUserDto;

  const AuthUserDto._();

  /// Deserializes [AuthUserDto] from a JSON map.
  factory AuthUserDto.fromJson(Map<String, dynamic> json) =>
      _$AuthUserDtoFromJson(json);

  /// Constructs an [AuthUserDto] from a Supabase SDK [User] object.
  factory AuthUserDto.fromSupabaseUser(User user) {
    final metadata = user.userMetadata ?? {};
    return AuthUserDto(
      id: user.id,
      email: user.email ?? '',
      displayName:
          (metadata['display_name'] as String?) ??
          (metadata['full_name'] as String?),
      avatarUrl: metadata['avatar_url'] as String?,
      emailVerified: user.emailConfirmedAt != null,
      createdAt: DateTime.tryParse(user.createdAt),
      updatedAt: user.updatedAt != null
          ? DateTime.tryParse(user.updatedAt!)
          : null,
    );
  }

  /// Constructs an [AuthUserDto] from a domain [AuthUser] entity.
  factory AuthUserDto.fromEntity(AuthUser entity) {
    return AuthUserDto(
      id: entity.id,
      email: entity.email,
      displayName: entity.displayName,
      avatarUrl: entity.avatarUrl,
      emailVerified: entity.emailVerified,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  /// Converts this [AuthUserDto] to a domain [AuthUser] entity.
  AuthUser toEntity() {
    return AuthUser(
      id: id,
      email: email,
      displayName: displayName,
      avatarUrl: avatarUrl,
      emailVerified: emailVerified,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
