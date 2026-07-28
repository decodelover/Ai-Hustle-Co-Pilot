/// Domain model for AI insights and tips cards.
library;

import 'package:flutter/material.dart';

/// Type of AI insight.
enum InsightType {
  recommendation,
  productivityTip,
  usageAlert,
  automationSuggestion,
}

/// Priority level of AI insight.
enum InsightPriority {
  high,
  medium,
  low,
}

/// Immutable domain model representing an AI recommendation card.
@immutable
class InsightCardModel {
  /// Creates an [InsightCardModel].
  const InsightCardModel({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.priority,
    required this.actionLabel,
    required this.impactScore,
    this.targetRoute,
    this.isDismissed = false,
    this.isFavorite = false,
  });

  /// Unique insight identifier.
  final String id;

  /// Recommendation title.
  final String title;

  /// Detailed insight description.
  final String description;

  /// Category type.
  final InsightType type;

  /// Priority urgency.
  final InsightPriority priority;

  /// Button CTA label.
  final String actionLabel;

  /// Predicted impact percentage (e.g. 28%).
  final int impactScore;

  /// Navigation target when CTA tapped.
  final String? targetRoute;

  /// Whether the user dismissed this card.
  final bool isDismissed;

  /// Whether bookmarked as favorite.
  final bool isFavorite;

  /// Returns a copy of this model with updated state flags.
  InsightCardModel copyWith({
    String? id,
    String? title,
    String? description,
    InsightType? type,
    InsightPriority? priority,
    String? actionLabel,
    int? impactScore,
    String? targetRoute,
    bool? isDismissed,
    bool? isFavorite,
  }) {
    return InsightCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      actionLabel: actionLabel ?? this.actionLabel,
      impactScore: impactScore ?? this.impactScore,
      targetRoute: targetRoute ?? this.targetRoute,
      isDismissed: isDismissed ?? this.isDismissed,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InsightCardModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          description == other.description &&
          type == other.type &&
          priority == other.priority &&
          actionLabel == other.actionLabel &&
          impactScore == other.impactScore &&
          targetRoute == other.targetRoute &&
          isDismissed == other.isDismissed &&
          isFavorite == other.isFavorite;

  @override
  int get hashCode => Object.hash(
        id,
        title,
        description,
        type,
        priority,
        actionLabel,
        impactScore,
        targetRoute,
        isDismissed,
        isFavorite,
      );
}
