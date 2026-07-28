/// Remote data source providing dashboard metrics, projects, activity, and AI insights.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/activity_feed_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/insight_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/quick_action_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/recent_project_model.dart';
import 'package:flutter/material.dart';

/// Data source interface for dashboard network APIs.
abstract class DashboardRemoteDataSource {
  /// Fetches raw initial dashboard state dataset.
  Future<DashboardState> fetchDashboardData();
}

/// Mock/Production-ready implementation of [DashboardRemoteDataSource].
class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  @override
  Future<DashboardState> fetchDashboardData() async {
    // Simulate brief network latency for authentic UI state verification.
    await Future<void>.delayed(const Duration(milliseconds: 600));

    final metrics = <DashboardMetricCardModel>[
      const DashboardMetricCardModel(
        id: 'active_projects',
        title: 'Active Projects',
        value: '18',
        trendPercentage: 12.5,
        isPositiveTrend: true,
        icon: Icons.folder_open_outlined,
        subtitle: '+2 this week',
      ),
      const DashboardMetricCardModel(
        id: 'ai_generations',
        title: 'AI Generations',
        value: '1,420',
        trendPercentage: 24.8,
        isPositiveTrend: true,
        icon: Icons.auto_awesome_outlined,
        subtitle: '180 prompts today',
      ),
      const DashboardMetricCardModel(
        id: 'documents_created',
        title: 'Documents',
        value: '42',
        trendPercentage: 8.4,
        isPositiveTrend: true,
        icon: Icons.description_outlined,
        subtitle: '5 pending review',
      ),
      const DashboardMetricCardModel(
        id: 'automations_run',
        title: 'Automations',
        value: '89',
        trendPercentage: 5.2,
        isPositiveTrend: true,
        icon: Icons.bolt_outlined,
        subtitle: '99.8% uptime',
      ),
      const DashboardMetricCardModel(
        id: 'storage_used',
        title: 'Storage Used',
        value: '3.4 GB',
        trendPercentage: -2.1,
        isPositiveTrend: false,
        icon: Icons.cloud_queue_outlined,
        subtitle: '68% of 5 GB plan',
      ),
      const DashboardMetricCardModel(
        id: 'ai_credits',
        title: 'AI Credits',
        value: '840',
        trendPercentage: 0.0,
        isPositiveTrend: true,
        icon: Icons.token_outlined,
        subtitle: 'Resets in 12 days',
      ),
    ];

    final quickActions = <QuickActionModel>[
      const QuickActionModel(
        id: 'new_project',
        label: 'New Project',
        icon: Icons.add_circle_outline,
        route: RouteNames.dashboard,
        isFeatured: true,
        analyticsEvent: 'dashboard_quick_action_new_project',
      ),
      const QuickActionModel(
        id: 'ai_workspace',
        label: 'AI Studio',
        icon: Icons.auto_awesome_outlined,
        route: RouteNames.aiStudio,
        isFeatured: true,
        analyticsEvent: 'dashboard_quick_action_ai_studio',
      ),
      const QuickActionModel(
        id: 'generate_doc',
        label: 'New Doc',
        icon: Icons.note_add_outlined,
        route: RouteNames.documents,
        analyticsEvent: 'dashboard_quick_action_generate_doc',
      ),
      const QuickActionModel(
        id: 'ai_chat',
        label: 'AI Chat',
        icon: Icons.chat_bubble_outline,
        route: RouteNames.aiStudio,
        analyticsEvent: 'dashboard_quick_action_ai_chat',
      ),
      const QuickActionModel(
        id: 'automation',
        label: 'Automation',
        icon: Icons.bolt_outlined,
        route: RouteNames.automation,
        analyticsEvent: 'dashboard_quick_action_automation',
      ),
      const QuickActionModel(
        id: 'marketplace',
        label: 'Marketplace',
        icon: Icons.storefront_outlined,
        route: RouteNames.marketplace,
        analyticsEvent: 'dashboard_quick_action_marketplace',
      ),
    ];

    final activities = <ActivityFeedModel>[
      ActivityFeedModel(
        id: 'act_1',
        title: 'AI Proposal Generated',
        description: 'Drafted response for Apex Tech redesign RFP',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        category: ActivityCategory.aiAction,
        icon: Icons.auto_awesome_outlined,
      ),
      ActivityFeedModel(
        id: 'act_2',
        title: 'Project Milestone Achieved',
        description: 'Completed UI kit handoff for Starlight App',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        category: ActivityCategory.project,
        icon: Icons.check_circle_outline,
      ),
      ActivityFeedModel(
        id: 'act_3',
        title: 'Automation Executed',
        description: 'Synced 14 client invoices to accounting ledger',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        category: ActivityCategory.automation,
        icon: Icons.bolt_outlined,
      ),
      ActivityFeedModel(
        id: 'act_4',
        title: 'Contract Exported',
        description: 'Downloaded PDF NDA for CloudScale Corp',
        timestamp: DateTime.now().subtract(const Duration(hours: 18)),
        category: ActivityCategory.document,
        icon: Icons.picture_as_pdf_outlined,
      ),
    ];

    final projects = <RecentProjectModel>[
      RecentProjectModel(
        id: 'proj_1',
        title: 'Linear Design System Integration',
        clientName: 'Acme SaaS Corp',
        progress: 0.85,
        status: ProjectStatus.inProgress,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 1)),
        tags: const ['Flutter', 'Design System', 'M3'],
        aiUsageScore: 96,
      ),
      RecentProjectModel(
        id: 'proj_2',
        title: 'Supabase Realtime Sync Engine',
        clientName: 'Apex Logistics',
        progress: 0.60,
        status: ProjectStatus.review,
        lastUpdated: DateTime.now().subtract(const Duration(hours: 4)),
        tags: const ['Supabase', 'Dart', 'Riverpod'],
        aiUsageScore: 91,
      ),
      RecentProjectModel(
        id: 'proj_3',
        title: 'AI Copywriting Assistant Module',
        clientName: 'Internal Product',
        progress: 0.40,
        status: ProjectStatus.inProgress,
        lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
        tags: const ['OpenAI', 'Copilot', 'AI'],
        aiUsageScore: 98,
      ),
    ];

    final insights = <InsightCardModel>[
      const InsightCardModel(
        id: 'ins_1',
        title: 'Optimize AI Proposal Generation',
        description:
            'You have 4 un-responded client RFPs. Enable auto-drafting to boost response speed by 35%.',
        type: InsightType.recommendation,
        priority: InsightPriority.high,
        actionLabel: 'Enable Auto-Draft',
        impactScore: 35,
      ),
      const InsightCardModel(
        id: 'ins_2',
        title: 'Automate Invoice Reminders',
        description:
            'Connecting your billing automation workflow will save approximately 4.5 hours per week.',
        type: InsightType.automationSuggestion,
        priority: InsightPriority.medium,
        actionLabel: 'Setup Workflow',
        impactScore: 28,
      ),
    ];

    return DashboardState(
      metrics: metrics,
      quickActions: quickActions,
      activities: activities,
      projects: projects,
      insights: insights,
      lastUpdated: DateTime.now(),
    );
  }
}
