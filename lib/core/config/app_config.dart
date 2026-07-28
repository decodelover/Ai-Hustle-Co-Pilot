/// Centralized application configuration constants.
///
/// Contains app-level metadata and configuration values that
/// are shared across the entire application.
library;

/// Application-wide configuration constants.
///
/// These values define the app's identity and behavior across
/// all features. Environment-specific values (API URLs, keys)
/// belong in [Env], not here.
abstract final class AppConfig {
  /// The display name shown in the app bar and about screens.
  static const String appName = 'AI Hustle Co-Pilot';

  /// The package identifier used by platform integrations.
  static const String packageName = 'com.aihustleco.copilot';

  /// Contact email for support and feedback.
  static const String supportEmail = 'support@aihustleco.com';

  /// The current application version displayed in settings.
  static const String appVersion = '1.0.0';

  /// The current build number for crash reporting.
  static const int buildNumber = 1;
}
