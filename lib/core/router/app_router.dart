/// GoRouter configuration for the AI Hustle Co-Pilot application.
library;

import 'package:ai_hustle_copilot/core/design_system/gallery/component_gallery_screen.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/ai_studio/presentation/screens/ai_studio_screen.dart';
import 'package:ai_hustle_copilot/features/applications/presentation/screens/applications_screen.dart';
import 'package:ai_hustle_copilot/features/auth/domain/auth_state.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/providers/auth_state_provider.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/screens/email_verification_screen.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/screens/login_screen.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/screens/register_screen.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/screens/verification_success_screen.dart';
import 'package:ai_hustle_copilot/features/auth/presentation/screens/welcome_screen.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:ai_hustle_copilot/features/discover/presentation/screens/discover_screen.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/screens/document_editor_screen.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/screens/document_library_screen.dart';
import 'package:ai_hustle_copilot/features/documents/presentation/screens/template_gallery_screen.dart';
import 'package:ai_hustle_copilot/features/profile/presentation/screens/profile_screen.dart';
import 'package:ai_hustle_copilot/features/projects/presentation/screens/project_workspace_screen.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/screens/shell_scaffold.dart';
import 'package:ai_hustle_copilot/features/splash/presentation/screens/splash_screen.dart';
import 'package:ai_hustle_copilot/shared/widgets/module_hub_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Global navigator key for the root navigator.
final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

/// Navigator key for the shell route's nested navigator.
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'shell',
);

/// Computes navigation redirects from authentication state.
///
/// Every non-authentication route is private by default. Splash and the
/// developer component gallery remain available during initialization.
String? resolveAuthRedirect({
  required AppAuthState? authState,
  required String location,
}) {
  if (location == RoutePaths.splash ||
      location == RoutePaths.componentGallery) {
    return null;
  }

  final isAuthRoute =
      location == RoutePaths.welcome ||
      location == RoutePaths.login ||
      location == RoutePaths.register ||
      location == RoutePaths.forgotPassword ||
      location == RoutePaths.verifyEmail ||
      location == RoutePaths.verificationSuccess;

  if (authState is Authenticated && isAuthRoute) {
    return RoutePaths.dashboard;
  }
  if (authState is Unauthenticated && !isAuthRoute) {
    return RoutePaths.welcome;
  }
  return null;
}

/// Riverpod provider delivering the application [GoRouter] with reactive auth guards.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      return resolveAuthRedirect(
        authState: authState.valueOrNull,
        location: state.matchedLocation,
      );
    },
    routes: [
      GoRoute(
        path: RoutePaths.splash,
        name: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RoutePaths.welcome,
        name: RouteNames.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: RoutePaths.login,
        name: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RoutePaths.register,
        name: RouteNames.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: RoutePaths.forgotPassword,
        name: RouteNames.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: RoutePaths.verifyEmail,
        name: RouteNames.verifyEmail,
        builder: (context, state) {
          final email = state.extra as String?;
          return EmailVerificationScreen(
            email: email ?? 'your registered email address',
          );
        },
      ),
      GoRoute(
        path: RoutePaths.verificationSuccess,
        name: RouteNames.verificationSuccess,
        builder: (context, state) => const VerificationSuccessScreen(),
      ),
      GoRoute(
        path: RoutePaths.componentGallery,
        name: RouteNames.componentGallery,
        builder: (context, state) => const ComponentGalleryScreen(),
      ),

      // ── Enterprise Adaptive App Shell Route ─────────────────────────────
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => ShellScaffold(child: child),
        routes: [
          GoRoute(
            path: RoutePaths.dashboard,
            name: RouteNames.dashboard,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DashboardScreen()),
          ),
          GoRoute(
            path: RoutePaths.discover,
            name: RouteNames.discover,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DiscoverScreen()),
          ),
          GoRoute(
            path: RoutePaths.aiStudio,
            name: RouteNames.aiStudio,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: AiStudioScreen()),
          ),
          GoRoute(
            path: RoutePaths.applications,
            name: RouteNames.applications,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ApplicationsScreen()),
          ),
          GoRoute(
            path: RoutePaths.profile,
            name: RouteNames.profile,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen()),
          ),
          GoRoute(
            path: RoutePaths.automation,
            name: RouteNames.automation,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ModuleHubScreen(
                title: 'Automation',
                description:
                    'Control recurring application and follow-up workflows.',
                icon: Icons.bolt_outlined,
                actions: [
                  'Opportunity alerts',
                  'Proposal drafts',
                  'Follow-up reminders',
                ],
              ),
            ),
          ),
          GoRoute(
            path: RoutePaths.marketplace,
            name: RouteNames.marketplace,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ModuleHubScreen(
                title: 'Marketplace',
                description:
                    'Manage installed AI agents and workflow templates.',
                icon: Icons.storefront_outlined,
                actions: [
                  'Research agent',
                  'Proposal reviewer',
                  'Invoice assistant',
                ],
              ),
            ),
          ),
          GoRoute(
            path: RoutePaths.subscription,
            name: RouteNames.subscription,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ModuleHubScreen(
                title: 'Subscription',
                description:
                    'Review plan limits, billing preferences, and usage.',
                icon: Icons.credit_card_outlined,
                actions: [
                  'Usage alerts',
                  'Automatic renewal',
                  'Billing receipts',
                ],
              ),
            ),
          ),
          GoRoute(
            path: RoutePaths.settings,
            name: RouteNames.settings,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ModuleHubScreen(
                title: 'Settings',
                description:
                    'Configure workspace behavior and privacy defaults.',
                icon: Icons.settings_outlined,
                actions: ['Analytics', 'Local cache', 'AI memory'],
              ),
            ),
          ),
          GoRoute(
            path: RoutePaths.notifications,
            name: RouteNames.notifications,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ModuleHubScreen(
                title: 'Notifications',
                description: 'Choose which product events can notify you.',
                icon: Icons.notifications_outlined,
                actions: [
                  'Application updates',
                  'Project changes',
                  'AI task completion',
                ],
              ),
            ),
          ),
          GoRoute(
            path: RoutePaths.support,
            name: RouteNames.support,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ModuleHubScreen(
                title: 'Support',
                description:
                    'Access diagnostics and support communication preferences.',
                icon: Icons.support_agent_outlined,
                actions: [
                  'Share diagnostics',
                  'Status updates',
                  'Support replies',
                ],
              ),
            ),
          ),
          GoRoute(
            path: RoutePaths.projects,
            name: RouteNames.projects,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProjectWorkspaceScreen()),
          ),
          GoRoute(
            path: RoutePaths.documents,
            name: RouteNames.documents,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: DocumentLibraryScreen()),
          ),
          GoRoute(
            path: RoutePaths.documentTemplates,
            name: RouteNames.documentTemplates,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TemplateGalleryScreen()),
          ),
          GoRoute(
            path: RoutePaths.documentEditor,
            name: RouteNames.documentEditor,
            pageBuilder: (context, state) {
              final id = state.pathParameters['id'] ?? 'doc_101';
              return NoTransitionPage(
                child: DocumentEditorScreen(documentId: id),
              );
            },
          ),
          GoRoute(
            path: RoutePaths.projectDocumentEditor,
            name: RouteNames.projectDocumentEditor,
            pageBuilder: (context, state) {
              final docId = state.pathParameters['id'] ?? 'doc_101';
              return NoTransitionPage(
                child: DocumentEditorScreen(documentId: docId),
              );
            },
          ),
        ],
      ),
    ],
  );
});
