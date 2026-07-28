# Contributing to AI Hustle Co-Pilot

Thank you for your interest in contributing to AI Hustle Co-Pilot! This document provides guidelines and instructions for contributing to the project.

## Table of Contents

- [Code of Conduct](#code-of-conduct)
- [Development Setup](#development-setup)
- [Architecture Guidelines](#architecture-guidelines)
- [Git Workflow](#git-workflow)
- [Code Style](#code-style)
- [Pull Request Process](#pull-request-process)
- [Issue Reporting](#issue-reporting)

---

## Code of Conduct

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md). By participating, you are expected to uphold this code. Please report unacceptable behavior to the project maintainers.

---

## Development Setup

### Prerequisites

| Requirement | Version |
|-------------|---------|
| Flutter SDK | `>=3.12.1` |
| Dart SDK | Included with Flutter |
| Android Studio | Latest stable |
| Xcode | Latest stable (macOS only) |
| Git | Latest stable |

### Setup Steps

```bash
# 1. Fork and clone
git clone https://github.com/<your-username>/Ai-Hustle-Co-Pilot.git
cd Ai-Hustle-Co-Pilot

# 2. Set upstream
git remote add upstream https://github.com/decodelover/Ai-Hustle-Co-Pilot.git

# 3. Configure environment
cp .env.example .env
# Fill in your Supabase credentials

# 4. Install dependencies
flutter pub get

# 5. Run code generation
dart run build_runner build --delete-conflicting-outputs

# 6. Verify setup
flutter analyze
flutter test
```

---

## Architecture Guidelines

### Clean Architecture Layers

This project enforces strict **Clean Architecture** boundaries:

```
Presentation → Application → Domain ← Data
```

| Layer | Responsibility | Can Depend On |
|-------|---------------|---------------|
| **Presentation** | UI widgets, screens | Application, Domain |
| **Application** | Controllers, state coordination | Domain only |
| **Domain** | Entities, use cases, repository interfaces | Nothing (pure Dart) |
| **Data** | DTOs, data sources, repository implementations | Domain only |

### Key Rules

1. **Domain layer has ZERO framework dependencies** — No Flutter, no Supabase, no Dio imports.
2. **Features never depend on each other** — Inter-feature communication happens via shared domain models or core interfaces.
3. **DTOs never leak to Presentation** — Always map DTOs to domain entities in the Data layer.
4. **State management is Riverpod only** — No `Provider`, `GetX`, `Bloc`, or `setState`.
5. **Navigation is GoRouter only** — All routing goes through `AppRouter`.

### Feature Module Structure

Every feature follows this standardized structure:

```
features/<feature_name>/
├── application/          # Controllers, providers, state models
│   ├── controllers/     # Riverpod AsyncNotifier controllers
│   ├── providers/       # Provider registration & DI
│   └── state/           # Freezed application state models
├── data/                 # External dependencies
│   ├── datasources/     # Remote/local data source interfaces & implementations
│   ├── dtos/            # Data Transfer Objects (Freezed + json_serializable)
│   ├── mappers/         # DTO ↔ Entity mapping functions
│   └── repositories/    # Repository implementations
├── domain/               # Pure business logic
│   ├── entities/        # Immutable domain entities
│   ├── failures/        # Domain-specific failure classes
│   ├── repositories/    # Repository interface contracts
│   ├── use_cases/       # Single-responsibility use cases
│   └── value_objects/   # Self-validating value objects
└── presentation/         # UI layer
    ├── screens/         # Full-page screen widgets
    ├── widgets/         # Feature-specific reusable widgets
    └── providers/       # Presentation-specific providers
```

### 4-State UI Lifecycle

Every screen **must** implement all four states:

| State | Widget | Description |
|-------|--------|-------------|
| Loading | Skeleton shimmer loader | Matches layout geometry |
| Empty | Contextual illustration + CTA | Actionable guidance |
| Error | User-friendly message + retry | Structured failure mapping |
| Success | Content presentation | Smooth micro-animations |

---

## Git Workflow

### Branch Strategy

| Branch | Purpose |
|--------|---------|
| `main` | Production-ready code |
| `develop` | Integration branch for next release |
| `feature/<name>` | New feature development |
| `bugfix/<name>` | Bug fixes |
| `release/<version>` | Release preparation |

### Commit Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):

```
<type>(<scope>): <description>

[optional body]
[optional footer]
```

**Types:**

| Type | Usage |
|------|-------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Code change that neither fixes a bug nor adds a feature |
| `docs` | Documentation changes |
| `style` | Code style (formatting, semicolons, etc.) |
| `test` | Adding or modifying tests |
| `chore` | Build process, tooling, or auxiliary changes |
| `perf` | Performance improvements |

**Examples:**
```
feat(auth): add Google OAuth sign-in flow
fix(dashboard): resolve metric card overflow on small screens
refactor(shell): extract navigation rail into dedicated widget
docs(readme): update setup instructions for Supabase v2
test(auth): add unit tests for SignInController
```

### Atomic Commits

Every commit must:
- ✅ Solve **one** logical problem
- ✅ Compile successfully
- ✅ Pass `flutter analyze` with zero warnings
- ✅ Include a clear, descriptive message

**Never commit:**
- ❌ Broken code or unfinished architecture
- ❌ Debug `print()` statements
- ❌ Commented-out code blocks
- ❌ Hardcoded secrets or API keys

---

## Code Style

### File Size Limits

| Type | Max Lines | Guidance |
|------|-----------|----------|
| Widgets | 250 | Decompose into private/shared widgets |
| Screens | 350 | Delegate logic to controllers |
| Controllers | 200 | Split into focused responsibilities |

### Naming Conventions

- **Domain-driven, descriptive names**: `OpportunityRepository`, `ProposalGeneratorService`
- **Prohibited names**: `Helper`, `Manager`, `Util`, `Stuff`, `Thing`, `Data2`
- **Files**: `snake_case.dart`
- **Classes**: `PascalCase`
- **Variables/Methods**: `camelCase`
- **Constants**: `camelCase` (Dart convention)

### Documentation

- Document all public classes, interfaces, and methods using DartDoc (`///`)
- Explain **why** complex logic exists, not just **what** it does
- Add `@param` and `@return` descriptions for non-obvious methods

### Design System Compliance

- Use **only** design tokens from `core/design_system/tokens/`
- Follow the **8-point spacing grid** (8, 16, 24, 32, 40, 48 dp)
- Use `AppColors`, `AppSpacing`, `AppRadius`, `AppTypography` — never hardcode values
- Minimum touch target: **48×48 dp**

---

## Pull Request Process

### Before Submitting

Run the **16-Point Self-Audit Checklist**:

- [ ] No duplicated logic (DRY)
- [ ] No dead code or unused files
- [ ] No unused imports
- [ ] No unnecessary package dependencies
- [ ] Clean Architecture boundaries respected
- [ ] No circular dependencies between features
- [ ] Zero compile warnings
- [ ] `flutter analyze` passes with zero issues
- [ ] Proper null safety
- [ ] `const` constructors used where eligible
- [ ] Correct folder placement
- [ ] Domain-driven naming conventions
- [ ] DartDoc documentation on public surfaces
- [ ] Performance reviewed (rebuilds, caching)
- [ ] Accessibility reviewed (touch targets, semantics, contrast)
- [ ] Security reviewed (secrets protected, inputs sanitized)

### PR Template

When creating a pull request, include:

```markdown
## Summary
Brief description of changes.

## Type of Change
- [ ] New feature
- [ ] Bug fix
- [ ] Refactoring
- [ ] Documentation
- [ ] Tests

## Architecture Compliance
- [ ] Clean Architecture boundaries maintained
- [ ] Feature isolation preserved
- [ ] Design system tokens used (no hardcoded values)
- [ ] 4-state UI lifecycle implemented (if applicable)

## Testing
- [ ] Unit tests added/updated
- [ ] Widget tests added/updated
- [ ] `flutter analyze` passes with 0 warnings
- [ ] `flutter test` passes with 0 failures

## Screenshots (if UI changes)
[Attach before/after screenshots]
```

---

## Issue Reporting

### Bug Reports

Use the bug report template and include:

1. **Environment** — Flutter version, device/emulator, OS
2. **Steps to reproduce** — Numbered, specific steps
3. **Expected behavior** — What should happen
4. **Actual behavior** — What actually happens
5. **Screenshots/Logs** — Visual evidence or error logs
6. **Severity** — Critical / Major / Minor / Cosmetic

### Feature Requests

Include:

1. **Problem statement** — What problem does this solve?
2. **Proposed solution** — How should it work?
3. **Alternatives considered** — What other approaches were evaluated?
4. **Design mockups** — Wireframes or visual concepts (if applicable)

---

## Questions?

If you have questions about contributing, please open a [Discussion](https://github.com/decodelover/Ai-Hustle-Co-Pilot/discussions) or reach out to the project maintainers.

Thank you for helping make AI Hustle Co-Pilot better! 🚀
