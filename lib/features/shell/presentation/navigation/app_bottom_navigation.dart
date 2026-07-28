/// Phone Bottom Navigation bar widget with center AI action button slot.
library;

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

    return NavigationBar(
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
          label: item.title,
          tooltip: item.tooltip,
        );
      }).toList(),
    );
  }
}
