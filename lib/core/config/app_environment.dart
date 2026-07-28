/// Application execution environment options.
///
/// Distinguishes runtime behavior, base URLs, feature flags,
/// and log levels across Development, Staging, and Production environments.
library;

/// Represents the active deployment environment.
enum AppEnvironment {
  /// Local development environment with verbose logging and mock options.
  dev,

  /// Staging environment mimicking production for QA and integration testing.
  staging,

  /// Live production environment with strict security and error reporting.
  prod;

  /// Returns `true` if this environment is [dev].
  bool get isDev => this == AppEnvironment.dev;

  /// Returns `true` if this environment is [staging].
  bool get isStaging => this == AppEnvironment.staging;

  /// Returns `true` if this environment is [prod].
  bool get isProd => this == AppEnvironment.prod;
}
