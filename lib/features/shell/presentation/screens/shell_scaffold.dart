/// GoRouter ShellRoute container delegating layout rendering to [ShellScreen].
library;

import 'package:ai_hustle_copilot/features/shell/presentation/screens/shell_screen.dart';
import 'package:flutter/material.dart';

/// ShellScaffold wrapping active tab's widget tree in adaptive [ShellScreen].
class ShellScaffold extends StatelessWidget {
  /// Creates a [ShellScaffold].
  const ShellScaffold({
    required this.child,
    super.key,
  });

  /// Active tab content provided by GoRouter.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShellScreen(child: child);
  }
}
