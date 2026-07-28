/// User Profile Quick Menu dropdown/modal component.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/application/providers/auth_application_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// User Profile menu avatar widget exposing profile details, settings, and sign-out.
class ProfileMenu extends ConsumerWidget {
  /// Creates a [ProfileMenu].
  const ProfileMenu({super.key});

  void _showProfileModal(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    AppBottomSheet.show<void>(
      context: context,
      title: 'Account & Settings',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const AppAvatar(
                name: 'Alex Johnson',
                size: AppAvatarSize.lg,
              ),
              const SizedBox(width: AppSpacing.space16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alex Johnson',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'alex.johnson@example.com',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: AppSpacing.space4),
                    const AppBadge(
                      label: 'PRO MEMBER',
                      variant: AppBadgeVariant.success,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.space24),
          ListTile(
            leading: const Icon(Icons.person_outline_rounded),
            title: const Text('My Profile'),
            onTap: () {
              Navigator.of(context).pop();
              context.goNamed(RouteNames.profile);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings_outlined),
            title: const Text('Workspace Settings'),
            onTap: () {
              Navigator.of(context).pop();
              AppSnackBar.showInfo(
                context,
                message: 'Workspace Settings opened.',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.workspace_premium_outlined),
            title: const Text('Subscription & Billing'),
            onTap: () {
              Navigator.of(context).pop();
              AppSnackBar.showInfo(
                context,
                message: 'Subscription & Billing opened.',
              );
            },
          ),
          const Divider(height: AppSpacing.space24),
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Semantics(
      label: 'Open User Profile Menu',
      button: true,
      child: IconButton(
        icon: const AppAvatar(
          name: 'Alex Johnson',
          size: AppAvatarSize.sm,
        ),
        onPressed: () => _showProfileModal(context, ref),
      ),
    );
  }
}
