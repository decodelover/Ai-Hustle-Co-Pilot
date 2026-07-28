# ADR-004: GoRouter as Navigation Solution

## Status
Accepted

## Date
2026-07-28

## Context & Problem Statement

We needed a navigation solution supporting:
1. Declarative route definitions with type-safe parameters
2. Authentication guards for protected routes
3. Deep link support for all routes
4. ShellRoute pattern for persistent navigation scaffold
5. Nested navigation within tabbed interfaces

## Alternatives Considered

### 1. Navigator 2.0 (Raw)
- Full control but extremely verbose, requires custom RouteInformationParser and RouterDelegate

### 2. AutoRoute
- Code generation approach, powerful but complex configuration, larger dependency surface

### 3. GoRouter (Selected)
- Official Flutter team recommendation, declarative syntax, built-in redirect guards, ShellRoute support, deep link handling

## Decision & Rationale

GoRouter was selected because:
- **Official support**: Maintained by Flutter team with guaranteed compatibility
- **ShellRoute**: First-class support for persistent navigation scaffolds (our adaptive shell)
- **Redirect guards**: Clean auth guard implementation for route protection
- **Deep links**: Automatic deep link resolution without additional configuration

## Route Architecture

```
/                       → SplashScreen (unprotected)
/welcome                → WelcomeScreen (unprotected, auth redirect)
/login                  → LoginScreen (unprotected, auth redirect)
/register               → RegisterScreen (unprotected, auth redirect)
/forgot-password        → ForgotPasswordScreen (unprotected)
/verify-email           → EmailVerificationScreen (unprotected)
/verification-success   → VerificationSuccessScreen (unprotected)

ShellRoute (ShellScreen — protected, auth guard)
├── /dashboard          → DashboardScreen
├── /discover           → DiscoverScreen
├── /ai-studio          → AiStudioScreen
├── /applications       → ApplicationsScreen
└── /profile            → ProfileScreen
```

## Consequences

### Positive
- Declarative route tree is easy to understand and maintain
- Auth guards centralized in router configuration
- ShellRoute preserves navigation state across tab switches

### Negative
- Route changes require updating `AppRouter` and `RouteNames` constants
- Complex nested navigation requires careful StatefulShellRoute configuration
