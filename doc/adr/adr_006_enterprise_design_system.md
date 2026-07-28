# ADR-006: Enterprise Design System with Custom Material 3 Tokens

## Status
Accepted

## Date
2026-07-28

## Context & Problem Statement

AI Hustle Co-Pilot targets a premium SaaS aesthetic comparable to Linear, Notion, and Stripe. We needed a design system that would:
1. Enforce visual consistency across all features
2. Support both light and dark themes with WCAG compliance
3. Provide a token-based system for colors, typography, spacing, elevation, and motion
4. Enable responsive layouts across phone, tablet, and desktop
5. Prevent ad-hoc styling that degrades design quality

## Decision & Rationale

We implemented a **custom Material 3 Design System** with:

### Token Categories
- **AppColors**: 38+ semantic color tokens (light + dark variants)
- **AppTypography**: Outfit (headings) + Inter (body) with calculated metrics
- **AppSpacing**: Strict 8-point grid (4dp–48dp)
- **AppRadius**: Consistent border radius scale (4dp–32dp)
- **AppElevation**: Multi-layer shadow system
- **AppAnimation**: Duration and curve presets
- **AppBreakpoints**: Responsive layout thresholds

### Design DNA Sources
- Linear: Clean functional aesthetics
- Notion: Spacious layouts, typographic hierarchy
- Stripe: Data-rich surfaces with clear hierarchy
- Raycast: Command palette patterns
- Apple HIG: Motion, spatial consistency

## Consequences

### Positive
- Zero-hardcoded-value policy ensures perfect consistency
- Theme switching is automatic via ThemeData
- New components inherently follow the design system
- Design tokens serve as executable design documentation

### Negative
- Learning curve for contributors to use tokens instead of raw values
- Token system requires maintenance as design evolves
- More verbose than raw `Colors.blue` (but dramatically more maintainable)
