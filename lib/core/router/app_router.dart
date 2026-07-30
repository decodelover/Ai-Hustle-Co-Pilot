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
import 'package:ai_hustle_copilot/features/profile/presentation/screens/profile_screen.dart';
import 'package:ai_hustle_copilot/features/shell/presentation/screens/shell_scaffold.dart';
import 'package:ai_hustle_copilot/features/splash/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// Global navigator key for the root navigator.
final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

/// Navigator key for the shell route's nested navigator.
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Riverpod provider delivering the application [GoRouter] with reactive auth guards.
final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePaths.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final location = state.matchedLocation;
      final currentAuthState = authState.valueOrNull;

      if (location == RoutePaths.splash ||
          location == RoutePaths.componentGallery) {
        return null;
      }

      final isAuthRoute = location == RoutePaths.welcome ||
          location == RoutePaths.login ||
          location == RoutePaths.register ||
          location == RoutePaths.forgotPassword ||
          location == RoutePaths.verifyEmail ||
          location == RoutePaths.verificationSuccess;

      final isProtectedShellRoute = location == RoutePaths.dashboard ||
          location == RoutePaths.discover ||
          location == RoutePaths.aiStudio ||
          location == RoutePaths.applications ||
          location == RoutePaths.profile ||
          location == RoutePaths.automation ||
          location == RoutePaths.documents ||
          location == RoutePaths.marketplace ||
          location == RoutePaths.subscription ||
          location == RoutePaths.settings ||
          location == RoutePaths.notifications ||
          location == RoutePaths.support;

      if (currentAuthState is Authenticated) {
        if (isAuthRoute) {
          return RoutePaths.dashboard;
        }
      } else if (currentAuthState is Unauthenticated) {
        if (isProtectedShellRoute) {
          return RoutePaths.welcome;
        }
      }

      return null;
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
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DashboardScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.discover,
            name: RouteNames.discover,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: DiscoverScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.aiStudio,
            name: RouteNames.aiStudio,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AiStudioScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.applications,
            name: RouteNames.applications,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ApplicationsScreen(),
            ),
          ),
          GoRoute(
            path: RoutePaths.profile,
            name: RouteNames.profile,
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});

/// Legacy global instance alias for backwards compatibility.
final GoRouter appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePaths.splash,
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
      builder: (context, state) => const EmailVerificationScreen(),
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
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => ShellScaffold(child: child),
      routes: [
        GoRoute(
          path: RoutePaths.dashboard,
          name: RouteNames.dashboard,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DashboardScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.discover,
          name: RouteNames.discover,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: DiscoverScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.aiStudio,
          name: RouteNames.aiStudio,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: AiStudioScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.applications,
          name: RouteNames.applications,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ApplicationsScreen(),
          ),
        ),
        GoRoute(
          path: RoutePaths.profile,
          name: RouteNames.profile,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: ProfileScreen(),
          ),
        ),
      ],
    ),
  ],
);
