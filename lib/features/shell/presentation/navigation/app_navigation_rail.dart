/// Expandable Tablet Navigation Rail widget.
library;

import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/shell_navigation_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// AppNavigationRail providing expandable vertical navigation for tablet viewports.
class AppNavigationRail extends ConsumerWidget {
  /// Creates an [AppNavigationRail].
  const AppNavigationRail({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final shellState = ref.watch(shellControllerProvider);
    const items = ShellNavigationConfig.items;

    final selectedIndex = items.indexWhere(
      (item) => item.route == shellState.selectedRoute,
    );

    return NavigationRail(
      extended: shellState.navRailExpanded,
      selectedIndex: selectedIndex >= 0 ? selectedIndex : 0,
      onDestinationSelected: (index) {
        final targetItem = items[index];
        ref
            .read(shellControllerProvider.notifier)
            .selectRoute(targetItem.route);
        context.go(targetItem.route);
      },
      leading: IconButton(
        icon: Icon(
          shellState.navRailExpanded
              ? Icons.menu_open_rounded
              : Icons.menu_rounded,
        ),
        onPressed: () {
          ref.read(shellControllerProvider.notifier).toggleNavRail();
        },
      ),
      destinations: items.map((item) {
        return NavigationRailDestination(
          icon: Icon(item.icon),
          selectedIcon: Icon(item.selectedIcon),
          label: Text(item.title),
        );
      }).toList(),
    );
  }
}
