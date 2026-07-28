/// Focused derived Riverpod providers for shell properties.
library;

import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/workspace.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Active workspace provider.
final activeWorkspaceProvider = Provider<Workspace>((ref) {
  return ref.watch(shellControllerProvider.select((s) => s.activeWorkspace));
});

/// Desktop sidebar collapse state provider.
final sidebarCollapsedProvider = Provider<bool>((ref) {
  return ref.watch(shellControllerProvider.select((s) => s.sidebarCollapsed));
});

/// Tablet navigation rail expanded state provider.
final navRailExpandedProvider = Provider<bool>((ref) {
  return ref.watch(shellControllerProvider.select((s) => s.navRailExpanded));
});

/// Unread notifications count provider.
final unreadNotificationsCountProvider = Provider<int>((ref) {
  return ref.watch(
    shellControllerProvider.select((s) => s.unreadNotificationsCount),
  );
});

/// Command Palette open state provider.
final isCommandPaletteOpenProvider = Provider<bool>((ref) {
  return ref.watch(
    shellControllerProvider.select((s) => s.isCommandPaletteOpen),
  );
});
