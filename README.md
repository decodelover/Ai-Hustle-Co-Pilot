# 🚀 AI Hustle Co-Pilot

<p align="center">
  <img src="assets/images/app_logo.png" alt="AI Hustle Co-Pilot" width="120" height="120" />
</p>

<p align="center">
  <strong>Your AI-Powered Freelance Command Center</strong>
</p>

<p align="center">
  <em>Discover opportunities. Generate winning proposals. Manage your pipeline — all enhanced by artificial intelligence.</em>
</p>

<p align="center">
  <a href="#features">Features</a> •
  <a href="#architecture">Architecture</a> •
  <a href="#getting-started">Getting Started</a> •
  <a href="#tech-stack">Tech Stack</a> •
  <a href="#documentation">Documentation</a> •
  <a href="#contributing">Contributing</a>
</p>

---

## 📋 Overview

**AI Hustle Co-Pilot** is a premium, enterprise-grade mobile application that empowers freelancers with AI-driven tools to discover high-value opportunities, generate compelling proposals, manage application pipelines, and optimize their freelancing workflow. Built with Flutter for Android and iOS, it delivers a world-class user experience comparable to **Linear**, **Notion AI**, **Stripe Dashboard**, and **Raycast**.

## ✨ Features

### 🎯 Core Capabilities

| Feature | Description |
|---------|-------------|
| **AI-Powered Proposals** | Generate tailored, winning proposals using advanced AI models |
| **Opportunity Discovery** | Smart matching and real-time opportunity feed with intelligent filters |
| **Application Pipeline** | Kanban-style pipeline tracking from discovery to contract |
| **AI Studio** | Dedicated workspace for AI-assisted resume analysis, cover letters, and skill gap detection |
| **Smart Dashboard** | Real-time metrics, AI insights, activity feeds, and actionable analytics |
| **Adaptive Shell** | Enterprise-grade responsive navigation that adapts across phone, tablet, and desktop |

### 🎨 Design Excellence

- **Custom Material 3 Design System** — Deep violet/indigo palette with teal accents
- **Dual Theme Support** — Fully designed light and dark themes with system-aware switching
- **Motion System** — Curated micro-animations, transitions, and interaction feedback
- **Responsive Layouts** — Adaptive UI across Mobile (<600dp), Tablet (600-1199dp), Desktop (1200-1919dp), UltraWide (≥1920dp)
- **4-State UI Lifecycle** — Every screen implements Loading, Empty, Error, and Success states

### 🔒 Security & Reliability

- **Supabase Authentication** — Email/password, Google, and GitHub OAuth
- **Secure Token Storage** — `flutter_secure_storage` for credential management
- **Row Level Security** — Database-level access control
- **Offline-First Architecture** — Graceful degradation with cached data and queued sync
- **Error Boundary System** — Structured error mapping from data to presentation layers

---

## 🏗 Architecture

This project follows **Clean Architecture** with a **Feature-First** organization pattern, **Repository Pattern**, and **Dependency Injection** via **Riverpod**.

```
┌─────────────────────────────────────────────────────────────────┐
│                      PRESENTATION LAYER                         │
│  ┌───────────┐  ┌────────────────┐  ┌────────────────────────┐ │
│  │  Screens   │  │    Widgets     │  │  Riverpod Providers/   │ │
│  │  (Pages)   │  │  (Reusable)    │  │  Controllers           │ │
│  └─────┬──────┘  └────────────────┘  └──────────┬────────────┘ │
│        │                                         │              │
├────────┼─────────────────────────────────────────┼──────────────┤
│        │          APPLICATION LAYER              │              │
│  ┌─────▼──────┐  ┌────────────────┐  ┌──────────▼────────────┐ │
│  │ Controllers │  │  App Services  │  │   State Models        │ │
│  │ (Notifiers) │  │  (Coordinators)│  │   (Freezed)           │ │
│  └─────┬──────┘  └────────────────┘  └──────────┬────────────┘ │
│        │                                         │              │
├────────┼─────────────────────────────────────────┼──────────────┤
│        │            DOMAIN LAYER                 │              │
│  ┌─────▼──────┐  ┌────────────────┐  ┌──────────▼────────────┐ │
│  │  Entities   │  │   Use Cases    │  │  Repository Interfaces│ │
│  │  (Models)   │  │                │  │  (Contracts)          │ │
│  └─────────────┘  └────────────────┘  └──────────┬────────────┘ │
│                                                   │              │
├───────────────────────────────────────────────────┼──────────────┤
│                      DATA LAYER                   │              │
│  ┌─────────────┐  ┌────────────────┐  ┌──────────▼────────────┐ │
│  │  DTOs /      │  │  Data Sources  │  │  Repository           │ │
│  │  Mappers     │  │  (Remote/Local)│  │  Implementations      │ │
│  └─────────────┘  └────────────────┘  └───────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

### 📁 Project Structure

```
lib/
├── core/                            # Application-wide core infrastructure
│   ├── config/                     # Environment & app configuration (Envied)
│   ├── constants/                  # App constants, asset paths, magic values
│   ├── design_system/              # Enterprise Design System Foundation
│   │   ├── animations/            # Motion system & transition utilities
│   │   ├── components/            # Reusable UI primitives (buttons, cards)
│   │   ├── feedback/              # Empty, error, success state widgets
│   │   ├── inputs/                # Form fields & interactive inputs
│   │   ├── layout/                # Responsive containers & grids
│   │   ├── loading/               # Skeleton loaders & shimmer effects
│   │   ├── tokens/                # Design tokens (colors, spacing, typography)
│   │   └── utils/                 # Context extensions & UI utilities
│   ├── errors/                     # Custom exceptions & domain failures
│   ├── init/                       # App initialization orchestrator
│   ├── logging/                    # Structured logging abstraction
│   ├── network/                    # Dio HTTP client, interceptors, network info
│   ├── providers/                  # Core Supabase & service providers
│   ├── router/                     # GoRouter configuration & route guards
│   ├── security/                   # Secure storage for credentials
│   ├── storage/                    # Hive cache & persistence layer
│   └── theme/                      # Material 3 design tokens & theme data
├── features/                        # Feature-first domain modules
│   ├── auth/                       # Authentication (login, register, OAuth, MFA)
│   │   ├── application/           # Controllers, providers, state models
│   │   ├── data/                  # Data sources, DTOs, mappers, repo impl
│   │   ├── domain/                # Entities, use cases, value objects
│   │   └── presentation/         # Screens, widgets, auth-specific UI
│   ├── dashboard/                  # Enterprise AI Dashboard
│   │   ├── application/           # Dashboard controller & providers
│   │   ├── data/                  # Remote data source & repo implementation
│   │   ├── domain/                # Metric models, state, repository interface
│   │   └── presentation/         # Dashboard screen, widgets, skeleton loader
│   ├── shell/                      # Adaptive App Shell (navigation scaffold)
│   │   ├── application/           # Shell controller, analytics, AI launcher
│   │   ├── domain/                # Navigation config, workspace models
│   │   └── presentation/         # Bottom nav, rail, sidebar, top bar, drawer
│   ├── ai_studio/                  # AI-powered workspace (future)
│   ├── applications/               # Application pipeline tracking (future)
│   ├── discover/                   # Opportunity browsing & search (future)
│   ├── profile/                    # User profile & settings (future)
│   └── splash/                     # App launch & initialization
├── shared/                          # Cross-feature reusable infrastructure
│   ├── providers/                  # Core dependency injection providers
│   └── widgets/                    # Shared UI primitives
└── l10n/                            # Localization (future)
```

> For detailed architectural documentation, see **[ARCHITECTURE.md](doc/ARCHITECTURE.md)**.

---

## 🛠 Tech Stack

| Category | Technology | Purpose |
|----------|------------|---------|
| **Framework** | Flutter 3.12+ | Cross-platform mobile (Android & iOS) |
| **Language** | Dart 3.12+ | Type-safe, null-safe development |
| **State Management** | Riverpod 2.6+ | Compile-safe dependency injection & reactive state |
| **Navigation** | GoRouter 14.6+ | Declarative routing with guards & deep links |
| **Backend** | Supabase 2.9+ | Auth, database, storage, realtime |
| **Networking** | Dio 5.7+ | HTTP client with interceptors |
| **Local Storage** | Hive + Secure Storage | Fast KV cache + encrypted credentials |
| **Data Modeling** | Freezed + json_serializable | Immutable models & JSON serialization |
| **Functional** | fpdart 1.1+ | `Either`, `Option` for type-safe error handling |
| **Typography** | Google Fonts (Outfit + Inter) | Premium typeface system |
| **Environment** | Envied | Compile-time environment injection |
| **Logging** | Logger 2.5+ | Structured, filtered logging |
| **Code Gen** | build_runner | Automated code generation pipeline |

---

## 🚀 Getting Started

### Prerequisites

- **Flutter SDK** `>=3.12.1` — [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Dart SDK** (included with Flutter)
- **Android Studio** or **Xcode** (for platform-specific builds)
- **Supabase Project** — [Create one at supabase.com](https://supabase.com)

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/decodelover/Ai-Hustle-Co-Pilot.git
cd Ai-Hustle-Co-Pilot

# 2. Configure environment variables
cp .env.example .env
# Edit .env and add your Supabase credentials

# 3. Install dependencies
flutter pub get

# 4. Run code generation
dart run build_runner build --delete-conflicting-outputs

# 5. Launch on a connected device or emulator
flutter run
```

### Environment Configuration

Create a `.env` file in the project root (see `.env.example`):

```env
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_PUBLISHABLE_KEY=your-publishable-key-here
```

> ⚠️ **Security**: The `.env` file is included in `.gitignore` and must **never** be committed to version control.

### Code Generation

This project uses `build_runner` for code generation (Freezed, Envied, Riverpod, json_serializable):

```bash
# One-time build
dart run build_runner build --delete-conflicting-outputs

# Watch mode (auto-rebuild on file changes)
dart run build_runner watch --delete-conflicting-outputs
```

### Running Tests

```bash
# Run all tests
flutter test

# Run with coverage
flutter test --coverage

# Run static analysis
flutter analyze
```

---

## 📖 Documentation

| Document | Description |
|----------|-------------|
| [ARCHITECTURE.md](doc/ARCHITECTURE.md) | Clean Architecture deep-dive, layer responsibilities, data flow |
| [DESIGN_LANGUAGE.md](DESIGN_LANGUAGE.md) | Enterprise design language specification |
| [DESIGN_SYSTEM.md](doc/DESIGN_SYSTEM.md) | Component library, tokens, and usage guide |
| [CONTRIBUTING.md](CONTRIBUTING.md) | Contribution guidelines and development workflow |
| [CHANGELOG.md](CHANGELOG.md) | Version history and release notes |
| [SECURITY.md](SECURITY.md) | Security policy and vulnerability reporting |
| [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md) | Community standards and behavior guidelines |
| [ADR Index](doc/adr/) | Architecture Decision Records |

---

## 🗺 Roadmap

### Completed Phases

- [x] **Phase 1.0** — Project Scaffold, Environment Config, Logging, Network Layer
- [x] **Phase 2.0** — Core Infrastructure (Errors, Storage, Security, Providers)
- [x] **Phase 2.1** — Authentication Domain Layer (Entities, Use Cases, Value Objects)
- [x] **Phase 2.2** — Authentication Data Layer (DTOs, Mappers, Repository Impl)
- [x] **Phase 2.3** — Authentication Application Layer (Controllers, State Models)
- [x] **Phase 2.4A** — Enterprise Design System Foundation (Tokens, Animations)
- [x] **Phase 2.4B** — Enterprise Design System Components (Buttons, Cards, Inputs)
- [x] **Phase 2.5** — Authentication Presentation Layer (Screens, Widgets, OAuth)
- [x] **Phase 2.6** — Enterprise Adaptive App Shell (Navigation, Responsive Layout)
- [x] **Phase 3.0** — Enterprise Dashboard Foundation (Metrics, Insights, Activity)

### Upcoming Phases

- [ ] **Phase 3.1** — Opportunity Discovery & Smart Matching
- [ ] **Phase 3.2** — AI Proposal Generation Engine
- [ ] **Phase 3.3** — Application Pipeline Management
- [ ] **Phase 3.4** — AI Studio Workspace
- [ ] **Phase 4.0** — User Profile & Settings
- [ ] **Phase 5.0** — Offline Sync, Push Notifications, Analytics

---

## 🤝 Contributing

We welcome contributions! Please see our **[Contributing Guide](CONTRIBUTING.md)** for details on:

- Setting up your development environment
- Code style guidelines and architecture constraints
- Submitting pull requests
- Reporting issues

---

## 📄 License

This project is proprietary software. All rights reserved.

See **[LICENSE](LICENSE)** for more information.

---

<p align="center">
  Built with ❤️ using Flutter & Dart
</p>
