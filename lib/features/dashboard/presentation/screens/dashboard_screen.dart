/// Primary Landing Dashboard View Screen.
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_error_state.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/application/controllers/dashboard_controller.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/ai_insights_panel.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/analytics_charts_section.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_header_widget.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_metric_card.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_responsive_grid.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_skeleton_loader.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/quick_actions_grid.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/recent_activity_feed.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/recent_projects_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Primary Master Dashboard Screen of AI Hustle Co-Pilot.
class DashboardScreen extends ConsumerWidget {
  /// Creates a [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dashboardAsync = ref.watch(dashboardControllerProvider);

    return Scaffold(
      body: SafeArea(
        child: dashboardAsync.when(
          loading: () => const DashboardSkeletonLoader(),
          error: (error, stackTrace) => AppErrorState(
            title: 'Failed to load Dashboard',
            message: error.toString(),
            onRetry: () =>
                ref.read(dashboardControllerProvider.notifier).refresh(),
          ),
          data: (state) {
            return RefreshIndicator(
              onRefresh: () =>
                  ref.read(dashboardControllerProvider.notifier).refresh(),
              child: DashboardResponsiveGrid(
                header: DashboardHeaderWidget(
                  userName: 'Alex Manager',
                  workspaceName: 'AI Hustle Studio',
                  productivityScore: state.productivityScore,
                  creditsRemaining: state.creditsRemaining,
                  onNewProjectPressed: () => context.goNamed(RouteNames.dashboard),
                  onRefreshPressed: () =>
                      ref.read(dashboardControllerProvider.notifier).refresh(),
                ),
                quickActions: QuickActionsGrid(actions: state.quickActions),
                metricsGrid: LayoutBuilder(
                  builder: (context, constraints) {
                    final isCompact = constraints.maxWidth < 600;
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isCompact ? 2 : 3,
                        mainAxisSpacing: AppSpacing.md,
                        crossAxisSpacing: AppSpacing.md,
                        childAspectRatio: isCompact ? 1.4 : 1.6,
                      ),
                      itemCount: state.metrics.length,
                      itemBuilder: (context, index) {
                        return DashboardMetricCard(
                          model: state.metrics[index],
                        );
                      },
                    );
                  },
                ),
                chartsSection: AnalyticsChartsSection(
                  selectedTimeframe: state.selectedTimeframe,
                  onTimeframeChanged: (timeframe) {
                    ref
                        .read(dashboardControllerProvider.notifier)
                        .setChartTimeframe(timeframe);
                  },
                ),
                recentProjects: RecentProjectsList(projects: state.projects),
                recentActivity: RecentActivityFeed(activities: state.activities),
                aiInsights: AiInsightsPanel(
                  insights: state.insights,
                  onDismiss: (id) => ref
                      .read(dashboardControllerProvider.notifier)
                      .dismissInsight(id),
                  onToggleFavorite: (id) => ref
                      .read(dashboardControllerProvider.notifier)
                      .toggleFavoriteInsight(id),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
