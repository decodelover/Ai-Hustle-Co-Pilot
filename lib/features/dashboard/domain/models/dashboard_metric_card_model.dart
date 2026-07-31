/// Domain model for reusable KPI metric cards.
library;

import 'package:flutter/material.dart';

/// Immutable domain model representing a single KPI metric card on the dashboard.
@immutable
class DashboardMetricCardModel {
  /// Creates a [DashboardMetricCardModel].
  const DashboardMetricCardModel({
    required this.id,
    required this.title,
    required this.value,
    required this.trendPercentage,
    required this.isPositiveTrend,
    required this.icon,
    this.accentColor,
    this.subtitle,
  });

  /// Unique metric card identifier.
  final String id;

  /// Display title (e.g. "Active Projects", "AI Generations").
  final String title;

  /// Primary metric value (e.g. "24", "1,420").
  final String value;

  /// Percentage trend relative to previous period (e.g. 14.2).
  final double trendPercentage;

  /// Whether the trend is positive/favorable.
  final bool isPositiveTrend;

  /// Icon representing the metric.
  final IconData icon;

  /// Optional custom accent color override.
  final Color? accentColor;

  /// Optional contextual subtitle (e.g. "+3 this week").
  final String? subtitle;

  /// Creates a copy of this [DashboardMetricCardModel] with updated fields.
  DashboardMetricCardModel copyWith({
    String? id,
    String? title,
    String? value,
    double? trendPercentage,
    bool? isPositiveTrend,
    IconData? icon,
    Color? accentColor,
    String? subtitle,
  }) {
    return DashboardMetricCardModel(
      id: id ?? this.id,
      title: title ?? this.title,
      value: value ?? this.value,
      trendPercentage: trendPercentage ?? this.trendPercentage,
      isPositiveTrend: isPositiveTrend ?? this.isPositiveTrend,
      icon: icon ?? this.icon,
      accentColor: accentColor ?? this.accentColor,
      subtitle: subtitle ?? this.subtitle,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DashboardMetricCardModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          title == other.title &&
          value == other.value &&
          trendPercentage == other.trendPercentage &&
          isPositiveTrend == other.isPositiveTrend &&
          icon == other.icon &&
          accentColor == other.accentColor &&
          subtitle == other.subtitle;

  @override
  int get hashCode => Object.hash(
    id,
    title,
    value,
    trendPercentage,
    isPositiveTrend,
    icon,
    accentColor,
    subtitle,
  );
}
