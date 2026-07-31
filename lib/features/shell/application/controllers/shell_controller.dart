/// Centralized ShellController and stateNotifier for AI Hustle Co-Pilot.
library;

import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Immutable state container for the enterprise shell UI.
@immutable
class ShellState {
  /// Creates a [ShellState].
  const ShellState({
    required this.activeWorkspace,
    this.selectedRoute = RoutePaths.dashboard,
    this.sidebarCollapsed = false,
    this.navRailExpanded = false,
    this.unreadNotificationsCount = 3,
    this.isCommandPaletteOpen = false,
    this.isSearchExpanded = false,
    this.storageUsagePercentage = 0.42,
  });

  /// Active workspace.
  final Workspace activeWorkspace;

  /// Currently selected route path.
  final String selectedRoute;

  /// Sidebar collapsed boolean state.
  final bool sidebarCollapsed;

  /// Navigation rail expanded boolean state.
  final bool navRailExpanded;

  /// Count of unread notifications.
  final int unreadNotificationsCount;

  /// Command palette visibility state.
  final bool isCommandPaletteOpen;

  /// Top app bar search expanded state.
  final bool isSearchExpanded;

  /// Workspace cloud storage usage meter (0.0 to 1.0).
  final double storageUsagePercentage;

  /// Copies state modifying requested properties.
  ShellState copyWith({
    Workspace? activeWorkspace,
    String? selectedRoute,
    bool? sidebarCollapsed,
    bool? navRailExpanded,
    int? unreadNotificationsCount,
    bool? isCommandPaletteOpen,
    bool? isSearchExpanded,
    double? storageUsagePercentage,
  }) {
    return ShellState(
      activeWorkspace: activeWorkspace ?? this.activeWorkspace,
      selectedRoute: selectedRoute ?? this.selectedRoute,
      sidebarCollapsed: sidebarCollapsed ?? this.sidebarCollapsed,
      navRailExpanded: navRailExpanded ?? this.navRailExpanded,
      unreadNotificationsCount:
          unreadNotificationsCount ?? this.unreadNotificationsCount,
      isCommandPaletteOpen: isCommandPaletteOpen ?? this.isCommandPaletteOpen,
      isSearchExpanded: isSearchExpanded ?? this.isSearchExpanded,
      storageUsagePercentage:
          storageUsagePercentage ?? this.storageUsagePercentage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShellState &&
          runtimeType == other.runtimeType &&
          activeWorkspace == other.activeWorkspace &&
          selectedRoute == other.selectedRoute &&
          sidebarCollapsed == other.sidebarCollapsed &&
          navRailExpanded == other.navRailExpanded &&
          unreadNotificationsCount == other.unreadNotificationsCount &&
          isCommandPaletteOpen == other.isCommandPaletteOpen &&
          isSearchExpanded == other.isSearchExpanded &&
          storageUsagePercentage == other.storageUsagePercentage;

  @override
  int get hashCode => Object.hash(
    activeWorkspace,
    selectedRoute,
    sidebarCollapsed,
    navRailExpanded,
    unreadNotificationsCount,
    isCommandPaletteOpen,
    isSearchExpanded,
    storageUsagePercentage,
  );
}

/// Riverpod Provider for [ShellController].
final shellControllerProvider = NotifierProvider<ShellController, ShellState>(
  ShellController.new,
);

/// Centralized controller managing shell UI state and user interactions.
class ShellController extends Notifier<ShellState> {
  @override
  ShellState build() {
    return const ShellState(
      activeWorkspace: Workspace(
        id: 'ws_personal',
        name: 'Personal Workspace',
        planTier: 'Pro Member',
        isPersonal: true,
      ),
    );
  }

  /// Toggles desktop sidebar width collapse state.
  void toggleSidebar() {
    state = state.copyWith(sidebarCollapsed: !state.sidebarCollapsed);
  }

  /// Toggles tablet navigation rail expanded state.
  void toggleNavRail() {
    state = state.copyWith(navRailExpanded: !state.navRailExpanded);
  }

  /// Sets the currently active workspace.
  void selectWorkspace(Workspace workspace) {
    state = state.copyWith(activeWorkspace: workspace);
  }

  /// Sets the selected route path.
  void selectRoute(String route) {
    state = state.copyWith(selectedRoute: route);
  }

  /// Opens the Command Palette modal.
  void openCommandPalette() {
    state = state.copyWith(isCommandPaletteOpen: true);
  }

  /// Closes the Command Palette modal.
  void closeCommandPalette() {
    state = state.copyWith(isCommandPaletteOpen: false);
  }

  /// Toggles global search expanded state.
  void toggleSearchExpanded() {
    state = state.copyWith(isSearchExpanded: !state.isSearchExpanded);
  }
}
