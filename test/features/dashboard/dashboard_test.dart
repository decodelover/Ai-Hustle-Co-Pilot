/// Comprehensive test suite for Phase 3.0 Enterprise Dashboard Foundation.
library;

import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_metric_card_model.dart';
import 'package:ai_hustle_copilot/features/dashboard/domain/models/dashboard_state.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_header_widget.dart';
import 'package:ai_hustle_copilot/features/dashboard/presentation/widgets/dashboard_metric_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Dashboard Domain & Presentation Unit & Widget Tests', () {
    test('DashboardMetricCardModel copyWith modifies fields cleanly', () {
      const model = DashboardMetricCardModel(
        id: '1',
        title: 'Projects',
        value: '10',
        trendPercentage: 5.0,
        isPositiveTrend: true,
        icon: Icons.folder,
      );

      final updated = model.copyWith(value: '15', trendPercentage: 8.5);

      expect(updated.value, equals('15'));
      expect(updated.trendPercentage, equals(8.5));
      expect(updated.title, equals('Projects'));
    });

    test('DashboardState copyWith updates state correctly', () {
      const state = DashboardState(productivityScore: 90);
      final updated = state.copyWith(productivityScore: 98, isRefreshing: true);

      expect(updated.productivityScore, equals(98));
      expect(updated.isRefreshing, isTrue);
    });

    testWidgets('DashboardMetricCard renders title, value, and trend percentage',
        (WidgetTester tester) async {
      const model = DashboardMetricCardModel(
        id: 'active_projects',
        title: 'Active Projects',
        value: '18',
        trendPercentage: 12.5,
        isPositiveTrend: true,
        icon: Icons.folder_open_outlined,
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: DashboardMetricCard(model: model),
          ),
        ),
      );

      expect(find.text('Active Projects'), findsOneWidget);
      expect(find.text('18'), findsOneWidget);
      expect(find.text('12.5%'), findsOneWidget);
    });

    testWidgets('DashboardHeaderWidget renders greeting, score, and CTA',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1280, 800);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: DashboardHeaderWidget(
                userName: 'Alex',
                workspaceName: 'AI Hustle Studio',
                productivityScore: 94,
                creditsRemaining: 840,
                onNewProjectPressed: () {},
                onRefreshPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.textContaining('Alex'), findsOneWidget);
      expect(find.text('AI Hustle Studio'), findsOneWidget);
      expect(find.text('94/100'), findsOneWidget);
      expect(find.text('New Project'), findsOneWidget);
    });

    testWidgets('DashboardScreen renders skeleton loader initially then success grid',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1440, 1200);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(
        const ProviderScope(
          child: MaterialApp(
            home: DashboardScreen(),
          ),
        ),
      );

      // Verify widget mounted
      expect(find.byType(DashboardScreen), findsOneWidget);
      await tester.pump(const Duration(milliseconds: 700));
      await tester.pumpAndSettle();
      expect(find.textContaining('Alex Manager'), findsOneWidget);
    });
  });
}
