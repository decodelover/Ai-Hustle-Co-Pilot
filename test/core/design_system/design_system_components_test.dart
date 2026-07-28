import 'package:ai_hustle_copilot/core/design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildTestableWidget(Widget child) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: Scaffold(body: child),
    );
  }

  group('AppButton Widget Tests', () {
    testWidgets('renders button text and handles tap', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppButton(
            text: 'Submit Action',
            onPressed: () => pressed = true,
          ),
        ),
      );

      expect(find.text('Submit Action'), findsOneWidget);
      await tester.tap(find.text('Submit Action'));
      expect(pressed, isTrue);
    });

    testWidgets('shows loading spinner when isLoading is true', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppButton(
            text: 'Loading Action',
            isLoading: true,
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('does not trigger callback when isDisabled is true', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppButton(
            text: 'Disabled Button',
            isDisabled: true,
            onPressed: () => pressed = true,
          ),
        ),
      );

      await tester.tap(find.text('Disabled Button'));
      expect(pressed, isFalse);
    });
  });

  group('AppIconButton Widget Tests', () {
    testWidgets('renders icon button and handles tap', (tester) async {
      var pressed = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppIconButton(
            icon: Icons.add,
            tooltip: 'Add item',
            onPressed: () => pressed = true,
          ),
        ),
      );

      expect(find.byIcon(Icons.add), findsOneWidget);
      await tester.tap(find.byIcon(Icons.add));
      expect(pressed, isTrue);
    });
  });

  group('AppTextField Widget Tests', () {
    testWidgets('renders label, hint, and accepts input', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        buildTestableWidget(
          AppTextField(
            label: 'Email Address',
            hint: 'enter@example.com',
            controller: controller,
          ),
        ),
      );

      expect(find.text('Email Address'), findsOneWidget);
      expect(find.text('enter@example.com'), findsOneWidget);

      await tester.enterText(find.byType(TextFormField), 'user@ai.com');
      expect(controller.text, 'user@ai.com');
    });

    testWidgets('toggles password visibility on password type', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppTextField(
            label: 'Password',
            type: AppTextFieldType.password,
          ),
        ),
      );

      final visibilityToggle = find.byIcon(Icons.visibility_outlined);
      expect(visibilityToggle, findsOneWidget);

      await tester.tap(visibilityToggle);
      await tester.pump();
      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });
  });

  group('AppCard Widget Tests', () {
    testWidgets('renders title, subtitle, and handles tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppCard(
            title: 'Card Title',
            subtitle: 'Card Subtitle',
            onTap: () => tapped = true,
          ),
        ),
      );

      expect(find.text('Card Title'), findsOneWidget);
      expect(find.text('Card Subtitle'), findsOneWidget);

      await tester.tap(find.text('Card Title'));
      expect(tapped, isTrue);
    });
  });

  group('AppAvatar Widget Tests', () {
    testWidgets('computes initials correctly when image is null', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppAvatar(
            name: 'Jane Doe',
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });
  });

  group('AppBadge & AppChip Widget Tests', () {
    testWidgets('renders badge label and chip selection', (tester) async {
      var chipSelected = false;
      await tester.pumpWidget(
        buildTestableWidget(
          Column(
            children: [
              const AppBadge(label: 'Active', variant: AppBadgeVariant.success),
              AppChip(
                label: 'Filter Tag',
                onTap: () => chipSelected = true,
              ),
            ],
          ),
        ),
      );

      expect(find.text('Active'), findsOneWidget);
      expect(find.text('Filter Tag'), findsOneWidget);

      await tester.tap(find.text('Filter Tag'));
      expect(chipSelected, isTrue);
    });
  });

  group('AppListTile & AppSectionHeader Widget Tests', () {
    testWidgets('renders list tile and section header', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const Column(
            children: [
              AppSectionHeader(
                title: 'Overview Section',
                subtitle: 'Section Description',
              ),
              AppListTile(
                title: 'Item Title',
                subtitle: 'Item Subtitle',
                leading: Icon(Icons.settings),
              ),
            ],
          ),
        ),
      );

      expect(find.text('Overview Section'), findsOneWidget);
      expect(find.text('Section Description'), findsOneWidget);
      expect(find.text('Item Title'), findsOneWidget);
      expect(find.text('Item Subtitle'), findsOneWidget);
    });
  });

  group('Feedback & Lifecycle State Widget Tests', () {
    testWidgets('renders EmptyState with primary action trigger', (tester) async {
      var actionTriggered = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppEmptyState(
            title: 'No Data Found',
            subtitle: 'Start by creating a new project',
            primaryActionLabel: 'Create Project',
            onPrimaryAction: () => actionTriggered = true,
          ),
        ),
      );

      expect(find.text('No Data Found'), findsOneWidget);
      expect(find.text('Create Project'), findsOneWidget);

      await tester.tap(find.text('Create Project'));
      expect(actionTriggered, isTrue);
    });

    testWidgets('renders ErrorState with retry callback', (tester) async {
      var retried = false;
      await tester.pumpWidget(
        buildTestableWidget(
          AppErrorState(
            message: 'Network connection lost',
            onRetry: () => retried = true,
          ),
        ),
      );

      expect(find.text('Something went wrong'), findsOneWidget);
      expect(find.text('Network connection lost'), findsOneWidget);

      await tester.tap(find.text('Try Again'));
      expect(retried, isTrue);
    });

    testWidgets('renders SuccessState', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const AppSuccessState(
            title: 'Operation Completed',
            message: 'All changes saved successfully',
          ),
        ),
      );

      expect(find.text('Operation Completed'), findsOneWidget);
      expect(find.text('All changes saved successfully'), findsOneWidget);
    });
  });

  group('Loading & Animation Widget Tests', () {
    testWidgets('renders skeleton blocks and loading indicators', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const Column(
            children: [
              AppLoadingIndicator(),
              AppLoadingIndicator.linear(),
              SkeletonCard(),
              SkeletonText(lines: 2),
            ],
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(LinearProgressIndicator), findsOneWidget);
      expect(find.byType(SkeletonCard), findsOneWidget);
      expect(find.byType(SkeletonText), findsOneWidget);
    });

    testWidgets('renders responsive page container within max width', (tester) async {
      await tester.pumpWidget(
        buildTestableWidget(
          const ResponsivePageContainer(
            child: Text('Responsive Content'),
          ),
        ),
      );

      expect(find.text('Responsive Content'), findsOneWidget);
    });
  });
}
