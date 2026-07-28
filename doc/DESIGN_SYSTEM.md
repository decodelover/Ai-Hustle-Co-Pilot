# AI Hustle Co-Pilot — Design System Documentation

> **Design System Version**: 1.0.0
> **Design Authority**: UI/UX Pro Max Design Intelligence
> **Visual DNA**: Premium AI SaaS (Linear + Notion + Stripe + Raycast + Apple HIG)

---

## Table of Contents

- [Design Philosophy](#design-philosophy)
- [Color System](#color-system)
- [Typography System](#typography-system)
- [Spacing System](#spacing-system)
- [Border Radius System](#border-radius-system)
- [Elevation & Shadows](#elevation--shadows)
- [Motion System](#motion-system)
- [Responsive Breakpoints](#responsive-breakpoints)
- [Component Library](#component-library)
- [4-State UI Lifecycle](#4-state-ui-lifecycle)
- [Accessibility](#accessibility)
- [Usage Guidelines](#usage-guidelines)

---

## Design Philosophy

AI Hustle Co-Pilot's design system is engineered around four pillars:

| Pillar | Description |
|--------|-------------|
| **Intelligence** | The interface communicates AI-powered capabilities through visual hierarchy and purposeful accent colors |
| **Confidence** | Premium typography, consistent spacing, and polished transitions build trust |
| **Speed** | Minimal cognitive load, clear navigation paths, and responsive feedback enable fast workflows |
| **Focus** | Muted backgrounds with strategic color highlights direct attention to what matters |

### Design DNA

The visual language draws inspiration from:
- **Linear** — Clean, functional, developer-friendly aesthetics
- **Notion** — Spacious layouts, typographic hierarchy
- **Stripe Dashboard** — Data-rich surfaces with clear visual hierarchy
- **Raycast** — Command palette patterns, keyboard-first interaction
- **Apple HIG** — Attention to motion, haptics, and spatial consistency

---

## Color System

### Token Architecture

All colors are accessed via `AppColors` — **never hardcode hex values**.

```dart
import 'package:ai_hustle_copilot/core/design_system/tokens/app_colors.dart';

// ✅ Correct
Container(color: AppColors.primary)

// ❌ Never do this
Container(color: Color(0xFF6D28D9))
```

### Light Theme Palette

| Token | Hex | Purpose |
|-------|-----|---------|
| `primary` | `#6D28D9` | Deep Violet — AI capability, primary CTAs |
| `secondary` | `#4F46E5` | Indigo — Secondary interactions, active tabs |
| `accent` | `#EC4899` | Electric Magenta — AI triggers, conversion paths |
| `background` | `#F8FAFC` | Soft Slate — Eliminates white glare |
| `surface` | `#FFFFFF` | Pure White — Elevated cards and panels |
| `surfaceVariant` | `#F1F5F9` | Subtle Grey — Nested containers |
| `onSurface` | `#0F172A` | Near-black — Primary text (16.5:1 contrast) |
| `onSurfaceVariant` | `#475569` | Slate — Secondary text (5.2:1 contrast) |
| `outline` | `#E2E8F0` | Light border strokes |
| `success` | `#059669` | Emerald — Confirmations, active syncs |
| `warning` | `#D97706` | Amber — Pending, degradation |
| `danger` | `#DC2626` | Ruby Red — Errors, destructive actions |
| `info` | `#2563EB` | Royal Blue — Informational badges |

### Dark Theme Palette

| Token | Hex | Purpose |
|-------|-----|---------|
| `primary` | `#9333EA` | Brightened Purple — Dark bg readability |
| `secondary` | `#818CF8` | Luminous Indigo — Active states |
| `accent` | `#F472B6` | Neon Magenta — AI glows on dark |
| `background` | `#030712` | Near-black — Deep dark base |
| `surface` | `#111827` | Dark Grey — Elevated containers |
| `surfaceVariant` | `#1F2937` | Grey-800 — Nested surfaces |
| `onSurface` | `#F1F5F9` | Near-white — Primary text |

---

## Typography System

### Font Pairing

| Role | Font | Weight Range | Usage |
|------|------|--------------|-------|
| **Headings** | Outfit | 600–700 | Page titles, section headers, hero text |
| **Body** | Inter | 400–500 | Paragraphs, labels, descriptions, UI text |

### Type Scale

| Token | Size | Line Height | Weight | Usage |
|-------|------|-------------|--------|-------|
| `displayLarge` | 32sp | 1.25 | Outfit 700 | Hero headings, onboarding titles |
| `displayMedium` | 28sp | 1.29 | Outfit 600 | Section headers |
| `headlineLarge` | 24sp | 1.33 | Outfit 600 | Card titles, modal headers |
| `headlineMedium` | 20sp | 1.4 | Outfit 600 | Subsection headers |
| `titleLarge` | 18sp | 1.33 | Inter 600 | List item titles |
| `titleMedium` | 16sp | 1.5 | Inter 500 | Toolbar titles, tab labels |
| `bodyLarge` | 16sp | 1.5 | Inter 400 | Primary body text |
| `bodyMedium` | 14sp | 1.43 | Inter 400 | Standard body text |
| `bodySmall` | 12sp | 1.33 | Inter 400 | Captions, metadata |
| `labelLarge` | 14sp | 1.43 | Inter 500 | Button text, input labels |
| `labelMedium` | 12sp | 1.33 | Inter 500 | Badges, chip text |
| `labelSmall` | 10sp | 1.6 | Inter 500 | Overlines, status indicators |

### Usage

```dart
import 'package:ai_hustle_copilot/core/design_system/tokens/app_typography.dart';

Text(
  'Dashboard',
  style: AppTypography.headlineLarge,
)
```

---

## Spacing System

### 8-Point Grid

All spacing values are multiples of 8dp, ensuring consistent rhythm:

| Token | Value | Common Usage |
|-------|-------|-------------|
| `xxs` | 4dp | Icon-to-label gap, tight padding |
| `xs` | 8dp | Inner padding, compact spacing |
| `sm` | 12dp | Small padding, list item spacing |
| `md` | 16dp | Standard padding, section gaps |
| `lg` | 24dp | Section separation, card padding |
| `xl` | 32dp | Major section breaks |
| `xxl` | 40dp | Page-level margins |
| `xxxl` | 48dp | Hero spacing, large separators |

### Usage

```dart
import 'package:ai_hustle_copilot/core/design_system/tokens/app_spacing.dart';

Padding(
  padding: EdgeInsets.all(AppSpacing.md),  // 16dp
  child: Column(
    spacing: AppSpacing.sm,  // 12dp gap
    children: [...],
  ),
)
```

---

## Border Radius System

| Token | Value | Usage |
|-------|-------|-------|
| `none` | 0dp | No rounding |
| `xs` | 4dp | Badges, small chips |
| `sm` | 8dp | Buttons, inputs |
| `md` | 12dp | Cards, panels |
| `lg` | 16dp | Modals, dialogs |
| `xl` | 20dp | Bottom sheets |
| `xxl` | 24dp | Large containers |
| `full` | 999dp | Circular elements |

### Usage

```dart
import 'package:ai_hustle_copilot/core/design_system/tokens/app_radius.dart';

Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(AppRadius.md),  // 12dp
  ),
)
```

---

## Elevation & Shadows

### Shadow Levels

| Level | Usage | Description |
|-------|-------|-------------|
| `none` | Flat elements | No shadow |
| `xs` | Subtle lift | Hover states, selection indicators |
| `sm` | Cards | Standard card elevation |
| `md` | Dropdowns | Floating menus, tooltips |
| `lg` | Modals | Dialog overlays |
| `xl` | Sheets | Bottom sheets, full-screen overlays |

---

## Motion System

### Duration Tokens

| Token | Duration | Usage |
|-------|----------|-------|
| `instant` | 100ms | Micro-feedback (hover, press) |
| `fast` | 200ms | State changes, toggles |
| `normal` | 300ms | Page transitions, card reveals |
| `slow` | 400ms | Complex animations |
| `deliberate` | 500ms | Emphasis animations |

### Curve Tokens

| Token | Curve | Usage |
|-------|-------|-------|
| `standard` | `easeInOut` | Default transitions |
| `decelerate` | `easeOut` | Elements entering view |
| `accelerate` | `easeIn` | Elements leaving view |
| `bounce` | `elasticOut` | Playful emphasis |
| `spring` | Custom spring | Natural movement |

---

## Responsive Breakpoints

| Breakpoint | Width | Layout Adaptation |
|------------|-------|-------------------|
| **Mobile** | < 600dp | Bottom navigation, 1 column, full-width cards |
| **Tablet** | 600–1199dp | Navigation rail, 2 columns, constrained width |
| **Desktop** | 1200–1919dp | Sidebar navigation, 3 columns, expanded panels |
| **UltraWide** | ≥ 1920dp | Wide sidebar, 4 columns, dashboard-optimized |

### Usage

```dart
import 'package:ai_hustle_copilot/core/design_system/tokens/app_breakpoints.dart';

Widget build(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;

  if (AppBreakpoints.isMobile(width)) {
    return MobileLayout();
  } else if (AppBreakpoints.isTablet(width)) {
    return TabletLayout();
  } else {
    return DesktopLayout();
  }
}
```

---

## Component Library

### Core Components

| Component | File | Description |
|-----------|------|-------------|
| **AppTextField** | `inputs/app_text_field.dart` | Themed text input with validation, prefix/suffix |
| **AppLoadingIndicator** | `loading/app_loading_indicator.dart` | Branded loading spinner |
| **AppSkeleton** | `loading/app_skeleton.dart` | Shimmer skeleton loader |
| **AppEmptyState** | `feedback/app_empty_state.dart` | Empty state with illustration and CTA |
| **AppErrorState** | `feedback/app_error_state.dart` | Error display with retry action |
| **AppSuccessState** | `feedback/app_success_state.dart` | Success confirmation view |
| **AppSnackBar** | `feedback/app_snack_bar.dart` | Themed notification snack bar |
| **AppResponsiveContainer** | `layout/app_responsive_container.dart` | Breakpoint-aware container |

### Auth Components

| Component | Description |
|-----------|-------------|
| **SocialLoginButtons** | Google + GitHub OAuth with authentic brand icons |
| **AuthHeaderWidget** | Branded auth screen header |
| **PasswordStrengthWidget** | Real-time password strength indicator |
| **OrDividerWidget** | "or" separator between auth methods |
| **AppAuthBackground** | Animated gradient background with particle effects |

### Dashboard Components

| Component | Description |
|-----------|-------------|
| **DashboardMetricCard** | Data-driven metric tile with trend indicators |
| **AiInsightsPanel** | AI insight cards with confidence scoring |
| **QuickActionsGrid** | Contextual action tiles |
| **RecentProjectsList** | Pipeline overview with status badges |
| **RecentActivityFeed** | Time-ordered activity stream |

---

## 4-State UI Lifecycle

Every screen **must** implement all four states:

```
┌──────────┐     ┌──────────┐     ┌──────────┐     ┌──────────┐
│ LOADING  │ ──▶ │  EMPTY   │ OR  │  ERROR   │ OR  │ SUCCESS  │
│          │     │          │     │          │     │          │
│ Skeleton │     │ CTA +    │     │ Message  │     │ Content  │
│ Shimmer  │     │ Guidance │     │ + Retry  │     │ + Anim   │
└──────────┘     └──────────┘     └──────────┘     └──────────┘
```

| State | Requirements |
|-------|-------------|
| **Loading** | Geometry-matched skeleton shimmer matching the success layout |
| **Empty** | Contextual illustration, descriptive text, actionable CTA button |
| **Error** | User-friendly message (never raw exceptions), retry button, error icon |
| **Success** | Smooth content reveal with subtle micro-animations |

---

## Accessibility

### Requirements

| Requirement | Standard | Implementation |
|-------------|----------|----------------|
| **Touch Targets** | ≥ 48×48 dp | All interactive elements |
| **Text Contrast** | WCAG AA (4.5:1) | Primary text: 16.5:1, Secondary: 5.2:1 |
| **Semantic Labels** | All interactive elements | `Semantics()` wrapper |
| **Focus Order** | Logical tab order | `FocusTraversalGroup` |
| **Screen Reader** | Full VoiceOver/TalkBack | Semantic annotations |

---

## Usage Guidelines

### Do ✅

- Use design tokens for all visual properties
- Follow the 8-point spacing grid
- Implement all 4 UI lifecycle states
- Use `const` constructors for widgets
- Test with both light and dark themes
- Test across all responsive breakpoints

### Don't ❌

- Hardcode colors, sizes, or spacing values
- Use `Colors.blue`, `Colors.red` — always use `AppColors`
- Use `EdgeInsets.all(16)` — use `EdgeInsets.all(AppSpacing.md)`
- Skip loading or error states
- Ignore dark mode compatibility
- Use non-token font sizes or weights
