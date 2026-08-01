<!-- Project-aware context for the 21st CLI. Canonical product rules live in DESIGN_LANGUAGE.md. -->
# AI Hustle Co-Pilot Design Context

## Product

- Flutter AI productivity SaaS for Android and iOS.
- Visual character: cinematic navy depth, topographic contours, quiet precision,
  layered neutral surfaces, and contextual AI guidance.
- Canonical authority: `DESIGN_LANGUAGE.md` and `lib/core/theme/`.

## Required sources

- Tokens: `lib/core/theme/app_*.dart`
- Components: `lib/core/design_system/`
- Shared brand canvas: `lib/shared/widgets/app_brand_background.dart`
- Engineering rules: `.agents/AGENTS.md`

## Must

- Use project tokens and existing Flutter primitives.
- Preserve Riverpod, GoRouter, Supabase authentication, validation, and clean
  architecture contracts.
- Maintain 48dp targets, WCAG AA contrast, semantics, visible focus, reduced
  motion, and all loading/error/success states.
- Keep onboarding, authentication, shell, and dashboard visually continuous.

## Avoid

- React/shadcn code in this Flutter project.
- Generic Material login templates.
- Raw feature-local colors, mixed icon styles, or decorative effects without a
  hierarchy purpose.
- Changes to controllers, providers, repositories, use cases, routes, or data
  flow during visual redesign work.

## Durable direction

Authentication uses story-led onboarding and focused single-task forms.
Compact layouts prioritize one clear action; wider layouts pair the form with a
contextual product narrative. Brand moments use navy topographic fields, while
forms use calm standard or dark surfaces with restrained translucency.
