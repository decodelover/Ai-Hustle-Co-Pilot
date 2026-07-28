/// Domain model for active project summary cards.
library;

import 'package:flutter/material.dart';

/// Status of an active project.
enum ProjectStatus {
  inProgress,
  review,
  completed,
  archived,
}

/// Immutable domain model representing a recent project on the dashboard.
@immutable
class RecentProjectModel {
  /// Creates a [RecentProjectModel].
  const RecentProjectModel({
    required this.id,
    required this.title,
    required this.clientName,
    required this.progress,
    required this.status,
    required this.lastUpdated,
    required this.tags,
    required this.aiUsageScore,
    this.ownerAvatarUrl,
  });

  /// Unique project ID.
  final String id;

  /// Project title.
  final String title;

  /// Client or organization name.
  final String clientName;

  /// Progress fraction (0.0 to 1.0).
  final double progress;

  /// Active status.
  final ProjectStatus status;

  /// Last updated timestamp.
  final DateTime lastUpdated;

  /// Tag labels.
  final List<String> tags;

  /// AI score rating (0-100).
  final int aiUsageScore;

  /// Owner avatar image URL.
  final String? ownerAvatarUrl;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentProjectModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          clientName == other.clientName &&
          progress == other.progress &&
          status == other.status &&
          lastUpdated == other.lastUpdated &&
          aiUsageScore == other.aiUsageScore &&
          ownerAvatarUrl == other.ownerAvatarUrl;

  @override
  int get hashCode => Object.hash(
        id,
        title,
        clientName,
        progress,
        status,
        lastUpdated,
        aiUsageScore,
        ownerAvatarUrl,
      );
}
