/// WorkspaceSwitcher dropdown selector component.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/application/providers/shell_providers.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/workspace.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Multi-tenant WorkspaceSwitcher dropdown selector widget.
class WorkspaceSwitcher extends ConsumerWidget {
  /// Creates a [WorkspaceSwitcher].
  const WorkspaceSwitcher({this.compact = false, super.key});

  /// Compact mode for collapsed sidebar / small top bar.
  final bool compact;

  static const List<Workspace> _sampleWorkspaces = [
    Workspace(
      id: 'ws_personal',
      name: 'Personal Workspace',
      planTier: 'Pro Member',
      isPersonal: true,
    ),
    Workspace(
      id: 'ws_acme',
      name: 'Acme Corp Studio',
      planTier: 'Enterprise',
      memberCount: 12,
    ),
    Workspace(
      id: 'ws_hustle',
      name: 'Hustle Labs',
      planTier: 'Pro Member',
      memberCount: 4,
    ),
  ];

  void _showWorkspaceModal(BuildContext context, WidgetRef ref) {
    AppBottomSheet.show<void>(
      context: context,
      title: 'Select Workspace',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ..._sampleWorkspaces.map(
            (ws) => ListTile(
              leading: AppAvatar(name: ws.name),
              title: Text(ws.name),
              subtitle: Text(ws.planTier),
              trailing: ref.read(activeWorkspaceProvider) == ws
                  ? const Icon(
                      Icons.check_circle_rounded,
                      color: AppColors.primary,
                    )
                  : null,
              onTap: () {
                ref.read(shellControllerProvider.notifier).selectWorkspace(ws);
                Navigator.of(context).pop();
              },
            ),
          ),
          const Divider(height: AppSpacing.space24),
          AppButton(
            text: 'Create New Workspace',
            icon: Icons.add_rounded,
            variant: AppButtonVariant.outlined,
            onPressed: () {
              Navigator.of(context).pop();
              AppSnackBar.showInfo(
                context,
                message: 'Create Workspace flow coming soon.',
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeWs = ref.watch(activeWorkspaceProvider);
    final isDark = context.isDarkMode;
    final theme = context.theme;

    if (compact) {
      return IconButton(
        tooltip: 'Switch Workspace (${activeWs.name})',
        icon: AppAvatar(name: activeWs.name, size: AppAvatarSize.sm),
        onPressed: () => _showWorkspaceModal(context, ref),
      );
    }

    return InkWell(
      borderRadius: AppRadius.borderMedium,
      onTap: () => _showWorkspaceModal(context, ref),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.space8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppAvatar(name: activeWs.name, size: AppAvatarSize.sm),
            const SizedBox(width: AppSpacing.space8),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    activeWs.name,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    activeWs.planTier,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isDark
                          ? AppColors.darkOnSurfaceVariant
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.space4),
            Icon(
              Icons.unfold_more_rounded,
              size: 18.0,
              color: isDark
                  ? AppColors.darkOnSurfaceVariant
                  : AppColors.onSurfaceVariant,
            ),
          ],
        ),
      ),
    );
  }
}
