/// Reusable responsive dashboard layout container.
library;

import 'package:ai_hustle_copilot/core/theme/app_breakpoints.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:flutter/material.dart';

/// Layout mode for the dashboard grid.
enum DashboardLayoutMode {
  phone,
  tablet,
  desktop,
  ultraWide,
}

/// Reusable responsive grid widget adapting children based on [AppBreakpoints].
class DashboardResponsiveGrid extends StatelessWidget {
  /// Creates a [DashboardResponsiveGrid].
  const DashboardResponsiveGrid({
    required this.header,
    required this.quickActions,
    required this.metricsGrid,
    required this.chartsSection,
    required this.recentProjects,
    required this.recentActivity,
    required this.aiInsights,
    super.key,
  });

  final Widget header;
  final Widget quickActions;
  final Widget metricsGrid;
  final Widget chartsSection;
  final Widget recentProjects;
  final Widget recentActivity;
  final Widget aiInsights;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppBreakpoints.ultraWide,
        ),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(
            horizontal: width < AppBreakpoints.compact
                ? AppSpacing.lg
                : width < AppBreakpoints.expanded
                    ? AppSpacing.xl
                    : AppSpacing.xxl,
            vertical: AppSpacing.lg,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header,
              const SizedBox(height: AppSpacing.xl),
              quickActions,
              const SizedBox(height: AppSpacing.xl),
              metricsGrid,
              const SizedBox(height: AppSpacing.xxl),

              // Layout adaptative content based on breakpoint
              if (width < AppBreakpoints.compact) ...[
                // Phone Layout: Single Column Stack
                chartsSection,
                const SizedBox(height: AppSpacing.xxl),
                aiInsights,
                const SizedBox(height: AppSpacing.xxl),
                recentProjects,
                const SizedBox(height: AppSpacing.xxl),
                recentActivity,
              ] else if (width < AppBreakpoints.expanded) ...[
                // Tablet Layout: 2-Column Split
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 6,
                      child: Column(
                        children: [
                          chartsSection,
                          const SizedBox(height: AppSpacing.xxl),
                          recentProjects,
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xl),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          aiInsights,
                          const SizedBox(height: AppSpacing.xxl),
                          recentActivity,
                        ],
                      ),
                    ),
                  ],
                ),
              ] else ...[
                // Desktop & UltraWide Layout: 3-Column Split
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          chartsSection,
                          const SizedBox(height: AppSpacing.xxl),
                          recentProjects,
                        ],
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xxl),
                    Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          aiInsights,
                          const SizedBox(height: AppSpacing.xxl),
                          recentActivity,
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
