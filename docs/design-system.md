# Design System

Reference for visual style across the app. Keep new screens consistent with
this instead of redefining style choices per screen.

## Palette

| Role | Color | Hex |
|---|---|---|
| Primary (navy) | Deep navy | `#0B1F3A` |
| Accent | Emerald green | `#10B981` |
| Background | White / off-white | `#FFFFFF` / `#F8FAFC` |
| Surface | Light gray | `#F1F5F9` |
| Text primary | Navy / near-black | `#0B1F3A` |
| Text secondary | Muted gray | `#64748B` |
| Border / divider | Light gray | `#E2E8F0` |
| Error | Red | `#EF4444` |
| Success | Emerald green | `#10B981` |

Navy is the dominant brand color (headers, primary buttons, key text).
Emerald green is the accent — used for calls to action, positive states
(income, success), and highlights. Avoid introducing new brand colors
without updating this file.

## Typography

Fonts are loaded via `google_fonts`. Pick a clean, modern sans-serif
(e.g. Inter or similar geometric/grotesque sans) — exact font family to be
locked in when `core/theme/` is implemented.

Suggested scale:

| Style | Usage |
|---|---|
| Display / Headline | Onboarding titles, dashboard totals |
| Title | Screen titles, section headers |
| Body | Standard text, form labels |
| Label / Caption | Helper text, timestamps, small metadata |

Weights: prefer semi-bold/bold for headings and totals, regular for body
text. Avoid more than 2-3 weights per screen.

## Style principles

- **Clean, modern fintech look.** Generous whitespace, minimal visual noise,
  clear hierarchy.
- **Navy + emerald as the core identity.** Neutral grays for structure,
  color reserved for emphasis (primary actions, positive/negative amounts,
  charts).
- **Rounded, soft UI.** Rounded corners on cards, buttons, and inputs rather
  than sharp edges.
- **Flat over skeuomorphic.** Subtle shadows/elevation only where needed to
  separate layers (cards over background), no heavy gradients or bevels.
- **Consistent spacing scale.** Use a fixed spacing scale (e.g. 4/8/12/16/24/32)
  rather than arbitrary padding values.
- **Charts follow the palette.** `fl_chart` visuals should draw from the
  palette above (navy/emerald primary, muted grays for gridlines/labels)
  rather than default chart colors.

This document will be expanded with concrete `ThemeData`/`TextTheme` values
once `core/theme/` is implemented.
