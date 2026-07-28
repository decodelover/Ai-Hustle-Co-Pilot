# AI Hustle Co-Pilot — Enterprise Design Language Specification (v1.0)

> **Primary Design Authority**: `UI/UX Pro Max Design Intelligence`
> **Visual Direction**: Premium AI SaaS Blend (Linear + Notion + Stripe Dashboard + Raycast + Google Gemini + Apple HIG)

---

## 1. Color Philosophy & Palette Architecture

### 1.1 Brand Identity & Design Intent
AI Hustle Co-Pilot combines **Intelligence, Confidence, Speed, and Focus**. The color system is engineered to minimize cognitive fatigue during long productivity sessions while creating distinct visual focus for AI-generated insights, primary CTAs, and system statuses.

---

### 1.2 Light Theme Palette

| Token | Hex Code | HSL / Opacity | Purpose & Design Rationale |
|-------|----------|---------------|----------------------------|
| `primary` | `#6D28D9` | `hsl(263, 70%, 48%)` | **Deep Violet**: Represents intelligence and AI capability. High contrast against light surfaces without visual noise. |
| `onPrimary` | `#FFFFFF` | `hsl(0, 0%, 100%)` | Crisp contrast for primary button text and filled icons. |
| `secondary` | `#4F46E5` | `hsl(239, 84%, 67%)` | **Indigo Accent**: Used for secondary interactive elements, selected navigation items, and active tabs. |
| `onSecondary` | `#FFFFFF` | `hsl(0, 0%, 100%)` | Contrast text for secondary interactive surfaces. |
| `accent` | `#EC4899` | `hsl(330, 81%, 60%)` | **Electric Magenta**: Reserved exclusively for AI copilot triggers, spark indicators, and key conversion paths. |
| `onAccent` | `#FFFFFF` | `hsl(0, 0%, 100%)` | High contrast text over accent banners and glowing triggers. |
| `background` | `#F8FAFC` | `hsl(210, 40%, 98%)` | Soft Slate tint. Eliminates harsh blinding white (`#FFF`) glare for extended usage. |
| `surface` | `#FFFFFF` | `hsl(0, 0%, 100%)` | Pure elevated white surface for cards, panels, and container dialogs. |
| `surfaceVariant` | `#F1F5F9` | `hsl(210, 40%, 96%)` | Subtle grey container surface for search inputs, table headers, and nested cards. |
| `onSurface` | `#0F172A` | `hsl(222, 47%, 11%)` | Near-black Slate 900. Delivers 16.5:1 WCAG AAA text contrast. |
| `onSurfaceVariant`| `#475569` | `hsl(215, 25%, 35%)` | Secondary body text, subheadings, and field labels (5.2:1 WCAG AA). |
| `outline` | `#E2E8F0` | `hsl(214, 32%, 91%)` | Crisp 1px border stroke for card bounds and input fields. |
| `outlineVariant` | `#CBD5E1` | `hsl(213, 27%, 84%)` | Hover/focus border stroke state. |
| `success` | `#059669` | `hsl(160, 84%, 39%)` | **Emerald**: Confirms completed workflows, saved drafts, and active syncs. |
| `warning` | `#D97706` | `hsl(38, 92%, 44%)` | **Amber**: Alerts user to pending approvals, quota limits, or network degradation. |
| `danger` | `#DC2626` | `hsl(0, 72%, 51%)` | **Ruby Red**: Destructive actions, validation errors, and authentication failures. |
| `info` | `#2563EB` | `hsl(217, 91%, 60%)` | **Royal Blue**: Neutral system notifications and informational badges. |
| `skeletonStart` | `#E2E8F0` | `hsl(214, 32%, 91%)` | Base shimmer gradient starting color for 4-state loading lifecycle. |
| `skeletonEnd` | `#F8FAFC` | `hsl(210, 40%, 98%)` | Highlight shimmer gradient ending color. |

---

### 1.3 Dark Theme Palette

| Token | Hex Code | HSL / Opacity | Purpose & Design Rationale |
|-------|----------|---------------|----------------------------|
| `primary` | `#9333EA` | `hsl(271, 81%, 56%)` | Brightened Purple for dark background readability (7.8:1 contrast). |
| `onPrimary` | `#FFFFFF` | `hsl(0, 0%, 100%)` | High contrast text over primary filled buttons. |
| `secondary` | `#818CF8` | `hsl(234, 89%, 74%)` | Luminous Indigo for secondary active states. |
| `onSecondary` | `#0F172A` | `hsl(222, 47%, 11%)` | Dark slate text over luminous indigo chips/badges. |
| `accent` | `#F472B6` | `hsl(330, 85%, 70%)` | Neon Magenta for AI copilot glows and key triggers in dark mode. |
| `onAccent` | `#0F172A` | `hsl(222, 47%, 11%)` | Dark text over glowing accent containers. |
| `background` | `#090D16` | `hsl(222, 47%, 6%)` | **Deep Space Blue-Black**: Raycast/Linear-inspired dark canvas. |
| `surface` | `#111827` | `hsl(215, 28%, 12%)` | Dark Gray-Blue surface for floating panels and cards. |
| `surfaceVariant` | `#1F2937` | `hsl(215, 25%, 17%)` | Elevated surface variant for input containers and headers. |
| `onSurface` | `#F8FAFC` | `hsl(210, 40%, 98%)` | Off-white text delivering 15.8:1 contrast against `#090D16`. |
| `onSurfaceVariant`| `#94A3B8` | `hsl(215, 20%, 65%)` | Muted secondary text (6.4:1 WCAG AA). |
| `outline` | `#1F2937` | `hsl(215, 25%, 17%)` | Subtle dark border stroke separating card containers. |
| `outlineVariant` | `#374151` | `hsl(217, 19%, 27%)` | Active border highlight stroke. |
| `success` | `#10B981` | `hsl(160, 84%, 45%)` | Bright Emerald for dark mode success state. |
| `warning` | `#F59E0B` | `hsl(38, 92%, 50%)` | Bright Amber for dark mode warnings. |
| `danger` | `#EF4444` | `hsl(0, 84%, 60%)` | Crimson Red for dark mode destructive alerts. |
| `info` | `#60A5FA` | `hsl(213, 94%, 68%)` | Sky Blue for dark mode system info. |
| `skeletonStart` | `#1F2937` | `hsl(215, 25%, 17%)` | Dark shimmer start. |
| `skeletonEnd` | `#111827` | `hsl(215, 28%, 12%)` | Dark shimmer end. |

---

### 1.4 Chart Palette (Data Visualization)
Designed for high distinction across both Light & Dark modes:
- `chart1`: `#6D28D9` (Primary Violet)
- `chart2`: `#059669` (Emerald Green)
- `chart3`: `#2563EB` (Royal Blue)
- `chart4`: `#D97706` (Amber Yellow)
- `chart5`: `#EC4899` (Electric Pink)

---

## 2. Typography System

### 2.1 Font Pairings & Scale
- **Primary Typeface**: `Inter` / `Roboto` (Clean, highly legible geometric sans-serif for UI and body text).
- **Monospace Typeface**: `JetBrains Mono` / `Fira Code` (For prompt logs, code blocks, metrics, and API outputs).

| Style Name | Font Weight | Font Size | Line Height | Tracking (Letter Spacing) | Target Usage |
|------------|-------------|-----------|-------------|---------------------------|--------------|
| `displayLarge` | Bold (700) | 40sp | 48sp | -0.5px | Hero metric banners, major onboarding titles |
| `displayMedium` | SemiBold (600) | 32sp | 40sp | -0.25px | Screen primary section titles |
| `displaySmall` | SemiBold (600) | 28sp | 36sp | 0.0px | Secondary hero headings |
| `headlineLarge` | SemiBold (600) | 24sp | 32sp | 0.0px | Dashboard section headers, modal titles |
| `headlineMedium` | Medium (500) | 20sp | 28sp | 0.15px | Card titles, group headers |
| `headlineSmall` | Medium (500) | 18sp | 24sp | 0.15px | Sub-card headers, list item titles |
| `titleLarge` | Medium (500) | 16sp | 22sp | 0.1px | App bar titles, navigation items |
| `titleMedium` | Medium (500) | 14sp | 20sp | 0.1px | Table header labels, form section labels |
| `titleSmall` | Medium (500) | 12sp | 16sp | 0.1px | Chip labels, dense table headers |
| `bodyLarge` | Regular (400) | 16sp | 24sp | 0.5px | Long-form articles, prompt responses |
| `bodyMedium` | Regular (400) | 14sp | 20sp | 0.25px | Default paragraph body text, form input text |
| `bodySmall` | Regular (400) | 12sp | 16sp | 0.4px | Helper text, secondary descriptions |
| `labelLarge` | Medium (500) | 14sp | 20sp | 0.1px | Primary & secondary button text |
| `labelMedium` | Medium (500) | 12sp | 16sp | 0.5px | Badge text, tab bar labels |
| `labelSmall` | Medium (500) | 10sp | 14sp | 0.5px | Micro tags, timestamp indicators |

---

## 3. Spatial & Grid System (8-Point Spatial Grid)

All layouts, padding, margins, gaps, and component sizes follow a strict **8-point spatial grid** (with a `4dp` micro-token for compact elements).

| Token Name | Size | Concrete Usage Guidelines |
|------------|------|---------------------------|
| `space4` | 4dp | Micro gap between icon and text inside a badge; pill border padding. |
| `space8` | 8dp | Inner content padding for chips; gap between dense horizontal icons. |
| `space12` | 12dp | Compact card internal padding; vertical gap between form fields. |
| `space16` | 16dp | **Standard Screen Edge Margin**; default card internal padding. |
| `space20` | 20dp | Medium card internal padding; bottom sheet header margin. |
| `space24` | 24dp | Major section spacing; gap between stacked dashboard widgets. |
| `space32` | 32dp | Large hero section gap; vertical space above primary action buttons. |
| `space40` | 40dp | Outer dialog margin; desktop sidebar section separation. |
| `space48` | 48dp | **Minimum Accessibility Touch Target Height**; floating bar offset. |
| `space64` | 64dp | Empty state vertical illustration spacing. |
| `space80` | 80dp | Hero header top padding; major page hero spacing. |
| `space96` | 96dp | Maximum page container padding on tablet/desktop views. |

---

## 4. Border Radius System

| Token Name | Radius | Concrete Usage Guidelines |
|------------|--------|---------------------------|
| `radiusSmall` | 6dp | Tooltips, micro badges, context menu items, checkbox containers. |
| `radiusMedium` | 10dp | Input text fields, dropdown menus, action buttons, table rows. |
| `radiusLarge` | 16dp | **Standard Card Container**; modal dialogs, bottom sheets, alert panels. |
| `radiusXLarge` | 24dp | Floating action bars, major feature callout cards, AI chat bubbles. |
| `radiusPill` | 999dp | Search bars, tag chips, status badges, avatar online indicators. |
| `radiusCircular`| 50% | Circular action buttons, avatar images, step process indicators. |

---

## 5. Material 3 Elevation Architecture

| Level | Surface Tint / Shadow Depth | Concrete Component Allocation |
|-------|-----------------------------|-------------------------------|
| `Level 0` | 0dp (Flat, 1px border stroke) | Inset panels, list items, embedded form inputs, default page canvas. |
| `Level 1` | 1dp - 2dp elevation shadow | Standard content cards, data table containers, top AppBars. |
| `Level 2` | 3dp - 4dp elevation shadow | Hovered cards, search filter drawers, dropdown popovers. |
| `Level 3` | 6dp - 8dp elevation shadow | Floating Action Buttons (FAB), sticky action bars, snackbars. |
| `Level 4` | 12dp - 16dp elevation shadow | Modal dialogs, date pickers, centered confirmation alerts. |
| `Level 5` | 24dp elevation shadow | Full-screen modal sheets, primary app navigation drawers. |

---

## 6. Shadow System

### 6.1 Light Theme Shadows
- `shadowSm`: `0px 1px 2px rgba(15, 23, 42, 0.05)` (Subtle card border grounding).
- `shadowMd`: `0px 4px 6px -1px rgba(15, 23, 42, 0.08), 0px 2px 4px -2px rgba(15, 23, 42, 0.04)` (Dropdowns & popovers).
- `shadowLg`: `0px 10px 15px -3px rgba(15, 23, 42, 0.10), 0px 4px 6px -4px rgba(15, 23, 42, 0.05)` (Modals & elevated sheets).
- `shadowGlow`: `0px 0px 20px rgba(109, 40, 217, 0.25)` (Exclusive AI Copilot active glow).

### 6.2 Dark Theme Shadows
- `shadowDarkSm`: `0px 1px 2px rgba(0, 0, 0, 0.40)`
- `shadowDarkMd`: `0px 4px 12px rgba(0, 0, 0, 0.50)`
- `shadowDarkLg`: `0px 12px 24px rgba(0, 0, 0, 0.70)`
- `shadowDarkGlow`: `0px 0px 24px rgba(147, 51, 234, 0.35)` (Dark mode AI Copilot glow).

---

## 7. Motion & Animation Language

### 7.1 Motion Principles
1. **Purposeful & Spatial**: Animations must clarify state transitions and originate from the user touch point.
2. **Fast Exits, Smooth Enters**: Elements enter in `250ms` with decelerate curves, and exit in `150ms` with accelerate curves.
3. **Zero Layout Thrashing**: Never animate layout dimensions (`width`/`height`); animate transform (`scale`/`translate`) and `opacity`.

### 7.2 Durations & Easing Curves
- **Fast Duration** (`150ms`): Button press states, checkbox toggles, tooltip fades.
- **Medium Duration** (`250ms`): Card expands, dialog pops, tab switches.
- **Slow Duration** (`350ms`): Page route transitions, bottom sheet slides.
- **Standard Easing**: `Cubic(0.2, 0.0, 0.0, 1.0)` (Material Emphasized Decelerate).
- **Spring Easing**: `Cubic(0.34, 1.56, 0.64, 1.0)` (Subtle pop feedback for AI triggers).

---

## 8. Iconography & Visual Assets

- **Primary Icon Family**: `Icons.rounded` (Material Rounded) or `Lucide` / `Heroicons` vector stroke icons.
- **Rules**:
  - All interactive icon buttons must measure at least **48x48dp** touch target area.
  - Icon stroke thickness: `2.0dp` (standard), `1.5dp` (dense table headers).
  - Categorization:
    - *Navigation*: `Icons.dashboard_rounded`, `Icons.folder_rounded`, `Icons.settings_rounded`
    - *Actions*: `Icons.add_rounded`, `Icons.edit_rounded`, `Icons.delete_outline_rounded`
    - *AI Features*: `Icons.auto_awesome_rounded`, `Icons.psychology_rounded`, `Icons.bolt_rounded`
    - *Status*: `Icons.check_circle_rounded`, `Icons.warning_amber_rounded`, `Icons.error_outline_rounded`

---

## 9. Illustration Style & 4-State UI Lifecycle

### 9.1 4-State Lifecycle Rule
Every screen must handle and cleanly present all four lifecycle states:
1. **Loading State**: Customized skeleton shimmering loaders matching the exact geometric bounds of target content.
2. **Empty State**: Contextually relevant, actionable, and illustrative empty states with a primary CTA button.
3. **Error State**: User-friendly error messaging with interactive retry triggers.
4. **Success State**: Smooth content presentation enhanced by subtle micro-animations.

---

## 10. Component Rules & Styling Standards

### 10.1 Buttons (`AppButton`)
- **Primary Button**: Filled violet background (`primary`), white text (`onPrimary`), `10dp` radius, height `48dp`, subtle press scale animation (`0.98x`).
- **Secondary Button**: Outlined stroke (`outline`), surface background, primary text.
- **Ghost/Tertiary Button**: Transparent background, violet hover state, no border.

### 10.2 Inputs (`AppTextField`)
- Height `48dp`, `10dp` radius, `1px` border (`outline`), focused border `2px` (`primary`).
- Error state: `danger` border stroke with inline error message below field (`bodySmall`, `danger`).

### 10.3 Cards (`AppCard`)
- `16dp` radius, `1px` border stroke (`outline`), `Level 1` shadow, padding `16dp` or `20dp`.

### 10.4 Modals & Sheets (`AppDialog` / `AppBottomSheet`)
- `24dp` top radius for bottom sheets; `16dp` radius for centered dialogs. Scrim overlay `#000000` with `50%` opacity.

---

## 11. Accessibility (WCAG AA Compliance)

1. **Contrast Ratios**:
   - Normal text (`body`, `label`): Minimum **4.5:1** contrast against surface.
   - Large text (`headline`, `display`): Minimum **3.0:1** contrast against surface.
2. **Touch Targets**: Minimum **48x48dp** padding box for all clickable icons and buttons.
3. **Dynamic Text & Screen Readers**: All typography scales gracefully with system accessibility text scale up to `200%`.
4. **Semantics**: Every image and icon button has a descriptive `semanticsLabel`.

---

## 12. Responsive Strategy & Breakpoints

| Breakpoint Target | Width Range | Columns | Margin | Spacing Strategy |
|-------------------|-------------|---------|--------|------------------|
| **Compact (Phones)** | `< 600dp` | 4 | 16dp | Bottom navigation, single-column scrollable cards |
| **Medium (Tablets / Foldables)** | `600dp - 840dp` | 8 | 24dp | Navigation rail, 2-column grid cards |
| **Expanded (Desktop / Laptops)** | `> 840dp` | 12 | 32dp | Fixed left sidebar, multi-column dashboard grid |

---

## 13. Reusable Design Tokens in Flutter

Defined under `lib/core/theme/app_colors.dart`, `app_spacing.dart`, `app_radii.dart`, and `app_typography.dart`.

### Example Spatial Tokens (`AppSpacing`):
```dart
class AppSpacing {
  static const double space4 = 4.0;
  static const double space8 = 8.0;
  static const double space12 = 12.0;
  static const double space16 = 16.0;
  static const double space20 = 20.0;
  static const double space24 = 24.0;
  static const double space32 = 32.0;
  static const double space40 = 40.0;
  static const double space48 = 48.0;
  static const double space64 = 64.0;
  static const double space80 = 80.0;
  static const double space96 = 96.0;
}
```

---

## 14. Naming Conventions for Future Widgets

To ensure codebase consistency across 100+ screens:
1. **Component Primitives**: Prefix with `App` (`AppButton`, `AppCard`, `AppTextField`, `AppAvatar`, `AppBadge`).
2. **Feature Presentation Widgets**: `<Feature><Descriptor>Widget` (e.g., `AuthHeaderWidget`, `ProposalCardWidget`).
3. **Feature Screens**: `<Feature><Action>Screen` (e.g., `SignInScreen`, `DashboardHomeScreen`).
