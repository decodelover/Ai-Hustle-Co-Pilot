/// Compact launcher grid for implemented product workflows.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/core/theme/app_spacing.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/quick_action_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_surface.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Interactive quick-action grid section.
class QuickActionsGrid extends StatelessWidget {
  /// Creates a [QuickActionsGrid].
  const QuickActionsGrid({required this.actions, super.key});

  /// Injected actions sourced from the dashboard state.
  final List<QuickActionModel> actions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DashboardSectionHeader(
          title: 'Quick actions',
          subtitle: 'Start with the work that moves you forward.',
        ),
        const SizedBox(height: AppSpacing.space12),
        if (actions.isEmpty)
          const DashboardSurface(
            tone: DashboardSurfaceTone.subtle,
            child: Text('Your shortcuts will appear here as features become available.'),
          )
        else
          LayoutBuilder(
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
                  crossAxisSpacing: AppSpacing.space12,
                  mainAxisSpacing: AppSpacing.space12,
                  childAspectRatio: constraints.maxWidth < 600 ? 1.28 : 1.65,
                ),
                itemCount: actions.length,
                itemBuilder: (context, index) {
                  final action = actions[index];
                  return _QuickActionTile(action: action);
                },
              );
            },
          ),
      ],
    );
  }
}

class _QuickActionTile extends StatelessWidget {
  const _QuickActionTile({required this.action});

  final QuickActionModel action;

  @override
  Widget build(BuildContext context) {
    return DashboardSurface(
      tone: action.isFeatured
          ? DashboardSurfaceTone.subtle
          : DashboardSurfaceTone.standard,
      padding: const EdgeInsets.all(AppSpacing.space16),
      onTap: () {
        if (action.route.isNotEmpty) context.go(action.route);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.08),
                  borderRadius: AppRadius.borderMedium,
                ),
                child: Icon(action.icon, color: AppColors.primary, size: 19),
              ),
              if (action.badgeCount != null && action.badgeCount! > 0)
                CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.accentCoral,
                  child: Text(
                    '${action.badgeCount}',
                    style: const TextStyle(
                      color: AppColors.onPrimary,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
            ],
          ),
          Text(
            action.label,
            style: Theme.of(context).textTheme.titleSmall,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
