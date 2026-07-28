/// Unit and widget tests for Phase 2.6 Enterprise App Shell.
library;

import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:ai_hustle_copilot/features/shell/shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createTestableWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        theme: AppTheme.lightTheme,
        home: Scaffold(body: child),
      ),
    );
  }

  group('Enterprise App Shell Unit & Widget Tests', () {
    test('ShellNavigationConfig lists valid data-driven destinations', () {
      expect(ShellNavigationConfig.items.isNotEmpty, isTrue);
      expect(ShellNavigationConfig.primaryTabs.length, equals(5));
      expect(
        ShellNavigationConfig.items.first.title,
        equals('Dashboard'),
      );
    });

    testWidgets('ShellScreen renders TopBar and Sidebar in Desktop mode',
        (tester) async {
      tester.view.physicalSize = const Size(1440, 900);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const ShellScreen(
              child: Text('Dashboard Content'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Dashboard Content'), findsOneWidget);
      expect(find.byType(AppSidebar), findsOneWidget);
      expect(find.byType(AppTopBar), findsOneWidget);
    });

    testWidgets('ShellScreen renders BottomNavigation and FAB in Phone mode',
        (tester) async {
      tester.view.physicalSize = const Size(390, 844);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.lightTheme,
            home: const ShellScreen(
              child: Text('Mobile Content'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Mobile Content'), findsOneWidget);
      expect(find.byType(AppBottomNavigation), findsOneWidget);
      expect(find.byType(AiFloatingButton), findsOneWidget);
    });

    testWidgets('CommandPaletteWidget renders search input and navigation list',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const CommandPaletteWidget()));
      await tester.pump();

      expect(find.text('Type a command or search...'), findsOneWidget);
      expect(find.text('NAVIGATION & MODULES'), findsOneWidget);
      expect(find.text('Dashboard'), findsOneWidget);
    });

    testWidgets('WorkspaceSwitcher renders active workspace title and tier badge',
        (tester) async {
      await tester.pumpWidget(createTestableWidget(const WorkspaceSwitcher()));
      await tester.pumpAndSettle();

      expect(find.text('Personal Workspace'), findsOneWidget);
      expect(find.text('Pro Member'), findsOneWidget);
    });
  });
}
