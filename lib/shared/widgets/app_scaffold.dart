/// Main application scaffold with bottom navigation.
///
/// Wraps the GoRouter [ShellRoute] child in a [Scaffold] with
/// a Material 3 [NavigationBar]. Handles tab selection by
/// navigating to the corresponding route path.
///
/// This widget is the root container for all authenticated,
/// tabbed screens (Dashboard, Discover, AI Studio, Applications,
/// Profile).
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Shell scaffold providing bottom navigation for main app tabs.
///
/// ## Architecture
/// This widget is used by [ShellRoute.builder] in the router
/// configuration. The [child] parameter is the currently active
/// tab's widget tree, managed by GoRouter.
///
/// ## Tab Index Resolution
/// The active tab index is derived from the current route location
/// via [_calculateSelectedIndex], ensuring the navigation bar
/// stays in sync with deep links and programmatic navigation.
class AppScaffold extends StatelessWidget {
  /// Creates the main app scaffold.
  ///
  /// [child] is the active tab's content, provided by GoRouter's
  /// [ShellRoute.builder].
  const AppScaffold({required this.child, super.key});

  /// The currently active tab's widget subtree.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (index) =>
            _onDestinationSelected(context, index),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon: Icon(Icons.dashboard_rounded),
            label: 'Dashboard',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore_outlined),
            selectedIcon: Icon(Icons.explore_rounded),
            label: 'Discover',
          ),
          NavigationDestination(
            icon: Icon(Icons.auto_awesome_outlined),
            selectedIcon: Icon(Icons.auto_awesome_rounded),
            label: 'AI Studio',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_outline_rounded),
            selectedIcon: Icon(Icons.work_rounded),
            label: 'Applications',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  /// Resolves the current route location to a tab index.
  ///
  /// Falls back to index 0 (Dashboard) for unrecognized paths.
  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;

    if (location.startsWith(RoutePaths.discover)) return 1;
    if (location.startsWith(RoutePaths.aiStudio)) return 2;
    if (location.startsWith(RoutePaths.applications)) return 3;
    if (location.startsWith(RoutePaths.profile)) return 4;

    return 0; // Dashboard
  }

  /// Navigates to the route corresponding to the tapped tab.
  void _onDestinationSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.goNamed(RouteNames.dashboard);
      case 1:
        context.goNamed(RouteNames.discover);
      case 2:
        context.goNamed(RouteNames.aiStudio);
      case 3:
        context.goNamed(RouteNames.applications);
      case 4:
        context.goNamed(RouteNames.profile);
    }
  }
}
