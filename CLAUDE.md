# Expensely App

Flutter mobile app for expense tracking. Consumes a separate Spring Boot API
(repo `expensely-api`, not part of this repo).

## Stack

- Flutter (latest stable) / Dart
- State management: Riverpod (`flutter_riverpod`)
- Navigation: `go_router`
- HTTP client: `dio`
- Models: `freezed` + `json_serializable`
- Charts: `fl_chart`
- Fonts: `google_fonts`
- Auth token storage (future): `flutter_secure_storage`
- Google sign-in: `google_sign_in`

## Architecture

MVVM + Feature-First. No separate `domain/` layer for this project — each
feature has a `data/` layer and a `presentation/` layer only, per current
official Flutter recommendations (2026).

Each feature is self-contained: it owns its models, providers, screens, and
widgets. Cross-feature/shared code lives in `core/`.

## Folder structure

```
lib/
  core/
    di/            # dependency injection / provider wiring
    network/        # Dio client, API base URL config (not wired yet)
    theme/           # app theme, colors, typography
    navigation/      # go_router configuration, route guards
    utils/           # generic helpers, extensions
  features/
    auth/
      data/
        models/      # freezed/json_serializable models
      presentation/
        providers/   # Riverpod providers (ViewModels)
        screens/      # full pages
        widgets/       # feature-local reusable widgets
    expenses/        # not started yet
    categories/       # not started yet
    dashboard/         # not started yet
```

Within a feature: `data/` holds models and repositories, `presentation/`
holds providers (ViewModel role), screens, and widgets.

## Backend

The API is a separate Spring Boot project (`expensely-api`), not present in
this repo. The base URL and HTTP wiring will be configured under
`core/network/` once network integration starts — not done yet as of this
writing.

## Widget conventions

- One widget = one responsibility.
- Data flows in via constructor parameters; events flow out via callbacks
  (no widgets reaching into global state directly unless they are the
  screen/provider-connected root).
- Never duplicate UI structure across screens. As soon as a visual/structural
  pattern repeats on 2 or more screens, extract it into a shared widget.
- Feature-local shared widgets live in `features/<feature>/presentation/widgets/`.
  Widgets shared across multiple features belong in the top-level `shared/`
  folder once that need arises.

## Docs

- `docs/design-system.md` — color palette, typography, style principles.
- `docs/plan-auth.md` — checklist for the auth feature build-out.
