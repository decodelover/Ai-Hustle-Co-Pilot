/// Primary Landing Dashboard View Screen — AI Hustle Co-Pilot Command Center.
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_error_state.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
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
class DashboardScreen extends ConsumerStatefulWidget {
  /// Creates a [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.04),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
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
            return FadeTransition(
              opacity: _fadeAnim,
              child: SlideTransition(
                position: _slideAnim,
                child: RefreshIndicator(
                  onRefresh: () =>
                      ref.read(dashboardControllerProvider.notifier).refresh(),
                  child: DashboardResponsiveGrid(
                    header: DashboardHeaderWidget(
                      userName: 'Alex Manager',
                      workspaceName: 'AI Hustle Studio',
                      productivityScore: state.productivityScore,
                      creditsRemaining: state.creditsRemaining,
                      onNewProjectPressed: () => context.goNamed(RouteNames.aiStudio),
                      onRefreshPressed: () =>
                          ref.read(dashboardControllerProvider.notifier).refresh(),
                    ),
                    quickActions: QuickActionsGrid(actions: state.quickActions),
                    metricsGrid: LayoutBuilder(
                      builder: (context, constraints) {
                        final isCompact = constraints.maxWidth < 600;
                        final isTablet = constraints.maxWidth >= 600 && constraints.maxWidth < 1024;
                        final crossAxisCount = isCompact ? 2 : (isTablet ? 3 : 4);

                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            mainAxisSpacing: 16.0,
                            crossAxisSpacing: 16.0,
                            childAspectRatio: isCompact ? 1.15 : (isTablet ? 1.35 : 1.45),
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
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
