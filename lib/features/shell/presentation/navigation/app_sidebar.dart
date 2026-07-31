/// Permanent Enterprise Desktop Sidebar widget with width collapse animation.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/shell_navigation_config.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/workspace_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// AppSidebar offering a permanent, collapsible desktop sidebar navigation layout.
class AppSidebar extends ConsumerWidget {
  /// Creates an [AppSidebar].
  const AppSidebar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isDark = context.isDarkMode;
    final shellState = ref.watch(shellControllerProvider);
    final isCollapsed = shellState.sidebarCollapsed;

    return AnimatedContainer(
      duration: AppMotion.medium,
      curve: AppMotion.standardCurve,
      width: isCollapsed ? 80.0 : 280.0,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        border: Border(
          right: BorderSide(
            color: isDark
                ? AppColors.darkOutlineVariant
                : AppColors.outlineVariant,
          ),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          children: [
            // ── Brand Header & Collapse Toggle ─────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space16),
              child: Row(
                children: [
                  Container(
                    width: 36.0,
                    height: 36.0,
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.borderMedium,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          isDark ? AppColors.darkPrimary : AppColors.primary,
                          isDark
                              ? AppColors.darkSecondary
                              : AppColors.secondary,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.auto_awesome_rounded,
                      color: AppColors.onPrimary,
                      size: 20.0,
                    ),
                  ),
                  if (!isCollapsed) ...[
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: Text(
                        'AI Hustle',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                  IconButton(
                    tooltip: isCollapsed
                        ? 'Expand Sidebar'
                        : 'Collapse Sidebar',
                    icon: Icon(
                      isCollapsed
                          ? Icons.chevron_right_rounded
                          : Icons.chevron_left_rounded,
                    ),
                    onPressed: () {
                      ref
                          .read(shellControllerProvider.notifier)
                          .toggleSidebar();
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1.0),

            // ── Workspace Switcher ────────────────────────────────────
            WorkspaceSwitcher(compact: isCollapsed),
            const Divider(height: 1.0),

            // ── Main Navigation List ──────────────────────────────────
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSpacing.space8,
                ),
                children: [
                  ...ShellNavigationConfig.items.map((item) {
                    final isSelected = shellState.selectedRoute == item.route;
                    return Tooltip(
                      message: isCollapsed ? item.title : '',
                      child: ListTile(
                        leading: Icon(
                          isSelected ? item.selectedIcon : item.icon,
                          color: isSelected
                              ? (isDark
                                    ? AppColors.darkPrimary
                                    : AppColors.primary)
                              : null,
                        ),
                        title: isCollapsed
                            ? null
                            : Text(
                                item.title,
                                style: TextStyle(
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected
                                      ? (isDark
                                            ? AppColors.darkPrimary
                                            : AppColors.primary)
                                      : null,
                                ),
                              ),
                        selected: isSelected,
                        onTap: () {
                          ref
                              .read(shellControllerProvider.notifier)
                              .selectRoute(item.route);
                          context.go(item.route);
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

            // ── Storage Usage Progress Meter ──────────────────────────
            if (!isCollapsed)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.space16),
                child: AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cloud Storage',
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('42%', style: theme.textTheme.labelSmall),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.space8),
                      LinearProgressIndicator(
                        value: shellState.storageUsagePercentage,
                        borderRadius: AppRadius.borderPill,
                        backgroundColor: isDark
                            ? AppColors.darkOutlineVariant
                            : AppColors.outlineVariant,
                      ),
                    ],
                  ),
                ),
              ),

            const Divider(height: 1.0),

            // ── Profile Footer ────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.all(AppSpacing.space8),
              child: Row(
                children: [
                  const AppAvatar(name: 'Alex Johnson', size: AppAvatarSize.sm),
                  if (!isCollapsed) ...[
                    const SizedBox(width: AppSpacing.space12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Alex Johnson',
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Pro Member',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: isDark
                                  ? AppColors.darkPrimary
                                  : AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
