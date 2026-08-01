/// Calm, five-destination phone navigation bar.
library;

import 'package:ai_hustle_copilot/core/theme/app_colors.dart';
import 'package:ai_hustle_copilot/core/theme/app_radius.dart';
import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/shell_navigation_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// AppBottomNavigation providing 5 primary destinations for phone viewports.
class AppBottomNavigation extends ConsumerWidget {
  /// Creates an [AppBottomNavigation].
  const AppBottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shellState = ref.watch(shellControllerProvider);
    final primaryTabs = ShellNavigationConfig.primaryTabs;

    final selectedIndex = primaryTabs.indexWhere(
      (item) => item.route == shellState.selectedRoute,
    );

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final selectedColor = isDark ? AppColors.darkPrimary : AppColors.primary;
    final unselectedColor = isDark
        ? AppColors.darkOnSurfaceVariant
        : AppColors.onSurfaceVariant;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.surface,
        border: Border(
          top: BorderSide(
            color: isDark
                ? AppColors.darkOutlineVariant
                : AppColors.outlineVariant,
          ),
        ),
      ),
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          height: 72,
          elevation: 0,
          backgroundColor: Colors.transparent,
          indicatorColor: selectedColor.withValues(alpha: 0.10),
          indicatorShape: const RoundedRectangleBorder(
            borderRadius: AppRadius.borderPill,
          ),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              size: selected ? 23 : 22,
              color: selected ? selectedColor : unselectedColor,
            );
          }),
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return theme.textTheme.labelSmall?.copyWith(
              color: selected ? selectedColor : unselectedColor,
              fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              height: 1.1,
              letterSpacing: 0,
            );
          }),
        ),
        child: NavigationBar(
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
          onDestinationSelected: (index) {
            final targetItem = primaryTabs[index];
            ref
                .read(shellControllerProvider.notifier)
                .selectRoute(targetItem.route);
            context.go(targetItem.route);
          },
          destinations: primaryTabs.map((item) {
            return NavigationDestination(
              icon: Icon(item.icon),
              selectedIcon: Icon(item.selectedIcon),
              label: _compactLabel(item.id),
              tooltip: item.tooltip,
            );
          }).toList(),
        ),
      ),
    );
  }

  String _compactLabel(String id) => switch (id) {
    'ai_workspace' => 'AI',
    'automation' => 'Automate',
    'documents' => 'Documents',
    _ => ShellNavigationConfig.items.firstWhere((item) => item.id == id).title,
  };
}
