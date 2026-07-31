/// Searchable Command Palette dialog (Cmd+K / Ctrl+K).
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/application/services/ai_launcher_service.dart';
import 'package:ai_hustle_copilot/features/shell/domain/models/shell_navigation_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Command Palette modal allowing quick search across navigation and commands.
class CommandPaletteWidget extends ConsumerStatefulWidget {
  /// Creates a [CommandPaletteWidget].
  const CommandPaletteWidget({super.key});

  /// Opens the Command Palette modal dialog.
  static void show(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const CommandPaletteWidget(),
    );
  }

  @override
  ConsumerState<CommandPaletteWidget> createState() =>
      _CommandPaletteWidgetState();
}

class _CommandPaletteWidgetState extends ConsumerState<CommandPaletteWidget> {
  final _searchController = TextEditingController();
  String _query = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isDark = context.isDarkMode;

    final filteredNav = ShellNavigationConfig.items.where((item) {
      return item.title.toLowerCase().contains(_query.toLowerCase()) ||
          item.tooltip.toLowerCase().contains(_query.toLowerCase());
    }).toList();

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.space16,
        vertical: AppSpacing.space48,
      ),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 640.0, maxHeight: 520.0),
        child: Material(
          color: isDark ? AppColors.darkSurface : AppColors.surface,
          borderRadius: AppRadius.borderLarge,
          elevation: 8,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: AppRadius.borderLarge,
              border: Border.all(
                color: isDark
                    ? AppColors.darkOutlineVariant
                    : AppColors.outlineVariant,
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Search Input ─────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.space16),
                  child: TextField(
                    controller: _searchController,
                    autofocus: true,
                    onChanged: (val) => setState(() => _query = val),
                    decoration: InputDecoration(
                      hintText: 'Type a command or search...',
                      prefixIcon: const Icon(Icons.search_rounded),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const Divider(height: 1.0),

                // ── Results List ─────────────────────────────────────
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(AppSpacing.space8),
                    children: [
                      // AI Shortcut Section
                      ListTile(
                        leading: const Icon(
                          Icons.auto_awesome_rounded,
                          color: AppColors.primary,
                        ),
                        title: const Text('Launch AI Copilot Assistant'),
                        subtitle: const Text(
                          'Ask AI to generate proposals & code',
                        ),
                        trailing: const AppBadge(label: 'AI ACTION'),
                        onTap: () {
                          Navigator.of(context).pop();
                          ref
                              .read(aiLauncherServiceProvider)
                              .launchCopilot(context);
                        },
                      ),
                      const Divider(height: AppSpacing.space16),

                      // Navigation Items
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.space12,
                          vertical: AppSpacing.space4,
                        ),
                        child: Text(
                          'NAVIGATION & MODULES',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isDark
                                ? AppColors.darkOnSurfaceVariant
                                : AppColors.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      ...filteredNav.map(
                        (item) => ListTile(
                          leading: Icon(item.icon),
                          title: Text(item.title),
                          subtitle: Text(item.tooltip),
                          onTap: () {
                            ref
                                .read(shellControllerProvider.notifier)
                                .selectRoute(item.route);
                            Navigator.of(context).pop();
                            context.go(item.route);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
