/// Unified reusable KPI Metric Card — Master Design System V2.0.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:flutter/material.dart';

/// Reusable KPI card displaying metrics, trend badge, icon, and accent highlights.
class DashboardMetricCard extends StatelessWidget {
  /// Creates a [DashboardMetricCard].
  const DashboardMetricCard({
    required this.model,
    this.onTap,
    super.key,
  });

  /// Injected domain model.
  final DashboardMetricCardModel model;

  /// Optional tap handler.
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final trendColor = model.isPositiveTrend
        ? const Color(0xFF10B981)
        : const Color(0xFFEF4444);

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(24.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24.0),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (model.accentColor ?? const Color(0xFF0D1B2A))
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Icon(
                      model.icon,
                      size: 20,
                      color: model.accentColor ?? const Color(0xFF0D1B2A),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        color: trendColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            model.isPositiveTrend
                                ? Icons.arrow_upward_rounded
                                : Icons.arrow_downward_rounded,
                            size: 12,
                            color: trendColor,
                          ),
                          const SizedBox(width: 2),
                          Flexible(
                            child: Text(
                              '${model.trendPercentage.abs().toStringAsFixed(1)}%',
                              style: TextStyle(
                                color: trendColor,
                                fontSize: 11.0,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.title,
                    style: const TextStyle(
                      color: Color(0xFF6B7280),
                      fontSize: 12.0,
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2.0),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      model.value,
                      style: const TextStyle(
                        color: Color(0xFF111827),
                        fontSize: 24.0,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                      ),
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
