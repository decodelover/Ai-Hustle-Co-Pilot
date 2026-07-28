/// Notification center bell badge and bottom sheet widget.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/shell/application/providers/shell_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Notification icon bell displaying active unread notification badges.
class NotificationMenu extends ConsumerWidget {
  /// Creates a [NotificationMenu].
  const NotificationMenu({super.key});

  void _showNotificationSheet(BuildContext context) {
    AppBottomSheet.show<void>(
      context: context,
      title: 'Notifications',
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.auto_awesome_rounded, color: AppColors.primary),
            title: Text('AI Proposal Generated'),
            subtitle: Text('Your Upwork proposal for Flutter Architect is ready.'),
          ),
          ListTile(
            leading: Icon(Icons.check_circle_outline_rounded, color: AppColors.success),
            title: Text('Client Message Received'),
            subtitle: Text('Sarah from Acme Corp accepted your offer.'),
          ),
          ListTile(
            leading: Icon(Icons.cloud_done_outlined, color: AppColors.secondary),
            title: Text('Workspace Backup Complete'),
            subtitle: Text('All 42 project files synced to cloud persistence.'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(unreadNotificationsCountProvider);

    return Semantics(
      label: 'Notifications ($count unread)',
      button: true,
      child: IconButton(
        icon: Badge(
          isLabelVisible: count > 0,
          label: Text(count.toString()),
          child: const Icon(Icons.notifications_outlined),
        ),
        onPressed: () => _showNotificationSheet(context),
      ),
    );
  }
}
