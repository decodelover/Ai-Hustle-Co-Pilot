# AI Hustle Co-Pilot — Testing Guide

## Overview

AI Hustle Co-Pilot maintains a comprehensive test suite with **115+ test cases** covering all architectural layers. This document describes the testing strategy, structure, and guidelines.

---

## Test Architecture

### Test Pyramid

```
         ┌──────────┐
         │   E2E    │  Integration/Widget tests
         │  Tests   │  (Screens, navigation flows)
         ├──────────┤
         │  Widget  │  Component-level widget tests
         │  Tests   │  (Isolated widget behavior)
         ├──────────┤
         │   Unit   │  Domain, data, application layer
         │  Tests   │  (Business logic, mappers, controllers)
         └──────────┘
```

### Coverage by Layer

| Layer | Test Type | Coverage |
|-------|-----------|----------|
| Domain (Entities, Value Objects, Use Cases) | Unit | ✅ Comprehensive |
| Data (DTOs, Mappers, Repository Impl) | Unit | ✅ Comprehensive |
| Application (Controllers) | Unit | ✅ Comprehensive |
| Presentation (Screens, Widgets) | Widget | ✅ Core screens |
| Core (Errors, Logging, Network, Storage) | Unit | ✅ Infrastructure |
| Design System (Components) | Widget | ✅ Component gallery |

---

## Test Structure

```
test/
├── widget_test.dart                        # Default Flutter test
├── mocks/
│   └── mock_services.dart                  # Shared mock implementations
├── core/
│   ├── config/
│   │   └── environment_config_test.dart    # Environment configuration
│   ├── design_system/
│   │   ├── component_gallery_test.dart     # Design system gallery
│   │   └── design_system_components_test.dart  # Component rendering
│   ├── errors/
│   │   └── error_mapper_test.dart          # Error mapping logic
│   ├── logging/
│   │   └── logger_service_test.dart        # Logging abstraction
│   ├── network/
│   │   └── network_interceptors_test.dart  # HTTP interceptors
│   └── storage/
│       └── storage_services_test.dart      # Cache & secure storage
└── features/
    ├── auth/
    │   ├── application/controllers/
    │   │   ├── refresh_session_controller_test.dart
    │   │   ├── reset_password_controller_test.dart
    │   │   ├── sign_in_controller_test.dart
    │   │   ├── sign_out_controller_test.dart
    │   │   └── sign_up_controller_test.dart
    │   ├── data/
    │   │   ├── dtos/auth_user_dto_test.dart
    │   │   ├── mappers/auth_user_mapper_test.dart
    │   │   └── repositories/auth_repository_impl_test.dart
    │   ├── domain/
    │   │   ├── auth_user_test.dart
    │   │   ├── email_test.dart
    │   │   ├── password_test.dart
    │   │   └── use_cases_test.dart
    │   └── presentation/
    │       └── auth_screens_widget_test.dart
    ├── dashboard/
    │   └── dashboard_test.dart
    └── shell/
        └── shell_test.dart
```

---

## Running Tests

```bash
# Run all tests
flutter test

# Run with verbose output
flutter test --reporter expanded

# Run specific test file
flutter test test/features/auth/domain/email_test.dart

# Run with coverage report
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html

# Run static analysis
flutter analyze
```

---

## Writing Tests

### Unit Test Template

```dart
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ClassName', () {
    late ClassName sut; // System Under Test

    setUp(() {
      sut = ClassName();
    });

    test('should do something when condition is met', () {
      // Arrange
      final input = ...;

      // Act
      final result = sut.method(input);

      // Assert
      expect(result, equals(expected));
    });
  });
}
```

### Widget Test Template

```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('WidgetName', () {
    testWidgets('should render correctly', (tester) async {
      // Arrange & Act
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(body: WidgetName()),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.byType(WidgetName), findsOneWidget);
    });
  });
}
```

### Test Naming Convention

```
should [expected behavior] when [condition/state]
```

**Examples:**
- `should return AuthUser when sign in succeeds`
- `should throw AuthFailure when credentials are invalid`
- `should display loading skeleton when data is loading`
- `should show retry button when error state is active`

---

## Mock Strategy

- Use manual mock implementations (in `test/mocks/`)
- Override Riverpod providers in test harness
- Avoid heavy mocking frameworks — prefer simple, explicit mocks
- Mock at repository boundaries, not at data source level

---

## Quality Gates

Before merging, all PRs must pass:

- [ ] `flutter test` — All tests pass (0 failures)
- [ ] `flutter analyze` — Zero warnings or errors
- [ ] New features include corresponding tests
- [ ] Test coverage does not decrease
