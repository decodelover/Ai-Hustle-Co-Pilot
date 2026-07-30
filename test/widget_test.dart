import 'package:ai_hustle_copilot/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App renders successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: AiHustleCoPilotApp(),
      ),
    );
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.byType(AiHustleCoPilotApp), findsOneWidget);

    // Allow background ticker loops to settle cleanly before disposal
    await tester.pump(const Duration(seconds: 6));
  });
}
