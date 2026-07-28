/// Application-wide constants for animation, pagination, and timing.
///
/// Centralizes magic numbers into named, documented constants
/// to ensure consistency and easy maintenance across all features.
library;

/// Global constants shared across all features.
///
/// For theme-related tokens (spacing, radii, elevation), see
/// [AppSpacing]. For asset paths, see [AssetPaths].
abstract final class AppConstants {
  // ── Animation Durations ──────────────────────────────────────────────

  /// Standard transition duration for page and widget animations.
  static const Duration defaultAnimationDuration = Duration(milliseconds: 300);

  /// Fast animation for micro-interactions (button presses, toggles).
  static const Duration fastAnimationDuration = Duration(milliseconds: 150);

  /// Slow animation for complex transitions (page reveals, modals).
  static const Duration slowAnimationDuration = Duration(milliseconds: 500);

  // ── Pagination ───────────────────────────────────────────────────────

  /// Default number of items fetched per page in paginated lists.
  static const int defaultPageSize = 20;

  // ── Networking ───────────────────────────────────────────────────────

  /// Connection timeout for HTTP requests.
  static const Duration connectionTimeout = Duration(seconds: 15);

  /// Receive timeout for HTTP responses.
  static const Duration receiveTimeout = Duration(seconds: 15);

  /// Send timeout for HTTP request bodies.
  static const Duration sendTimeout = Duration(seconds: 15);

  // ── Splash ───────────────────────────────────────────────────────────

  /// Minimum time the splash screen is displayed.
  static const Duration splashDuration = Duration(seconds: 2);
}
