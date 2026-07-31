/// Data-driven single-source navigation configuration registry.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/shell_navigation_item.dart';
import 'package:flutter/material.dart';

/// Single source of truth for all shell navigation items across surfaces.
abstract final class ShellNavigationConfig {
  /// All available navigation destinations.
  static const List<ShellNavigationItem> items = [
    ShellNavigationItem(
      id: 'dashboard',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard_rounded,
      title: 'Dashboard',
      tooltip: 'Overview dashboard & metrics',
      route: RoutePaths.dashboard,
      analyticsIdentifier: 'nav_dashboard',
      isPrimaryTab: true,
    ),
    ShellNavigationItem(
      id: 'ai_workspace',
      icon: Icons.psychology_outlined,
      selectedIcon: Icons.psychology_rounded,
      title: 'AI Workspace',
      tooltip: 'AI Copilot studio & generator',
      route: RoutePaths.aiStudio,
      analyticsIdentifier: 'nav_ai_workspace',
      isPrimaryTab: true,
    ),
    ShellNavigationItem(
      id: 'projects',
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder_rounded,
      title: 'Projects',
      tooltip: 'Active projects & opportunities',
      route: RoutePaths.discover,
      analyticsIdentifier: 'nav_projects',
      isPrimaryTab: true,
      isPinnedShortcut: true,
    ),
    ShellNavigationItem(
      id: 'automation',
      icon: Icons.bolt_outlined,
      selectedIcon: Icons.bolt_rounded,
      title: 'Automation',
      tooltip: 'Automated application pipelines',
      route: RoutePaths.applications,
      analyticsIdentifier: 'nav_automation',
      isPrimaryTab: true,
    ),
    ShellNavigationItem(
      id: 'documents',
      icon: Icons.description_outlined,
      selectedIcon: Icons.description_rounded,
      title: 'AI Documents',
      tooltip: 'AI Document Studio & Generation Engine',
      route: RoutePaths.documents,
      analyticsIdentifier: 'nav_documents',
      isPrimaryTab: true,
      isPinnedShortcut: true,
    ),
    ShellNavigationItem(
      id: 'profile',
      icon: Icons.person_outline_rounded,
      selectedIcon: Icons.person_rounded,
      title: 'Profile',
      tooltip: 'User profile & settings',
      route: RoutePaths.profile,
      analyticsIdentifier: 'nav_profile',
      isPrimaryTab: true,
    ),
  ];

  /// Resolves primary tab items for phone bottom navigation.
  static List<ShellNavigationItem> get primaryTabs =>
      items.where((item) => item.isPrimaryTab).toList();

  /// Resolves pinned shortcut items for desktop sidebar.
  static List<ShellNavigationItem> get pinnedShortcuts =>
      items.where((item) => item.isPinnedShortcut).toList();
}
