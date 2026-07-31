/// Typed route name constants for GoRouter navigation.
library;

/// Named route definitions for the application router.
abstract final class RouteNames {
  // ── Standalone Routes ────────────────────────────────────────────────

  /// Splash screen shown during app initialization.
  static const String splash = 'splash';

  /// Welcome / Onboarding hero screen.
  static const String welcome = 'welcome';

  /// Authentication: Sign in screen.
  static const String login = 'login';

  /// Authentication: Create account screen.
  static const String register = 'register';

  /// Authentication: Password recovery screen.
  static const String forgotPassword = 'forgot-password';

  /// Authentication: Email verification status screen.
  static const String verifyEmail = 'verify-email';

  /// Authentication: Verification completion celebration screen.
  static const String verificationSuccess = 'verification-success';

  /// Developer component gallery storybook screen.
  static const String componentGallery = 'component-gallery';

  // ── Main Shell Routes ────────────────────────────────────────────────

  /// Primary dashboard / home screen.
  static const String dashboard = 'dashboard';

  /// Opportunity discovery and browsing.
  static const String discover = 'discover';

  /// AI-powered workspace and tools.
  static const String aiStudio = 'ai-studio';

  /// Application tracking and management.
  static const String applications = 'applications';

  /// User profile and settings.
  static const String profile = 'profile';

  /// Automated application pipelines.
  static const String automation = 'automation';

  /// Documents and proposals repository.
  static const String documents = 'documents';
  static const String documentTemplates = 'document-templates';
  static const String documentEditor = 'document-editor';
  static const String projectDocumentEditor = 'project-document-editor';

  /// AI Tools Marketplace.
  static const String marketplace = 'marketplace';

  /// Subscription and billing management.
  static const String subscription = 'subscription';

  /// Workspace settings.
  static const String settings = 'settings';

  /// AI Projects Command Center.
  static const String projects = 'projects';

  /// AI Project Workspace.
  static const String projectWorkspace = 'project-workspace';

  /// Notifications center.
  static const String notifications = 'notifications';

  /// Help and support desk.
  static const String support = 'support';
}

/// Route path definitions corresponding to [RouteNames].
abstract final class RoutePaths {
  // ── Standalone Paths ─────────────────────────────────────────────────

  static const String splash = '/';
  static const String welcome = '/welcome';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';
  static const String verifyEmail = '/verify-email';
  static const String verificationSuccess = '/verification-success';
  static const String componentGallery = '/component-gallery';

  // ── Shell Paths ──────────────────────────────────────────────────────

  static const String dashboard = '/dashboard';
  static const String discover = '/discover';
  static const String aiStudio = '/ai-studio';
  static const String applications = '/applications';
  static const String profile = '/profile';
  static const String projects = '/projects';
  static const String projectWorkspace = '/projects/:id';
  static const String automation = '/automation';
  static const String documents = '/documents';
  static const String documentTemplates = '/documents/templates';
  static const String documentEditor = '/documents/:id';
  static const String projectDocumentEditor = '/projects/:projectId/documents/:id';
  static const String marketplace = '/marketplace';
  static const String subscription = '/subscription';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String support = '/support';
}
