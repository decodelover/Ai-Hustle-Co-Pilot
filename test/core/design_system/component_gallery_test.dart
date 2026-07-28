import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('ComponentGalleryScreen renders successfully', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: ComponentGalleryScreen(),
      ),
    );
    await tester.pump();

    expect(find.text('Component Gallery (Dev Storybook)'), findsOneWidget);
    expect(find.text('Buttons'), findsAtLeastNWidgets(1));
  });

  testWidgets('AppButton renders and triggers onPressed', (tester) async {
    var pressed = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AppButton(
            text: 'Click Me',
            onPressed: () => pressed = true,
          ),
        ),
      ),
    );

    expect(find.text('Click Me'), findsOneWidget);
    await tester.tap(find.text('Click Me'));
    expect(pressed, isTrue);
  });
}
