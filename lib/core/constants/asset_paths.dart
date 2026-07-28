/// Typed asset path constants for images, icons, and animations.
///
/// Centralizes all asset references so paths are never hardcoded
/// in widget code. Compile-time errors catch missing assets early.
library;

/// Static asset path references.
///
/// Organized by asset type. Add new paths here as assets are
/// added to the project. Each path matches a declaration in
/// `pubspec.yaml` under `flutter.assets`.
abstract final class AssetPaths {
  // ── Base Directories ─────────────────────────────────────────────────

  static const String _images = 'assets/images';
  static const String _icons = 'assets/icons'; // ignore: unused_field
  static const String _animations = 'assets/animations'; // ignore: unused_field

  // ── Images ───────────────────────────────────────────────────────────

  /// Application logo displayed on splash and auth screens.
  static const String appLogo = '$_images/app_logo.png';

  // ── Icons ────────────────────────────────────────────────────────────

  // Add custom icon paths here as they are added to the project.
  // Example: static const String searchIcon = '$_icons/search.svg';

  // ── Animations ───────────────────────────────────────────────────────

  // Add Lottie or Rive animation paths here.
  // Example: static const String loadingAnimation = '$_animations/loading.json';
}
