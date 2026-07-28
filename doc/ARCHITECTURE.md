# AI Hustle Co-Pilot — Architecture Documentation

> **Architecture Pattern**: Feature-First + Clean Architecture + Repository Pattern + Dependency Injection (Riverpod)
>
> **Comparable To**: Linear, Notion, Stripe Dashboard — enterprise-grade mobile SaaS

---

## Table of Contents

- [Overview](#overview)
- [Architectural Principles](#architectural-principles)
- [Layer Architecture](#layer-architecture)
- [Feature Module Architecture](#feature-module-architecture)
- [State Management Architecture](#state-management-architecture)
- [Navigation Architecture](#navigation-architecture)
- [Design System Architecture](#design-system-architecture)
- [Error Handling Architecture](#error-handling-architecture)
- [Dependency Injection](#dependency-injection)
- [Data Flow](#data-flow)
- [Security Architecture](#security-architecture)

---

## Overview

AI Hustle Co-Pilot follows a **Feature-First Clean Architecture** pattern that ensures:

1. **Testability** — Every layer is independently testable with mock dependencies
2. **Scalability** — The architecture supports 100+ screens without degradation
3. **Maintainability** — Clear boundaries prevent feature coupling and knowledge silos
4. **Replaceability** — Infrastructure (Supabase, Dio, Hive) can be swapped without touching business logic

---

## Architectural Principles

### SOLID Compliance

| Principle | Application |
|-----------|-------------|
| **Single Responsibility** | Each class has one reason to change. Controllers manage state, use cases execute business rules, repositories abstract data access |
| **Open/Closed** | New features extend the system via new modules without modifying existing code |
| **Liskov Substitution** | All repository implementations are interchangeable with their interfaces |
| **Interface Segregation** | Clients depend only on interfaces they use (e.g., `AuthRepository` vs `DashboardRepository`) |
| **Dependency Inversion** | Domain layer depends on abstractions, never concrete implementations |

### Additional Design Guidelines

- **DRY** — Business logic extracted into reusable abstractions (e.g., `BaseAuthController`)
- **KISS** — Simplest solution that satisfies current requirements
- **YAGNI** — No speculative features or premature abstractions
- **Composition over Inheritance** — Favor protocol/interface composition
- **Explicit over Implicit** — Self-documenting code over clever tricks

---

## Layer Architecture

```
┌─────────────────────────────────────────────┐
│           PRESENTATION LAYER                 │
│                                              │
│  Screens → Widgets → Providers/Controllers   │
│                                              │
│  Depends on: Application, Domain             │
│  Contains: UI widgets, theme consumption     │
├──────────────────────────────────────────────┤
│           APPLICATION LAYER                  │
│                                              │
│  Controllers → State Models → Services       │
│                                              │
│  Depends on: Domain only                     │
│  Contains: State coordination, async logic   │
├──────────────────────────────────────────────┤
│             DOMAIN LAYER                     │
│                                              │
│  Entities → Use Cases → Repository Contracts │
│  Value Objects → Failures                    │
│                                              │
│  Depends on: NOTHING (pure Dart)             │
│  Contains: Business rules, contracts         │
├──────────────────────────────────────────────┤
│              DATA LAYER                      │
│                                              │
│  Data Sources → DTOs → Mappers → Repo Impls  │
│                                              │
│  Depends on: Domain (implements contracts)   │
│  Contains: External integrations             │
└──────────────────────────────────────────────┘
```

### Layer Rules

| Rule | Description |
|------|-------------|
| **Domain Purity** | Domain layer has zero dependencies on Flutter, Supabase, Dio, or any framework. Pure Dart only. |
| **Unidirectional Flow** | `Presentation → Application → Domain ← Data`. Presentation never imports Data. |
| **DTO Isolation** | Network/database DTOs never leak into Presentation. Always map to domain entities. |
| **Feature Isolation** | Features never import from each other. Cross-feature communication uses shared domain models or core interfaces. |

---

## Feature Module Architecture

Each feature follows a standardized 4-layer structure:

```
features/<feature_name>/
├── application/                  # State coordination layer
│   ├── controllers/             # Riverpod AsyncNotifier controllers
│   │   └── <action>_controller.dart
│   ├── providers/               # Provider registration & DI wiring
│   │   └── <feature>_providers.dart
│   └── state/                   # Freezed application state models
│       └── <feature>_state.dart
│
├── data/                         # External integration layer
│   ├── datasources/             # Data source abstractions & implementations
│   │   ├── <feature>_remote_data_source.dart      # Interface
│   │   └── supabase_<feature>_data_source.dart    # Implementation
│   ├── dtos/                    # Data Transfer Objects
│   │   └── <entity>_dto.dart    # Freezed + json_serializable
│   ├── mappers/                 # DTO ↔ Entity mapping
│   │   └── <entity>_mapper.dart
│   └── repositories/           # Repository implementations
│       └── <feature>_repository_impl.dart
│
├── domain/                       # Business logic layer (pure Dart)
│   ├── entities/                # Immutable domain entities
│   │   └── <entity>.dart
│   ├── failures/                # Domain-specific failure types
│   │   └── <feature>_failure.dart
│   ├── repositories/           # Repository interface contracts
│   │   └── <feature>_repository.dart
│   ├── use_cases/              # Single-responsibility operations
│   │   └── <action>_use_case.dart
│   └── value_objects/          # Self-validating value types
│       └── <value>.dart
│
└── presentation/                 # UI layer
    ├── screens/                 # Full-page screen widgets
    │   └── <feature>_screen.dart
    ├── widgets/                 # Feature-specific UI components
    │   └── <component>_widget.dart
    └── providers/              # Presentation-specific providers
        └── <feature>_state_provider.dart
```

### Implemented Features

| Feature | Status | Layers Implemented |
|---------|--------|--------------------|
| **Auth** | ✅ Complete | Domain, Data, Application, Presentation |
| **Dashboard** | ✅ Complete | Domain, Data, Application, Presentation |
| **Shell** | ✅ Complete | Domain, Application, Presentation |
| **Splash** | ✅ Complete | Presentation |
| **AI Studio** | 🔜 Scaffold | Presentation (placeholder) |
| **Applications** | 🔜 Scaffold | Presentation (placeholder) |
| **Discover** | 🔜 Scaffold | Presentation (placeholder) |
| **Profile** | 🔜 Scaffold | Presentation (placeholder) |

---

## State Management Architecture

### Riverpod Provider Hierarchy

```
┌─────────────────────────────────────────┐
│        UI Widgets (ref.watch)            │
│             │                            │
│     ┌───────▼────────┐                   │
│     │ Application     │                   │
│     │ Controllers     │ AsyncNotifier<T>  │
│     │ (State Owners)  │                   │
│     └───────┬────────┘                   │
│             │                            │
│     ┌───────▼────────┐                   │
│     │ Domain          │                   │
│     │ Use Cases       │ Pure functions    │
│     │                 │                   │
│     └───────┬────────┘                   │
│             │                            │
│     ┌───────▼────────┐                   │
│     │ Repository      │                   │
│     │ Providers       │ Riverpod DI       │
│     │                 │                   │
│     └───────┬────────┘                   │
│             │                            │
│     ┌───────▼────────┐                   │
│     │ Data Source      │                   │
│     │ Providers        │ Infrastructure   │
│     └─────────────────┘                   │
└─────────────────────────────────────────┘
```

### State Management Rules

1. **Single Source of Truth** — `AsyncValue<T>` is the canonical state container for async operations
2. **Targeted Rebuilds** — Use `ref.watch(provider.select(...))` to bind UI only to changed properties
3. **Controller Isolation** — Each controller owns one state slice; no shared mutable state
4. **Freezed Immutability** — All state models use Freezed for immutability and `copyWith` support

---

## Navigation Architecture

### GoRouter Configuration

```
/                          → SplashScreen
/welcome                   → WelcomeScreen (onboarding)
/login                     → LoginScreen
/register                  → RegisterScreen
/forgot-password            → ForgotPasswordScreen
/verify-email               → EmailVerificationScreen
/verification-success       → VerificationSuccessScreen
/component-gallery          → ComponentGalleryScreen (dev only)

ShellRoute (ShellScreen — adaptive navigation scaffold)
├── /dashboard              → DashboardScreen
├── /discover               → DiscoverScreen
├── /ai-studio              → AiStudioScreen
├── /applications           → ApplicationsScreen
└── /profile                → ProfileScreen
```

### Navigation Guards

- **Auth Guard** — Redirects unauthenticated users from protected routes to `/welcome`
- **Onboarding Guard** — Redirects authenticated users from auth routes to `/dashboard`
- **Deep Link Support** — All routes are deep-linkable with parameter passing

---

## Design System Architecture

### Token-Based Design

```
core/design_system/
├── tokens/
│   ├── app_colors.dart        # 38+ semantic color tokens
│   ├── app_typography.dart    # Type scale with Outfit + Inter
│   ├── app_spacing.dart       # 8-point spatial grid
│   ├── app_radius.dart        # Border radius scale
│   ├── app_elevation.dart     # Shadow system
│   ├── app_animation.dart     # Duration & curve presets
│   ├── app_breakpoints.dart   # Responsive thresholds
│   └── app_icon_sizes.dart    # Standardized icon dimensions
├── components/                # Reusable UI primitives
├── feedback/                  # State-specific feedback widgets
├── inputs/                    # Form field components
├── layout/                    # Responsive layout containers
└── loading/                   # Skeleton & shimmer loaders
```

### Responsive Breakpoints

| Breakpoint | Width | Layout |
|------------|-------|--------|
| Mobile | < 600dp | Bottom navigation, single column |
| Tablet | 600–1199dp | Navigation rail, 2 columns |
| Desktop | 1200–1919dp | Sidebar, 3 columns |
| UltraWide | ≥ 1920dp | Expanded sidebar, 4 columns |

---

## Error Handling Architecture

### Error Flow

```
Data Source (Dio/Supabase Exception)
    │
    ▼
Repository (Catch & Map)
    │
    ▼
Domain Failure Object (typed, user-friendly)
    │
    ▼
Riverpod Controller (AsyncError state)
    │
    ▼
UI Error State Widget (retry action)
```

### Failure Hierarchy

```dart
// Base failure
abstract class Failure {
  String get message;
}

// Domain-specific failures
class ServerFailure extends Failure { ... }
class NetworkFailure extends Failure { ... }
class CacheFailure extends Failure { ... }
class AuthFailure extends Failure { ... }
```

### Key Rules

1. **Raw exceptions never reach UI** — All caught at repository boundary
2. **User-friendly messages** — Failures carry localized, actionable messages
3. **Retry mechanisms** — Error states always include retry triggers
4. **Structured mapping** — `ErrorMapper` centralizes Dio-to-Failure conversion

---

## Dependency Injection

### Provider Graph

```dart
// Core Infrastructure Providers
supabaseClientProvider         → SupabaseClient
secureStorageProvider          → SecureStorageService
cacheStorageProvider           → CacheStorageService
dioClientProvider              → DioClient
networkInfoProvider            → NetworkInfo

// Auth Feature Providers
authRemoteDataSourceProvider   → AuthRemoteDataSource
authRepositoryProvider         → AuthRepository
signInUseCaseProvider          → SignInUseCase
signInControllerProvider       → SignInController

// Dashboard Feature Providers
dashboardRemoteDataSourceProvider → DashboardRemoteDataSource
dashboardRepositoryProvider       → DashboardRepository
dashboardControllerProvider       → DashboardController
```

### DI Rules

1. **Interface binding** — Providers expose interfaces, not implementations
2. **Lazy initialization** — Dependencies created only when first accessed
3. **Scoped disposal** — `autoDispose` for feature-scoped providers
4. **Override for testing** — All providers overridable in test harness

---

## Security Architecture

### Defense Layers

| Layer | Mechanism |
|-------|-----------|
| **Transport** | HTTPS-only, certificate pinning ready |
| **Authentication** | Supabase Auth with JWT tokens |
| **Token Storage** | `flutter_secure_storage` (Keychain/EncryptedSharedPreferences) |
| **Authorization** | Row Level Security (RLS) on Supabase |
| **Input Validation** | Domain-level Value Objects with strict validation |
| **Secrets Management** | `.env` + Envied compile-time injection |
| **Logging** | Production logs sanitized — no tokens/PII |
| **Code Analysis** | Strict Dart analysis with 80+ lint rules |

---

## Data Flow Diagram

### Read Operation

```
User Interaction
    │
    ▼
Screen Widget (ref.watch)
    │
    ▼
Riverpod Controller (AsyncNotifier)
    │
    ▼
Domain Use Case (execute)
    │
    ▼
Repository Interface (contract)
    │
    ▼
Repository Implementation (data layer)
    │
    ▼
Remote Data Source (Supabase/Dio)
    │
    ▼
DTO ← JSON Response
    │
    ▼
Mapper (DTO → Domain Entity)
    │
    ▼
AsyncData<Entity> → UI renders Success state
```

### Write Operation

```
User Submits Form
    │
    ▼
Controller.execute(...)
    │
    ▼
Use Case validates (Value Objects)
    │
    ▼
Repository.create/update(entity)
    │
    ▼
Mapper (Entity → DTO)
    │
    ▼
Data Source (network call)
    │
    ▼
Success → AsyncData | Failure → AsyncError
    │
    ▼
UI updates state accordingly
```

---

## References

- [Clean Architecture by Robert C. Martin](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html)
- [Riverpod Documentation](https://riverpod.dev/)
- [GoRouter Documentation](https://pub.dev/packages/go_router)
- [Flutter Architecture Guide](https://docs.flutter.dev/app-architecture)
- [Material 3 Design System](https://m3.material.io/)
