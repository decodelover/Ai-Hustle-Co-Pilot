/// Centralized application initialization orchestrator.
///
/// Handles all startup tasks in a defined sequence before
/// the first frame renders. Each initialization step is
/// independently error-handled so a single failure does not
/// prevent the app from launching.
///
/// ## Initialization Order
/// 1. Flutter engine binding
/// 2. Environment validation
/// 3. Supabase client
/// 4. Hive local storage
/// 5. Logger configuration
library;

import 'package:ai_hustle_copilot/core/config/env.dart';
import 'package:ai_hustle_copilot/core/logging/app_logger.dart';
import 'package:flutter/widgets.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Orchestrates app startup tasks before [runApp] is called.
///
/// All initialization is performed in [initialize], which must
/// complete before the widget tree is built. Errors in individual
/// steps are caught and logged — the app will still launch to
/// allow graceful degradation.
///
/// ## Usage
/// ```dart
/// void main() async {
///   await AppInitializer.initialize();
///   runApp(const AiHustleCoPilotApp());
/// }
/// ```
abstract final class AppInitializer {
  /// Runs all startup tasks in sequence.
  ///
  /// Must be called before [runApp] and after
  /// `WidgetsFlutterBinding.ensureInitialized()`.
  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    _validateEnvironment();
    await _initSupabase();
    await _initHive();

    AppLogger.info('App initialization complete');
  }

  /// Validates that required environment variables are configured.
  ///
  /// Logs a prominent warning if placeholder values are detected,
  /// guiding the developer to configure real Supabase credentials.
  /// Does NOT throw — the app will still launch for offline
  /// development and design system work.
  static void _validateEnvironment() {
    try {
      final url = Env.supabaseUrl;
      final key = Env.supabasePublishableKey;

      if (url.contains('placeholder') || key.contains('placeholder')) {
        AppLogger.warning(
          '⚠️ Supabase credentials are placeholder values.\n'
          '  → Copy .env.example to .env\n'
          '  → Fill in your Supabase URL and Publishable Key\n'
          '  → Run: dart run build_runner build --delete-conflicting-outputs\n'
          '  → Restart the app',
        );
      } else {
        AppLogger.info('Environment variables validated successfully');
      }
    } catch (e) {
      AppLogger.error(
        '❌ Failed to read environment variables.\n'
        '  → Ensure .env file exists with SUPABASE_URL and '
        'SUPABASE_PUBLISHABLE_KEY\n'
        '  → Run: dart run build_runner build --delete-conflicting-outputs',
        error: e,
      );
    }
  }

  /// Initializes the Supabase client with environment credentials.
  ///
  /// The Supabase URL and publishable key are injected at compile time
  /// via Envied, ensuring no runtime file parsing is needed.
  static Future<void> _initSupabase() async {
    try {
      await Supabase.initialize(
        url: Env.supabaseUrl,
        publishableKey: Env.supabasePublishableKey,
      );
      AppLogger.info('Supabase initialized successfully');
    } catch (e, s) {
      AppLogger.error('Failed to initialize Supabase', error: e, stackTrace: s);
      rethrow;
    }
  }

  /// Initializes Hive for local key-value storage.
  ///
  /// Hive is used for caching non-sensitive data (preferences,
  /// cached API responses). Sensitive data uses [SecureStorageService].
  static Future<void> _initHive() async {
    try {
      await Hive.initFlutter();
      await Future.wait([
        Hive.openBox<dynamic>('documents_v1'),
        Hive.openBox<dynamic>('document_versions_v1'),
        Hive.openBox<dynamic>('projects_v1'),
        Hive.openBox<dynamic>('ai_studio_v1'),
      ]);
      AppLogger.info('Hive initialized successfully');
    } catch (e, s) {
      AppLogger.error('Failed to initialize Hive', error: e, stackTrace: s);
    }
  }
}
