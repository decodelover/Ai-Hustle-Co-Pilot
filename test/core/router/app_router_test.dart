/// Authentication redirect policy tests.
library;

import 'package:ai_hustle_copilot/core/router/app_router.dart';
import 'package:ai_hustle_copilot/core/router/route_names.dart';
import 'package:ai_hustle_copilot/features/auth/domain/auth_state.dart';
import 'package:ai_hustle_copilot/features/auth/domain/entities/auth_user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolveAuthRedirect', () {
    test('protects nested and parameterized workspace routes', () {
      for (final path in [
        '/projects',
        '/documents/templates',
        '/documents/doc-1',
        '/projects/project-1/documents/doc-1',
      ]) {
        expect(
          resolveAuthRedirect(
            authState: const Unauthenticated(),
            location: path,
          ),
          RoutePaths.welcome,
        );
      }
    });

    test('redirects authenticated users away from auth screens', () {
      const user = AuthUser(
        id: 'user-1',
        email: 'member@example.com',
        emailVerified: true,
      );
      expect(
        resolveAuthRedirect(
          authState: const Authenticated(user: user),
          location: RoutePaths.login,
        ),
        RoutePaths.dashboard,
      );
    });

    test('allows startup routes while authentication initializes', () {
      expect(
        resolveAuthRedirect(authState: null, location: RoutePaths.splash),
        isNull,
      );
    });
  });
}
