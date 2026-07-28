/// Master adaptive shell container view supporting Phone, Tablet, Desktop, and UltraWide layout breakpoints.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/shell/application/controllers/shell_controller.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/navigation/app_bottom_navigation.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/navigation/app_navigation_rail.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/navigation/app_sidebar.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/ai_floating_button.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/app_top_bar.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/command_palette_widget.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/widgets/drawer_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// ShellScreen wrapping active child route subtree in adaptive navigation layout with Cmd+K listener.
class ShellScreen extends ConsumerWidget {
  /// Creates a [ShellScreen].
  const ShellScreen({
    required this.child,
    super.key,
  });

  /// The active child route subtree managed by GoRouter.
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final width = MediaQuery.sizeOf(context).width;
    final isCompact = AppBreakpoints.isCompactWidth(width);
    final isMediumOrExpanded =
        AppBreakpoints.isMediumWidth(width) || AppBreakpoints.isExpandedWidth(width);
    final isDesktop = AppBreakpoints.isDesktopWidth(width);

    return CallbackShortcuts(
      bindings: <ShortcutActivator, VoidCallback>{
        const SingleActivator(LogicalKeyboardKey.keyK, meta: true): () {
          ref.read(shellControllerProvider.notifier).openCommandPalette();
          CommandPaletteWidget.show(context);
        },
        const SingleActivator(LogicalKeyboardKey.keyK, control: true): () {
          ref.read(shellControllerProvider.notifier).openCommandPalette();
          CommandPaletteWidget.show(context);
        },
      },
      child: Focus(
        autofocus: true,
        child: Scaffold(
          appBar: AppTopBar(
            showDrawerButton: isCompact,
          ),
          drawer: isCompact
              ? const Drawer(
                  child: DrawerContent(),
                )
              : null,
          body: Row(
            children: [
              if (isDesktop) const AppSidebar(),
              if (isMediumOrExpanded) const AppNavigationRail(),
              Expanded(
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: AppBreakpoints.ultraWide,
                    ),
                    child: AnimatedPage(child: child),
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar:
              isCompact ? const AppBottomNavigation() : null,
          floatingActionButton:
              isCompact ? const AiFloatingButton() : null,
          floatingActionButtonLocation: isCompact
              ? FloatingActionButtonLocation.centerDocked
              : null,
        ),
      ),
    );
  }
}
