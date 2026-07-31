/// Device-level startup smoke test.
library;

import 'package:ai_hustle_copilot/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('application reaches its initial route', (tester) async {
    await app.main();
    await tester.pumpAndSettle(const Duration(seconds: 8));
    expect(find.text('AI Hustle'), findsWidgets);
  });
}
