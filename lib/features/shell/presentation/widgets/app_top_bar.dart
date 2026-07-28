/// Material 3 Production SaaS Top App Bar widget.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/core/theme/theme_provider.dart';
import 'package:ai_hustle_copilot/features/shell/application/services/ai_launcher_service.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/notification_menu.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/profile_menu.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/search_bar_widget.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/workspace_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// AppTopBar component featuring search, workspace, AI, theme toggle, and profile.
class AppTopBar extends ConsumerWidget implements PreferredSizeWidget {
  /// Creates an [AppTopBar].
  const AppTopBar({
    this.title,
    this.showDrawerButton = false,
    super.key,
  });

  /// Optional page title.
  final String? title;

  /// Whether to display mobile drawer hamburger trigger.
  final bool showDrawerButton;

  @override
  Size get preferredSize => const Size.fromHeight(64.0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    return AppBar(
      elevation: 0,
      scrolledUnderElevation: 2.0,
      backgroundColor: isDark
          ? AppColors.darkSurface.withValues(alpha: 0.9)
          : AppColors.surface.withValues(alpha: 0.9),
      leading: showDrawerButton
          ? IconButton(
              icon: const Icon(Icons.menu_rounded),
              onPressed: () => Scaffold.of(context).openDrawer(),
            )
          : null,
      title: Row(
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: AppSpacing.space16),
          ],
          if (!AppBreakpoints.isCompact(context)) ...[
            const WorkspaceSwitcher(),
            const SizedBox(width: AppSpacing.space16),
            const Expanded(child: SearchBarWidget()),
          ],
        ],
      ),
      actions: [
        // AI Copilot Action Button
        IconButton(
          tooltip: 'AI Copilot Assistant',
          icon: const Icon(
            Icons.auto_awesome_rounded,
            color: AppColors.primary,
          ),
          onPressed: () {
            ref.read(aiLauncherServiceProvider).launchCopilot(context);
          },
        ),

        // Theme Toggle Switch
        IconButton(
          tooltip: isDark ? 'Switch to Light Theme' : 'Switch to Dark Theme',
          icon: Icon(
            isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          ),
          onPressed: () {
            ref.read(themeModeProvider.notifier).toggleTheme();
          },
        ),

        // Notifications Bell Menu
        const NotificationMenu(),

        // Profile Avatar Menu
        const ProfileMenu(),

        const SizedBox(width: AppSpacing.space8),
      ],
    );
  }
}
