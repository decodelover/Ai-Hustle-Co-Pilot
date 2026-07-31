/// Domain Entity: ProjectMember (Phase 3.3)
library;

import 'package:flutter/foundation.dart';

/// Role assigned to a project team member.
enum MemberRole { owner, admin, contributor, viewer }

/// Immutable domain model representing a collaborator on an AI Project.
@immutable
final class ProjectMember {
  /// Creates a [ProjectMember].
  const ProjectMember({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    this.avatarUrl,
  });

  /// Member ID.
  final String id;

  /// Full name.
  final String name;

  /// Email address.
  final String email;

  /// Role in the project.
  final MemberRole role;

  /// Avatar image URL.
  final String? avatarUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProjectMember &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          role == other.role &&
          avatarUrl == other.avatarUrl;

  @override
  int get hashCode => Object.hash(id, name, email, role, avatarUrl);
}
