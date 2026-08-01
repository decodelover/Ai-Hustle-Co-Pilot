# AI Hustle Co-Pilot — Product Design Language

**Version:** 3.0
**Status:** Canonical
**Applies to:** Onboarding, authentication, authenticated shell, dashboard, and future product surfaces
**Implemented reference:** `lib/features/dashboard/presentation/`

This document replaces the former `DESIGN_LANGUAGE.md` and
`design_structure.md`. It records the design language used by the redesigned
dashboard and is the single product-level visual authority for future UI work.

The Flutter implementation remains the final authority for token values:

- `lib/core/theme/app_colors.dart`
- `lib/core/theme/app_typography.dart`
- `lib/core/theme/app_spacing.dart`
- `lib/core/theme/app_radius.dart`
- `lib/core/theme/app_elevation.dart`
- `lib/core/theme/app_shadows.dart`
- `lib/core/theme/app_motion.dart`
- `lib/core/theme/app_breakpoints.dart`

Do not introduce raw colors, spacing, radii, elevations, or motion values in a
feature when an equivalent token exists.

---

## 1. Product Character

AI Hustle Co-Pilot is a premium AI operating system for independent work. Its
interface should communicate intelligence, confidence, momentum, and calm.

The visual character is:

- **Cinematic navy depth:** deep blue brand surfaces create focus and make AI
  interactions feel distinctive.
- **Quiet precision:** white and soft-neutral work surfaces keep dense product
  information readable.
- **Layered, not ornamental:** borders, shadows, translucency, and gradients
  establish hierarchy. They are never added without a structural purpose.
- **Human and contextual:** the product greets the user, explains what changed,
  and recommends a useful next action.
- **Modern native utility:** compact enough for serious work, spacious enough
  for touch, and never reminiscent of a stock Flutter template.

Reference qualities include the clarity of Linear and Vercel, the composure of
Apple interfaces, and the contextual intelligence of leading AI workspaces.
These are quality benchmarks, not layouts to copy.

---

## 2. Core Visual Signature

### 2.1 Navy-to-light composition

The product combines a deep navy identity layer with a quiet light working
canvas. Navy establishes brand and focus; light surfaces carry detailed work.

Primary branded surfaces use a top-left to bottom-right gradient:

`AppColors.primaryDarkBlue` → `AppColors.primaryBlue`

The dashboard welcome hero, onboarding header, AI focus surfaces, and primary
brand moments may use this treatment. Ordinary content cards must not repeat
the full gradient.

### 2.2 Topographic contours

Thin, low-opacity contour lines represent exploration, progress, and connected
intelligence. They appear only inside major navy brand fields.

Rules:

- Keep contours subtle enough that text remains dominant.
- Use `AppColors.onPrimary` with restrained opacity.
- Never place the pattern behind dense body copy or data charts.
- Use the shared painters/background components instead of creating a new
  contour style per screen.

### 2.3 Ambient light

Soft radial blue illumination may sit behind or within a major brand surface.
It provides depth without becoming neon decoration. Coral is a momentary spark,
not an ambient background color.

### 2.4 Surface hierarchy

Use three surface roles:

1. **Brand surface:** navy gradient, high-contrast white content, reserved for
   heroes and high-priority AI moments.
2. **Standard surface:** white or dark elevated surface with a quiet border and
   low elevation.
3. **Subtle surface:** soft neutral fill used for nested cards, featured command
   tiles, and grouped metadata.

Avoid stacking more than two bordered surfaces. When hierarchy is already clear
through spacing, do not add another card.

---

## 3. Color System

### 3.1 Brand and light-theme tokens

| Token | Value | Role |
|---|---:|---|
| `primaryDarkBlue` | `#0D1B2A` | Deep brand canvas, primary actions, hero base |
| `primaryBlue` | `#152A4D` | Elevated navy and gradient end |
| `secondary` / `accent` | `#3A5FA0` | Interactive blue, chart emphasis, AI accents |
| `accentCoral` | `#FF6B6B` | Sparse energy signal, notifications, hero score |
| `background` | `#FFFFFF` | Main light canvas |
| `surface` | `#FFFFFF` | Primary cards and panels |
| `surfaceVariant` | `#F8FAFC` | Nested and quiet surfaces |
| `onSurface` | `#111827` | Primary text |
| `onSurfaceVariant` | `#6B7280` | Secondary text and metadata |
| `outline` | `#E5E7EB` | Default borders and dividers |
| `outlineVariant` | `#CBD5E1` | Active or emphasized borders |
| `success` | `#10B981` | Positive progress and healthy state |
| `warning` | `#F59E0B` | Review, pending, or attention state |
| `danger` | `#EF4444` | Failure and destructive state |

### 3.2 Dark-theme tokens

| Token | Value | Role |
|---|---:|---|
| `darkBackground` | `#0D1B2A` | Main dark canvas |
| `darkSurface` | `#152A4D` | Primary dark card surface |
| `darkSurfaceVariant` | `#1E3A5F` | Nested or elevated dark surface |
| `darkPrimary` | `#3A5FA0` | Primary dark-mode interaction |
| `darkSecondary` | `#60A5FA` | Luminous secondary interaction |
| `darkAccent` | `#FF6B6B` | Sparse dark-mode energy signal |
| `darkOnSurface` | `#F8FAFC` | Primary dark-mode text |
| `darkOnSurfaceVariant` | `#94A3B8` | Secondary dark-mode text |
| `darkOutline` | `#1E3A5F` | Default dark border |
| `darkOutlineVariant` | `#2E4A7F` | Active dark border |

### 3.3 Color discipline

- Never add feature-local hex values.
- Functional color must be paired with a label, icon, shape, or position.
- Coral is limited to emphasis, urgency, or an AI spark. It is not a general
  button color.
- Charts use the existing `chart1`–`chart5` tokens and must remain readable
  without color alone.
- Text and controls must meet WCAG AA contrast in both themes.

---

## 4. Typography

Inter is the product typeface. Fira Code is reserved for code and tabular
technical content. Typography creates hierarchy through size, weight, spacing,
and contrast—not through multiple font families.

| Role | Token | Use |
|---|---|---|
| Product hero | `displayMedium` / `displaySmall` | Personalized greetings and major onboarding statements |
| Screen title | `headlineLarge` | Primary screen identity |
| Section title | `headlineSmall` | Dashboard and workspace sections |
| Card title | `titleLarge` / `titleMedium` | Actions, projects, insights |
| Standard copy | `bodyLarge` / `bodyMedium` | Explanations and user-facing guidance |
| Supporting copy | `bodySmall` | Metadata and secondary descriptions |
| Controls | `labelLarge` / `labelMedium` | Buttons, filters, status controls |
| Eyebrow | `labelSmall` | Short category labels with increased tracking |

Rules:

- Headlines normally use weights 600–700.
- Body copy normally uses weight 400 and a line height of at least 1.4.
- Data values may use tighter tracking but must not sacrifice legibility.
- Do not use body text below 12sp.
- Keep desktop text measure near 60–75 characters per line.

---

## 5. Spacing, Shape, and Elevation

### 5.1 Spacing rhythm

Use `AppSpacing` exclusively. The system uses a 4dp micro step within an
8dp-centered rhythm:

`4, 8, 12, 16, 20, 24, 32, 40, 48, 64, 80, 96`

Common assignments:

- 4–8dp: inline icon, label, and metadata relationships.
- 12–16dp: compact card gaps and inner padding.
- 20–24dp: normal card padding and section separation.
- 32–48dp: hero and high-level layout breathing room.
- 48dp: minimum interactive target.
- 64–96dp: page-level or safe-area separation.

### 5.2 Radius hierarchy

| Token | Value | Use |
|---|---:|---|
| `extraSmall` | 4dp | Micro indicators only |
| `small` | 8dp | Compact internal geometry |
| `medium` | 16dp | Icon wells, inputs, controls |
| `large` | 24dp | Standard cards and panels |
| `xLarge` | 28dp | Heroes and major feature surfaces |
| `xxLarge` | 32dp | Bottom sheets |
| `pill` | 999dp | Filters, badges, progress tracks, compact CTAs |

### 5.3 Elevation

- Resting cards use `AppElevation.level1` or the equivalent small shadow.
- Interactive hover uses the medium shadow and a very small scale lift.
- Dialogs and sheets use levels 4–5.
- Navy heroes use a broad, low-opacity grounding shadow rather than a tall
  Material elevation.
- Borders remain visible at rest; shadow alone must not define a card boundary.

---

## 6. Iconography

The dashboard uses Cupertino outline icons as its premium, consistent visual
language. Existing screens may use carefully matched rounded Material icons,
but a single component or navigation group must not mix icon families.

Rules:

- Prefer outline icons for navigation and normal actions.
- Use filled variants only for selected, saved, or strongly active states.
- Icons must use existing size tokens or the established 16/20/24dp rhythm.
- Icon-only buttons require a tooltip and semantic label.
- Do not use emoji as interface icons.
- Decorative icons are excluded from semantics when adjacent text already
  communicates the same meaning.

---

## 7. Dashboard Information Architecture

The authenticated dashboard is ordered by user intent:

1. **Welcome hero:** identity, date, plan, productivity score, credits, and the
   primary project action.
2. **Next best action:** one contextual recommendation from existing dashboard
   state.
3. **AI Co-Pilot entry:** a direct path into contextual AI work.
4. **AI Command Center:** seven clear launch points for chat, projects,
   workspace, documents, automation, marketplace, and analytics.
5. **KPI layer:** compact values with trend labels and restrained sparklines.
6. **Analytics:** readable productivity trend with timeframe controls and a
   text summary.
7. **Recent projects:** progress, status, last activity, tags, and AI health.
8. **AI insights:** prioritized recommendations with impact and explicit
   actions.
9. **Recent activity:** a calm chronological timeline.

The shell owns the floating AI assistant. Individual dashboard sections must
not introduce a competing floating action button.

---

## 8. Component Language

### 8.1 Welcome hero

- Use the navy brand gradient and topographic contours.
- Place identity and workspace context first.
- Keep one white pill-shaped primary CTA.
- Put productivity score inside a translucent bordered panel.
- Use coral only for the score progress ring or a similarly rare spark.

### 8.2 Command tiles

- Use a consistent grid and equal card geometry.
- Each tile contains an icon well, title, short outcome-oriented description,
  and direction indicator.
- Featured AI tiles may use a navy icon gradient; other tiles use a quiet blue
  tint.
- The whole tile is interactive and exposes hover, focus, and pressed states.

### 8.3 KPI cards

- Lead with the value, not decoration.
- Always show the metric name as visible text.
- Pair positive/negative trends with directional icons and text.
- Sparklines are low-opacity supporting signals and never replace exact values.

### 8.4 Projects

- Provide a recognizable cover or monogram.
- Show status in text and color.
- Show exact progress numerically beside the progress indicator.
- Keep last activity visible.
- Show AI health and tags only when real state provides them.

### 8.5 Insights and activity

- Insights use type, priority, impact, description, and one clear action.
- Activity uses a chronological line, category icon, title, description, and
  relative timestamp.
- Empty states explain what will appear and how the user can create it.

### 8.6 Loading and errors

- Skeletons mirror final layout geometry to prevent visual jumping.
- Errors state what failed and provide a retry action.
- Loading, empty, error, and success states are mandatory for data-backed
  screens.

---

## 9. Responsive Behavior

Use `LayoutBuilder`, current constraints, and `AppBreakpoints`. Do not design
against one fixed device width.

| Mode | Width | Dashboard behavior |
|---|---:|---|
| Phone | `<600dp` | Single content column, two-column action/KPI grids, 16dp page margin |
| Tablet | `600–839dp` | Single prioritized content flow with denser grids, 24dp margin |
| Expanded | `840–1199dp` | Two-column secondary content and navigation rail, 32dp margin |
| Desktop | `1200–1919dp` | Persistent navigation, constrained multi-column content |
| UltraWide | `≥1920dp` | Centered content at a readable maximum width, never stretched edge-to-edge |

Responsive rules:

- No horizontal scrolling for primary page content.
- Preserve at least 48dp touch targets at every width.
- Prioritize hero, actions, and primary analytics before secondary history on
  small screens.
- Charts reduce height and complexity on phones.
- Reserve bottom padding for system gestures, bottom navigation, and the AI
  assistant.
- Support landscape and large text without clipping essential actions.

---

## 10. Motion and Interaction

All motion uses `AppMotion`:

- Fast: 150ms for press, hover, and small state changes.
- Medium: 250ms for card and control transitions.
- Slow: 350ms for entrances and major transitions.
- Standard curve: emphasized deceleration.
- Spring curve: restricted to AI triggers and small celebratory feedback.

Dashboard entrance uses a restrained fade and upward slide with roughly 55ms
stagger between major sections. Interactive surfaces may scale to 0.98 on press
and lift only slightly on hover.

Rules:

- Animate opacity and transforms, not layout dimensions.
- Motion must explain hierarchy or interaction state.
- User input remains available during animation.
- `MediaQuery.disableAnimations` produces the complete static state immediately.
- Avoid looping decorative motion in data-heavy work areas.

---

## 11. Accessibility

- Meet WCAG AA: 4.5:1 for normal text and 3:1 for large text and meaningful
  graphical controls.
- Maintain a minimum 48×48dp interaction target and at least 8dp between nearby
  targets.
- Use `Semantics` for cards, charts, progress, and non-obvious controls.
- Every icon-only button has a tooltip and an accessible name.
- Charts include a concise text summary and visible exact values.
- Never rely on hover, color, animation, or gesture alone.
- Keep focus indication visible for keyboard and assistive navigation.
- Support TalkBack, VoiceOver, dynamic type, and reduced motion.

---

## 12. Content Style

Product copy is concise, calm, specific, and action-oriented.

Prefer:

- “Your AI workspace is ready.”
- “Create a focused workspace.”
- “3 active projects contributing to your momentum.”

Avoid:

- Generic filler such as “Unlock your potential.”
- Technical system language when a user action is available.
- Excessive exclamation marks.
- Labels that describe the component instead of the user outcome.

---

## 13. Non-Negotiable Rules

1. Use only shared design tokens and approved theme extensions.
2. Preserve the navy, topographic, light-surface product identity.
3. Use one icon family within a component group.
4. Keep one dominant primary action per screen region.
5. Use glass/translucency only when it clarifies surface depth.
6. Keep data truthful; never fabricate project, insight, or metric content for
   decorative effect.
7. Implement loading, empty, error, and success states.
8. Provide semantics, visible focus, reduced motion, and 48dp touch targets.
9. Verify phone, tablet, expanded, and wide layouts before release.
10. Do not bypass the design system to achieve a one-off visual effect.

---

## 14. Pre-Delivery UI Checklist

- [ ] No raw colors, spacing, radii, shadows, or motion values where tokens exist.
- [ ] No mixed icon styles or emoji icons.
- [ ] Text and graphical contrast meet WCAG AA.
- [ ] Icon-only controls have tooltips and semantic labels.
- [ ] Touch targets are at least 48×48dp.
- [ ] Hover, focus, pressed, selected, disabled, and loading states are clear.
- [ ] Reduced motion is respected.
- [ ] Loading skeletons match final content geometry.
- [ ] Empty and error states provide a recovery path.
- [ ] Charts expose exact values and a readable semantic summary.
- [ ] Phone, tablet, expanded, desktop, and ultrawide layouts do not overflow.
- [ ] The screen feels continuous with onboarding and the authenticated shell.
