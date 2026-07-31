# AI Hustle Co-Pilot — Design System Master

This Flutter project uses the existing navy-and-white brand system as the
authority. UI/UX Pro Max informed the balanced bento composition, density,
accessibility, and restrained motion; its generic palette recommendation is
overridden by the approved product identity below.

## Palette

| Role | Token | Value |
| --- | --- | --- |
| Deep navy | `AppColors.primaryDarkBlue` / `deepNavy` | `#0D1B2A` |
| Navy surface | `AppColors.primaryBlue` / `navySurface` | `#152A4D` |
| Accent blue | `AppColors.secondary` | `#3A5FA0` |
| Light canvas | `AppColors.background` / `whiteSurface` | `#FFFFFF` |
| Soft surface | `AppColors.surfaceVariant` | `#F8FAFC` |
| Primary text | `AppColors.primaryText` | `#111827` |
| Secondary text | `AppColors.secondaryText` / `mutedText` | `#6B7280` |
| Border | `AppColors.outline` | `#E5E7EB` |
| Success / warning / error | semantic tokens | `#10B981` / `#F59E0B` / `#EF4444` |

Do not introduce purple, pink, rainbow, neon, or unrelated gradient treatments.

## Typography and spatial rhythm

Inter is the only typeface. Use the semantic `AppTypography` text theme. Use
4dp for micro spacing and the existing 8dp rhythm for layout. Standard page
gutter is 16dp on phones, 24dp on tablets, and 32–48dp on expanded surfaces.

Cards use `AppRadius.borderLarge` (24dp) for major surfaces and
`AppRadius.borderMedium` (16dp) for nested controls. Minimum interactive target
is 48dp.

## Composition

The app uses a content-first bento composition:

1. Personalized context.
2. One next-best action.
3. One AI Co-Pilot entry point.
4. Shortcuts connected to implemented routes.
5. Compact metrics and state-backed work sections.

Phone layouts stack content and use two-column metric/quick-action grids. Tablet
layouts use a navigation rail and two-column focus/content composition. Expanded
layouts use persistent navigation with constrained content measure.

## Shared background and motion

`AppBrandBackground` is the shared background for welcome, authentication, and
the authenticated shell. It delegates the topographic contour painter to
`WaveHeaderWidget`, includes restrained navy ambient depth, and supports a static
reduced-motion state via `MediaQuery.disableAnimations`.

Motion uses the shared `AppMotion` durations: 150ms fast, 250ms medium, and 350ms
slow. Use opacity and transform transitions only; never block access with an
entrance animation.

## Accessibility and state

Use descriptive semantics for icon-only controls, visible focus/pressed/selected
states, readable text contrast, and status text/icons in addition to color. Every
async dashboard section supports loading, empty, error, offline/cached, and
success states. Never show fabricated chart values or hard-coded user identity.

## Approved Flutter components

- `AppBrandBackground`
- `DashboardSurface` / `DashboardSectionHeader`
- `PrimaryFocusCard` / `AiCopilotCard`
- `DashboardHeaderWidget` / `DashboardMetricCard`
- `QuickActionsGrid`
- `AnalyticsChartsSection`
- `RecentProjectsList` / `RecentActivityFeed` / `AiInsightsPanel`
