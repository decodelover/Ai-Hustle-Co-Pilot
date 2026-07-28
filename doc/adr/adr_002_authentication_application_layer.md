# ADR-002: Authentication Application Layer & Controller Architecture

## Context & Problem Statement
In Clean Architecture and Feature-first Flutter applications, UI presentation widgets must remain declarative and thin, containing zero business rules or direct data-source interactions. The Authentication Domain Layer (Phase 2.1) defines business entities and use cases, while the Data Layer (Phase 2.2) encapsulates network execution. 

We need a dedicated Application Layer to coordinate presentation components with domain use cases via Riverpod state management.

## Decision & Rationale
We introduce a dedicated **Authentication Application Layer** (`lib/features/auth/application/`) containing:
1. **Application Controllers** (`SignInController`, `SignUpController`, `SignOutController`, `ResetPasswordController`, `ResendVerificationController`, `RefreshSessionController`).
2. **Shared Abstract Base Controller** (`BaseAuthController<T>`) inheriting from Riverpod's `AutoDisposeAsyncNotifier<T>` to centralize async execution, lifecycle updates (`AsyncLoading`, `AsyncData`, `AsyncError`), and failure-to-message translation.
3. **Application State Models** (`AuthActionState`, `AuthFormState`).
4. **Centralized Provider Registration** (`auth_application_providers.dart`).

### Key Principles
- **No Duplicated State**: `AsyncValue<T>` is the single source of truth for async lifecycle state (`loading`, `data`, `error`). UI-specific payloads use `AuthActionState` / `AuthFormState`.
- **Pure Domain Dependencies**: Controllers depend solely on Domain use cases (`SignInUseCase`, etc.) and Domain Value Objects (`Email`, `Password`). Zero imports of Supabase, Dio, Hive, or Data DTOs.
- **DRY Async Execution**: `BaseAuthController.executeOperation()` encapsulates try-catch blocks, state updates, and error message mapping.

## Consequences & Compliance
- Presentation widgets observe controllers using standard Riverpod `ref.watch(signInControllerProvider)`.
- 100% unit-testable controllers without UI bindings.
- Fully compliant with SOLID, DRY, and Clean Architecture standards.

## Status
Accepted
