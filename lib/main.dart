/// AI Hustle Co-Pilot — Application Entry Point.
///
/// Initializes all infrastructure services, wraps the widget tree
/// in Riverpod's [ProviderScope], and configures Material 3 theming
/// with GoRouter navigation.
///
/// ## Startup Sequence
/// 1. [AppInitializer.initialize] — Supabase, Hive, Logger
/// 2. [ProviderScope] — Riverpod dependency injection container
/// 3. [MaterialApp.router] — GoRouter + Material 3 theme
library;

import 'package:ai_hustle_copilot/core/config/app_config.dart';
import 'package:ai_hustle_copilot/core/init/app_initializer.dart';
import 'package:ai_hustle_copilot/core/router/app_router.dart';
import 'package:ai_hustle_copilot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Application entry point.
///
/// Ensures all initialization completes before the first frame
/// renders, then launches the Riverpod-wrapped widget tree.
void main() async {
  await AppInitializer.initialize();

  runApp(
    const ProviderScope(
      child: AiHustleCoPilotApp(),
    ),
  );
}

/// Root widget for the AI Hustle Co-Pilot application.
///
/// Configures the Material 3 design system, router, and
/// platform-adaptive behavior. This widget should remain
/// minimal — all configuration is delegated to dedicated
/// modules ([AppTheme], [routerProvider], [AppConfig]).
class AiHustleCoPilotApp extends ConsumerWidget {
  /// Creates the root application widget.
  const AiHustleCoPilotApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      // ── Identity ─────────────────────────────────────────────────
      title: AppConfig.appName,
      debugShowCheckedModeBanner: false,

      // ── Theming ──────────────────────────────────────────────────
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,

      // ── Routing ──────────────────────────────────────────────────
      routerConfig: router,
    );
  }
}
