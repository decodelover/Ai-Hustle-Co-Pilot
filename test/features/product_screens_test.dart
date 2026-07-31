/// Tests for opportunity and application interactions.
library;

import 'package:ai_hustle_copilot/features/applications/presentation/screens/applications_screen.dart';
import 'package:ai_hustle_copilot/features/discover/presentation/screens/discover_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('DiscoverScreen searches opportunities', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DiscoverScreen()));
    expect(find.text('Flutter SaaS dashboard'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'content workflow');
    await tester.pump();
    expect(find.text('AI content workflow specialist'), findsOneWidget);
    expect(find.text('Flutter SaaS dashboard'), findsNothing);
  });

  testWidgets('ApplicationsScreen filters pipeline stages', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: ApplicationsScreen()));
    expect(find.text('Flutter SaaS dashboard'), findsOneWidget);

    await tester.tap(find.byTooltip('Filter applications'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Offer').last);
    await tester.pumpAndSettle();

    expect(find.text('Mobile platform architect'), findsOneWidget);
    expect(find.text('Flutter SaaS dashboard'), findsNothing);
  });
}
