# Architecture Decision Records (ADR) Index

This directory contains Architecture Decision Records for AI Hustle Co-Pilot.

## What is an ADR?

An Architecture Decision Record (ADR) captures a significant architectural decision along with its context, alternatives considered, and consequences. ADRs serve as a historical record of **why** decisions were made.

## Format

Each ADR follows this structure:
- **Status**: Proposed | Accepted | Deprecated | Superseded
- **Context & Problem Statement**: What triggered this decision?
- **Alternatives Considered**: What options were evaluated?
- **Decision & Rationale**: What was chosen and why?
- **Consequences**: What are the trade-offs?

## Index

| ADR | Title | Status | Date |
|-----|-------|--------|------|
| [ADR-001](adr_001_clean_architecture_feature_first.md) | Clean Architecture with Feature-First Organization | Accepted | 2026-07-28 |
| [ADR-002](adr_002_authentication_application_layer.md) | Authentication Application Layer & Controller Architecture | Accepted | 2026-07-28 |
| [ADR-003](adr_003_riverpod_state_management.md) | Riverpod as State Management Solution | Accepted | 2026-07-28 |
| [ADR-004](adr_004_gorouter_navigation.md) | GoRouter as Navigation Solution | Accepted | 2026-07-28 |
| [ADR-005](adr_005_supabase_backend.md) | Supabase as Backend Infrastructure | Accepted | 2026-07-28 |
| [ADR-006](adr_006_enterprise_design_system.md) | Enterprise Design System with Custom Material 3 Tokens | Accepted | 2026-07-28 |

## Adding New ADRs

When making a significant architectural decision:

1. Create a new file: `adr_NNN_<short_title>.md`
2. Follow the template format above
3. Update this index
4. Get team review before marking as "Accepted"
