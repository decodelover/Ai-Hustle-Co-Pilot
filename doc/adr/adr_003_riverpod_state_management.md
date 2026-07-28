# ADR-003: Riverpod as State Management Solution

## Status
Accepted

## Date
2026-07-28

## Context & Problem Statement

We needed a state management solution for AI Hustle Co-Pilot that would:
1. Provide compile-time safety for dependency injection
2. Support both synchronous and asynchronous state
3. Enable automatic disposal of unused providers
4. Work seamlessly with Clean Architecture's layer boundaries
5. Support code generation for reduced boilerplate

## Alternatives Considered

### 1. Provider (legacy)
- Simple but lacks compile-time safety, no auto-dispose, limited async support

### 2. BLoC/Cubit
- Strong separation but high boilerplate, event/state classes for every operation, tight library coupling

### 3. GetX
- Low boilerplate but poor testability, implicit service location, no compile-time safety

### 4. Riverpod (Selected)
- Compile-safe DI, auto-dispose, AsyncValue for async state, code generation support, testable via overrides

## Decision & Rationale

We selected **flutter_riverpod** with code generation (`riverpod_generator`, `riverpod_annotation`) because:

- `AsyncValue<T>` provides a single canonical state container for all async operations (loading, data, error)
- Provider overrides enable clean test isolation without mocking frameworks
- `autoDispose` prevents memory leaks for feature-scoped state
- `ref.watch(provider.select(...))` enables surgical rebuild optimization
- Code generation reduces manual provider boilerplate

## Consequences

### Positive
- Zero state management boilerplate with code generation
- Type-safe dependency graph validated at compile time
- Easy to test: override any provider in test harness
- Natural async state lifecycle with `AsyncValue`

### Negative
- Requires `build_runner` for code generation (mitigated by watch mode)
- Team must understand Riverpod-specific patterns (ref.watch vs ref.read)
