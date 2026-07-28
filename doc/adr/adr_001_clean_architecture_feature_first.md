# ADR-001: Clean Architecture with Feature-First Organization

## Status
Accepted

## Date
2026-07-28

## Context & Problem Statement

AI Hustle Co-Pilot is designed to be a production-grade mobile application with complex features (AI-powered proposals, opportunity discovery, application pipeline management). We needed to choose an architectural pattern that would:

1. Support long-term maintainability as the feature set grows
2. Enable independent development of features by different team members
3. Allow infrastructure components (backend, storage, networking) to be replaced without affecting business logic
4. Facilitate comprehensive automated testing at every layer
5. Scale to 100+ screens without architectural degradation

## Alternatives Considered

### 1. MVC (Model-View-Controller)
- **Pros**: Simple, widely understood
- **Cons**: Controllers tend to become bloated ("Massive View Controller" anti-pattern), poor separation of concerns at scale, difficult to test business logic independently

### 2. MVVM (Model-View-ViewModel)
- **Pros**: Good separation of UI and logic, testable ViewModels
- **Cons**: Lacks explicit data layer abstraction, no built-in use case layer, ViewModels can still grow large without strict discipline

### 3. BLoC Pattern
- **Pros**: Strong separation of concerns, reactive state management
- **Cons**: High boilerplate, events/states can be overly complex for simple features, tight coupling to BLoC library

### 4. Clean Architecture + Feature-First (Selected)
- **Pros**: Maximum separation of concerns, fully testable layers, replaceable infrastructure, scalable feature organization
- **Cons**: More initial setup, steeper learning curve for new team members

## Decision & Rationale

We chose **Clean Architecture** with a **Feature-First** organization pattern because:

- **Domain purity**: Business rules are expressed in pure Dart with zero framework dependencies, making them infinitely reusable and testable
- **Feature isolation**: Each feature module (`auth/`, `dashboard/`, `shell/`) is self-contained with its own domain, data, application, and presentation layers
- **Repository pattern**: Data source abstraction allows swapping Supabase for Firebase, local SQLite, or mock implementations without touching any other layer
- **Use case pattern**: Single-responsibility use cases prevent controller bloat and serve as executable documentation of business operations
- **Riverpod DI**: Compile-safe dependency injection that integrates naturally with Flutter's widget tree

## Trade-offs & Consequences

### Positive
- Each layer can be tested in complete isolation
- New features follow a repeatable, standardized template
- Infrastructure changes (e.g., switching from Supabase to Firebase) affect only the Data layer
- Clear boundaries prevent accidental coupling between features

### Negative
- More files per feature compared to simpler architectures
- Requires discipline to maintain layer boundaries (mitigated by lint rules and code review)
- Initial learning curve for contributors unfamiliar with Clean Architecture

## Compliance
- SOLID principles enforced at every layer
- Feature modules have zero cross-dependencies
- Domain layer imports only `dart:core` and `fpdart` (functional utilities)
