/// Authenticated dashboard command center.
library;

import 'package:ai_hustle_copilot/core/design_system/components/feedback/app_error_state.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_motion.dart';
import 'package:ai_hustle_copilot/features/dashboard/application/controllers/dashboard_controller.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/ai_insights_panel.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/analytics_charts_section.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_focus_cards.dart';
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

/// Primary authenticated landing surface.
class DashboardScreen extends ConsumerStatefulWidget {
  /// Creates a [DashboardScreen].
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppMotion.slow,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      if (MediaQuery.of(context).disableAnimations) {
        _animationController.value = 1;
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboardAsync = ref.watch(dashboardControllerProvider);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: dashboardAsync.when(
        loading: () => const DashboardSkeletonLoader(),
        error: (error, stackTrace) => AppErrorState(
          title: 'Dashboard unavailable',
          message: 'We could not refresh your workspace. Try again in a moment.',
          onRetry: () =>
              ref.read(dashboardControllerProvider.notifier).refresh(),
        ),
        data: (state) => _buildDashboard(context, state),
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, DashboardState state) {
    final visibleInsights = state.insights.where((item) => !item.isDismissed).toList();
    final focusInsight = visibleInsights.isNotEmpty ? visibleInsights.first : null;
    final focusProject = state.projects.isNotEmpty ? state.projects.first : null;
    final focusTitle = focusInsight?.title ??
        (focusProject == null ? 'Explore your next opportunity' : 'Continue ${focusProject.title}');
    final focusDescription = focusInsight?.description ??
        (focusProject == null
            ? 'Browse relevant opportunities and choose one clear step to start building momentum.'
            : 'Your latest project is ${((focusProject.progress) * 100).round()}% complete. Keep the handoff moving.');
    final focusAction = focusInsight?.actionLabel ??
        (focusProject == null ? 'Find opportunities' : 'Open active work');
    final focusRoute = focusInsight?.targetRoute ??
        (focusProject == null ? RoutePaths.discover : RoutePaths.projects);

    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _animationController,
        curve: AppMotion.decelerateCurve,
      ),
      child: RefreshIndicator(
        onRefresh: () =>
            ref.read(dashboardControllerProvider.notifier).refresh(),
        child: DashboardResponsiveGrid(
          header: DashboardHeaderWidget(
            userName: state.userName,
            workspaceName: 'Personal Workspace',
            productivityScore: state.productivityScore,
            creditsRemaining: state.creditsRemaining,
            onNewProjectPressed: () => context.go(RoutePaths.projects),
            onRefreshPressed: () =>
                ref.read(dashboardControllerProvider.notifier).refresh(),
          ),
          primaryFocus: PrimaryFocusCard(
            title: focusTitle,
            description: focusDescription,
            actionLabel: focusAction,
            onAction: () => context.go(focusRoute),
            icon: focusProject == null
                ? Icons.explore_outlined
                : Icons.arrow_forward_rounded,
          ),
          aiCopilot: AiCopilotCard(
            title: focusInsight == null
                ? 'Turn a rough idea into a clear next step.'
                : 'Use AI to move this recommendation forward.',
            description: 'Draft, organize, and refine work with the context already in your workspace.',
            onAction: () => context.go(RoutePaths.aiStudio),
          ),
          quickActions: QuickActionsGrid(actions: state.quickActions),
          metricsGrid: _buildMetricsGrid(state),
          chartsSection: AnalyticsChartsSection(
            selectedTimeframe: state.selectedTimeframe,
            productivityScore: state.productivityScore,
            activeProjects: state.projects.length,
            onTimeframeChanged: (timeframe) => ref
                .read(dashboardControllerProvider.notifier)
                .setChartTimeframe(timeframe),
          ),
          recentProjects: RecentProjectsList(projects: state.projects),
          recentActivity: RecentActivityFeed(activities: state.activities),
          aiInsights: AiInsightsPanel(
            insights: visibleInsights,
            onDismiss: (id) => ref
                .read(dashboardControllerProvider.notifier)
                .dismissInsight(id),
            onToggleFavorite: (id) => ref
                .read(dashboardControllerProvider.notifier)
                .toggleFavoriteInsight(id),
          ),
        ),
      ),
    );
  }

  Widget _buildMetricsGrid(DashboardState state) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth < 600
            ? 2
            : constraints.maxWidth < 960
            ? 3
            : 4;
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: constraints.maxWidth < 600 ? 1.15 : 1.35,
          ),
          itemCount: state.metrics.length,
          itemBuilder: (context, index) =>
              DashboardMetricCard(model: state.metrics[index]),
        );
      },
    );
  }
}
