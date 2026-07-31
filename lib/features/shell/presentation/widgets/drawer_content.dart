/// Enterprise Navigation Drawer content component.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/shell_navigation_config.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/workspace_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// DrawerContent widget displaying Workspace, Navigation, Pinned Items, Subscription, and Settings.
class DrawerContent extends ConsumerWidget {
  /// Creates a [DrawerContent].
  const DrawerContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isDark = context.isDarkMode;
    final shellState = ref.watch(shellControllerProvider);

    return SafeArea(
      child: Column(
        children: [
          // ── Header Workspace Switcher ──────────────────────────────
          Padding(
            padding: const EdgeInsets.all(AppSpacing.space16),
            child: Row(
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    borderRadius: AppRadius.borderMedium,
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        isDark ? AppColors.darkPrimary : AppColors.primary,
                        isDark ? AppColors.darkSecondary : AppColors.secondary,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.onPrimary,
                    size: 24.0,
                  ),
                ),
                const SizedBox(width: AppSpacing.space12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'AI Hustle',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Co-Pilot Enterprise',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark
                              ? AppColors.darkPrimary
                              : AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1.0),

          // ── Workspace Selection ────────────────────────────────────
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSpacing.space8),
            child: WorkspaceSwitcher(),
          ),
          const Divider(height: 1.0),

          // ── Navigation List ────────────────────────────────────────
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.space8),
              children: [
                ...ShellNavigationConfig.items.map((item) {
                  final isSelected = shellState.selectedRoute == item.route;
                  return ListTile(
                    leading: Icon(
                      isSelected ? item.selectedIcon : item.icon,
                      color: isSelected
                          ? (isDark ? AppColors.darkPrimary : AppColors.primary)
                          : null,
                    ),
                    title: Text(
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
                      Navigator.of(context).pop();
                      context.go(item.route);
                    },
                  );
                }),
                const Divider(height: AppSpacing.space16),

                // Subscription Badge Card
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppBadge(
                          label: 'PRO MEMBER',
                          variant: AppBadgeVariant.success,
                        ),
                        const SizedBox(height: AppSpacing.space8),
                        Text(
                          'Cloud Storage',
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        LinearProgressIndicator(
                          value: shellState.storageUsagePercentage,
                          borderRadius: AppRadius.borderPill,
                          backgroundColor: isDark
                              ? AppColors.darkOutlineVariant
                              : AppColors.outlineVariant,
                        ),
                        const SizedBox(height: AppSpacing.space4),
                        Text(
                          '4.2 GB of 10 GB used',
                          style: theme.textTheme.labelSmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ── Footer Sign Out ────────────────────────────────────────
          const Divider(height: 1.0),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: AppColors.danger),
            title: const Text(
              'Sign Out',
              style: TextStyle(color: AppColors.danger),
            ),
            onTap: () {
              Navigator.of(context).pop();
              ref.read(signOutControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
    );
  }
}
