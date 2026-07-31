# AI Hustle Co-Pilot — Master Design System Specification (v2.0)

> **Single Source of Truth**: Design System Version 2.0  
> **Visual Brand Architecture**: Premium Dark Blue (`#0D1B2A`) + Topographic Contour Line Wave Header + Minimal Clean Light Surface (`#FFFFFF` & `#F8FAFC`).

---

## 1. Brand Philosophy & Identity

AI Hustle Co-Pilot combines **Intelligence, Elegance, Speed, and Precision**. The application design language is inspired by leading world-class platforms including **ChatGPT, Claude, Gemini, Linear, Raycast, Notion AI, and Apple Human Interface Guidelines**.

Every interface in the application strictly adheres to:
- **Quality > Speed**: Pixel-perfect layout geometry, WCAG AAA text contrast, and 60 FPS fluid transitions.
- **Unified Branding**: Signature **Topographic Wave Header** with organic bezier curve dividers across Onboarding, Authentication, Empty States, Premium Cards, and Screen Banners.
- **Dark Blue Identity**: Deep `#0D1B2A` primary brand color replacing all legacy pink/slate palettes.

---

## 2. Master Color Architecture

### 2.1 Primary Brand Colors

| Token | Hex Code | HSL / Opacity | Purpose & Design Rationale |
|-------|----------|---------------|----------------------------|
| `primaryDarkBlue` | `#0D1B2A` | `hsl(212, 53%, 11%)` | **Primary Brand Color**: Used for wave headers, dark canvas, and primary CTAs. |
| `primaryBlue` | `#152A4D` | `hsl(217, 57%, 19%)` | **Secondary Dark Blue**: Used for dark gradient stops, dark mode cards, and elevated headers. |
| `accent` | `#3A5FA0` | `hsl(218, 47%, 43%)` | **Accent Blue**: Used for secondary interactive highlights and active tab indicators. |
| `accentCoral` | `#FF6B6B` | `hsl(0, 100%, 71%)` | **Coral Highlight**: Reserved for high-energy CTA badges, spark indicators, and notifications. |
| `background` | `#FFFFFF` | `hsl(0, 0%, 100%)` | Crisp White Canvas background. |
| `surface` | `#FFFFFF` | `hsl(0, 0%, 100%)` | Pure White Surface for cards, containers, and floating panels. |
| `surfaceVariant` | `#F8FAFC` | `hsl(210, 40%, 98%)` | Soft Light Gray container fill for form inputs, table headers, and nested panels. |
| `onSurface` | `#111827` | `hsl(221, 39%, 11%)` | Deep Charcoal primary text delivering 18.5:1 AAA contrast. |
| `onSurfaceVariant`| `#6B7280` | `hsl(220, 9%, 46%)` | Secondary body text, subheadings, and field labels. |
| `outline` | `#E5E7EB` | `hsl(220, 13%, 91%)` | Subtle 1px border stroke for card bounds and input fields. |
| `success` | `#10B981` | `hsl(160, 84%, 39%)` | Emerald Green for completed syncs, verified status, and success badges. |
| `warning` | `#F59E0B` | `hsl(38, 92%, 50%)` | Amber Yellow for pending approvals, quota alerts, and warnings. |
| `danger` | `#EF4444` | `hsl(0, 84%, 60%)` | Ruby Red for destructive actions, validation errors, and auth failures. |

---

## 3. Typography Scale (Inter)

All UI elements use the **Inter** font family with strict line height and tracking geometry.

| Style Name | Font Size | Line Height | Font Weight | Purpose |
|------------|-----------|-------------|-------------|---------|
| `Display Large` | 40.0dp | 48.0dp (1.2) | Bold (w700) | Hero headlines (Onboarding). |
| `Display Medium` | 32.0dp | 40.0dp (1.25) | Bold (w700) | Major screen titles. |
| `Heading Large` | 24.0dp | 32.0dp (1.33) | SemiBold (w600) | Screen card titles & modals. |
| `Heading Medium` | 20.0dp | 28.0dp (1.40) | SemiBold (w600) | Section headers. |
| `Body Large` | 16.0dp | 24.0dp (1.50) | Regular (w400) | Primary body text & input text. |
| `Body Medium` | 14.0dp | 20.0dp (1.43) | Regular (w400) | Secondary body copy & descriptions. |
| `Body Small` | 12.0dp | 16.0dp (1.33) | Regular (w400) | Captions & helper text. |
| `Caption` | 11.0dp | 14.0dp (1.27) | Regular (w400) | Micro metadata & timestamps. |

---

## 4. Spacing System (4px Base Grid)

All layout dimensions, margins, and padding use multiples of the **4px base grid**:

$$\text{Spacing Tokens}: [4, 8, 12, 16, 20, 24, 32, 40, 48, 64]$$

---

## 5. Border Radius & Elevation Hierarchy

### 5.1 Corner Radii
- **Cards & Panels**: `24px` (`AppRadius.large`)
- **Input Fields**: `16px` (`AppRadius.medium`)
- **Primary / Secondary Buttons**: `24px` / `pill` (`AppRadius.borderPill`)
- **Dialogs & Alert Containers**: `28px` (`AppRadius.xLarge`)
- **Bottom Sheets**: `32px` (`AppRadius.xxLarge`)

### 5.2 Elevation & Shadows
- `0dp`: Flat surface with `#E5E7EB` 1px outline stroke.
- `1dp`: Subtle card elevation (`offset: Offset(0, 2), blur: 8, opacity: 0.04`).
- `4dp`: Floating dropdowns & navigation (`offset: Offset(0, 4), blur: 16, opacity: 0.08`).
- `8dp`: Dialogs & floating modals (`offset: Offset(0, 8), blur: 24, opacity: 0.12`).

---

## 6. Component Specifications

### 6.1 Topographic Wave Header
- **Background**: Gradient from `#0D1B2A` to `#152A4D`.
- **Pattern**: `TopographicWavePainter` custom cubic bezier contour lines in `#3A5FA0` (opacity 0.12).
- **Divider**: Organic bezier curve transitioning cleanly into the white `#FFFFFF` surface below.
- **Application**: Onboarding (45% screen height), Authentication screens (28% screen height), Empty states, and Hero banners.

### 6.2 Buttons
- **Primary Button**: Filled `#0D1B2A`, height `56px`, corner radius `28px` (pill), white text (`#FFFFFF`), font weight `w600`.
- **Secondary Button**: Outlined `#FFFFFF` fill with `#E5E7EB` border stroke or Accent Coral (`#FF6B6B`).
- **Text Button / Ghost**: Minimal, `#0D1B2A` text, 0 elevation.

### 6.3 Input Fields (`AuthInputField`)
- **Fill Color**: `#F8FAFC`.
- **Height**: `56px`.
- **Corner Radius**: `16px`.
- **Label**: Above input box (`#111827`, 14px SemiBold).
- **Focus Border**: Smooth `#0D1B2A` 1.5px stroke animation.

### 6.4 Floating Bottom Navigation
- **Capsule**: Floating rounded container (`#FFFFFF` surface).
- **Shadow**: Elevation 4 soft shadow (`blur: 16, opacity: 0.08`).
- **Selected Item**: `#0D1B2A` dark blue indicator with high contrast icon & label.

---

## 7. Responsiveness & Accessibility

- **Breakpoints**: Compact (<600dp), Medium (600–840dp), Expanded (840–1200dp), Desktop (>1200dp).
- **Touch Targets**: Minimum `48x48dp` touch area for interactive icons & buttons.
- **Keyboard Safety**: Wrapped in `SingleChildScrollView` to eliminate vertical pixel overflow when soft keyboard opens.
