/// Premium AI command center for core product workflows.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/quick_action_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Interactive launcher that combines available actions with core AI tools.
class QuickActionsGrid extends StatelessWidget {
  /// Creates a [QuickActionsGrid].
  const QuickActionsGrid({required this.actions, super.key});

  /// Injected actions sourced from dashboard state.
  final List<QuickActionModel> actions;

  List<_CommandAction> get _commandActions {
    String routeFor(String id, String fallback) {
      for (final action in actions) {
        if (action.id == id) return action.route;
      }
      return fallback;
    }

    return [
      _CommandAction(
        label: 'New AI Chat',
        description: 'Start with a blank canvas',
        icon: CupertinoIcons.chat_bubble_2,
        route: routeFor('ai_workspace', RoutePaths.aiStudio),
        featured: true,
      ),
      _CommandAction(
        label: 'New Project',
        description: 'Create a focused workspace',
        icon: CupertinoIcons.folder_badge_plus,
        route: routeFor('projects', RoutePaths.projects),
      ),
      _CommandAction(
        label: 'AI Workspace',
        description: 'Draft and refine with AI',
        icon: CupertinoIcons.sparkles,
        route: routeFor('ai_workspace', RoutePaths.aiStudio),
        featured: true,
      ),
      _CommandAction(
        label: 'AI Documents',
        description: 'Write polished deliverables',
        icon: CupertinoIcons.doc_text,
        route: routeFor('create_document', RoutePaths.documents),
      ),
      const _CommandAction(
        label: 'AI Automation',
        description: 'Orchestrate repeatable work',
        icon: CupertinoIcons.wand_stars,
        route: RoutePaths.automation,
      ),
      const _CommandAction(
        label: 'Marketplace',
        description: 'Discover new capabilities',
        icon: CupertinoIcons.square_grid_2x2,
        route: RoutePaths.marketplace,
      ),
      const _CommandAction(
        label: 'Analytics',
        description: 'Understand your momentum',
        icon: CupertinoIcons.chart_bar_alt_fill,
        route: RoutePaths.dashboard,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final items = _commandActions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DashboardSectionHeader(
          eyebrow: 'Quick actions',
          title: 'AI Command Center',
          subtitle: 'Everything you need to move from idea to outcome.',
        ),
        const SizedBox(height: AppSpacing.space16),
        LayoutBuilder(
          builder: (context, constraints) {
            final columns = constraints.maxWidth < 600
                ? 2
                : constraints.maxWidth < 960
                ? 3
                : constraints.maxWidth < 1440
                ? 4
                : 7;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: columns,
                crossAxisSpacing: AppSpacing.space12,
                mainAxisSpacing: AppSpacing.space12,
                childAspectRatio: constraints.maxWidth < 600 ? 0.92 : 1.08,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) =>
                  _CommandTile(action: items[index]),
            );
          },
        ),
      ],
    );
  }
}

class _CommandTile extends StatelessWidget {
  const _CommandTile({required this.action});

  final _CommandAction action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DashboardSurface(
      semanticLabel: '${action.label}. ${action.description}',
      tone: action.featured
          ? DashboardSurfaceTone.subtle
          : DashboardSurfaceTone.standard,
      padding: const EdgeInsets.all(AppSpacing.space16),
      onTap: () => context.go(action.route),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  gradient: action.featured
                      ? const LinearGradient(
                          colors: [AppColors.primary, AppColors.secondary],
                        )
                      : null,
                  color: action.featured
                      ? null
                      : AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: AppRadius.borderMedium,
                ),
                child: Icon(
                  action.icon,
                  color: action.featured
                      ? AppColors.onPrimary
                      : AppColors.primary,
                  size: 20,
                ),
              ),
              const Spacer(),
              Icon(
                CupertinoIcons.arrow_up_right,
                size: 15,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ],
          ),
          const Spacer(),
          Text(
            action.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.space4),
          Text(
            action.description,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _CommandAction {
  const _CommandAction({
    required this.label,
    required this.description,
    required this.icon,
    required this.route,
    this.featured = false,
  });

  final String label;
  final String description;
  final IconData icon;
  final String route;
  final bool featured;
}
