/// Workspace model for multi-tenant switching in AI Hustle Co-Pilot.
library;

import 'package:flutter/material.dart';

/// Immutable domain model representing a user workspace.
@immutable
class Workspace {
  /// Creates a [Workspace].
  const Workspace({
    required this.id,
    required this.name,
    required this.planTier,
    this.avatarUrl,
    this.memberCount = 1,
    this.isPersonal = false,
  });

  /// Workspace ID.
  final String id;

  /// Workspace name.
  final String name;

  /// Subscription tier (e.g. 'Pro Member', 'Enterprise', 'Free Tier').
  final String planTier;

  /// Optional avatar image URL.
  final String? avatarUrl;

  /// Member count.
  final int memberCount;

  /// Personal workspace flag.
  final bool isPersonal;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Workspace &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
