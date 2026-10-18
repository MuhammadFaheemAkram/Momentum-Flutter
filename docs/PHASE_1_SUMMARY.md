# Phase 1 — Foundation

> A beginner-to-intermediate friendly write-up covering:
> - what shipped in Phase 1, and why;
> - the Flutter / Dart concepts it demonstrates;
> - how the Android and iOS editions planned the same phase.

---

## 🎯 Phase Goal

Phase 1 builds the frame every later phase hangs on:
- a **pinned toolchain** and strict analysis, with CI from the first commit;
- a **design system base:** themes, the status colors (done, skipped, missed, streak), the eight habit colors, tokens and the shared state views;
- **navigation:** a first-launch gate, five tabs, a navigation drawer for the screens that don't fit in a tab bar, and every screen above the tabs reachable by a typed route and by a link;
- **placeholder screens** with their final app bars and buttons, so the shape of the app is visible and testable now;
- an **accessibility tour** that checks every screen from day one.

---

## 🧱 What Was Implemented

- **Project:** `momentum` (org `co.bitfuse.flutter`, display name "Momentum"), Flutter 3.47.6 pinned by FVM, Android and iOS, `material_ui`.
- **Quality gates:**
  - `analysis_options.yaml`: flutter_lints plus strict casts, inference and raw types;
  - `build.yaml`: lint-free generated parts;
  - GitHub Actions CI: generated code up to date with nothing left untracked, then format, analyze and test;
  - the MIT license.
- **Design system:**
  - `AppTheme`: Material 3 light and dark themes from a green seed (`#0F9D7A`). They are built through `AppTheme.fromScheme(ColorScheme)`, so Android's dynamic color can replace the scheme in Phase 6.
  - `AppColors` (a `ThemeExtension`): `done`, `skipped`, `missed` and `streak`. Each is a text color that reaches WCAG AA on the page, cards and filled fields in both themes (tested).
  - `HabitPalette`: the eight colors a habit can take (green, teal, blue, indigo, purple, pink, orange, amber). Each gives a container and an on-container color for the current brightness, derived from the color as a seed and cached. A habit stores only the color's **name**, so the palette can change without a migration. Every pair reaches AA in both themes (tested).
  - The rest: spacing, radius and icon-size tokens; `LoadingView`, `ErrorView`, `EmptyStateView`, `SectionHeader`; and the large-text rule (`prefersStackedLayout`).
- **Navigation (typed `go_router` routes):**
  - `/welcome`, gated by the pure `firstLaunchRedirect(onboarded, location)` and a `refreshListenable`;
  - a `StatefulShellRoute` with five tabs: Today, Habits, Analytics, Achievements, Settings;
  - above the tabs: the habit form at `/habits/new` and `/habits/:habitId/edit` (a full-screen dialog, the edit one over its habit), Habit detail at `/habits/:habitId`, `/routines` with the routine editor at `/routines/new` and `/routines/:routineId/edit`, then `/goals`, `/search` and `/about`;
  - "Page not found" for an unknown location, with a way back.
- **The shell:**
  - a `NavigationBar` whose labels keep their size at any text setting;
  - the **navigation drawer** (Routines, Goals, Search, About) on the shell's outer `Scaffold`, so it covers the tab bar. Every tab's menu button opens it through a small `ShellDrawerScope`;
  - Today and Habits also have a Search button and a **"New habit"** button.
- **Screens:**
  - Welcome: "Explore with demo data" and "Start empty";
  - the five tabs, Habit detail, the habit form, Routines, the routine editor, Goals, Search and About, each with its final app bar;
  - screens opened by a link get a Close button to a sensible home (conventions §11.47);
  - About opens the open-source licenses.
- **DI:** the `get_it` + `injectable` composition root, with a temporary in-memory `PlaceholderOnboarding` until the saved setting arrives in Phase 2.
- **Tests:** 121.

### Differences from the plan

- **The tab bar says "Badges", not "Achievements".** On an iPhone 17 Pro at the default text size, "Achievements" broke mid-word under its icon: five tabs leave each label about 80 points. The tab keeps its full name everywhere else: the screen's title, the drawer and the tab's long-press tooltip (tested). `AppTab.barLabel` returns a short label only where one is set, and a test pins that only Achievements has one.
- **Every FAB in the shell has its own hero tag.** Today and Habits both show "New habit". Once both tabs have been visited, both stay built in the shell's `IndexedStack`, so the two buttons shared the default hero tag, and *any* route pushed over the shell failed with "multiple heroes share the same tag". The app-level navigation tests caught it; it is now trap §11.59 in the conventions.
- **No adaptive helpers yet, and no `cupertino_ui`:** the first iOS touches (switches, dialogs, pickers) arrive with the screens that use them, rather than as unused code.

---

## 💙 Flutter / Dart Concepts Demonstrated

- **FVM pinning:** `.fvmrc` makes the Flutter version part of the repository; the machine's global version stays untouched.
- **Typed routes:** `@TypedGoRoute` classes generate `location`, `go` and `push`; a route with a parameter can't be built without it. `/habits/new` is declared before `/habits/:habitId`, so "new" is never read as an id.
- **`StatefulShellRoute.indexedStack`:** a navigator per tab, kept alive, so each tab keeps its stack and scroll position. That also means every visited tab's widgets stay in the tree, which is why hero tags must be unique across tabs.
- **Heroes:** a `FloatingActionButton` is a `Hero` with a default tag. When a route is pushed, Flutter collects every hero in the outgoing page's subtree, hidden tabs included; two with one tag is an error.
- **A drawer above nested Scaffolds:** the drawer belongs to the outer `Scaffold`, and an `InheritedWidget` (`ShellDrawerScope`) lets the inner tab app bars open it. `Scaffold.of(context)` alone would find the tab's own Scaffold.
- **Sealed classes for a menu's results:** `DrawerDestination` is either a `TabDestination(index)` or a `ScreenDestination` (an enum that `implements` the sealed class). The shell handles both with an exhaustive `switch`.
- **Enums with fields:** `AppTab` carries its label, icons and an optional `shortLabel`, so the bar, the drawer and the tests read from one place.
- **Full-screen dialogs:** `MaterialPage(fullscreenDialog: true)` slides up and shows a Close button: Material's counterpart of an iOS sheet.
- **A pure redirect:** `firstLaunchRedirect` is a plain function, re-run by the router whenever its `refreshListenable` changes.
- **`ThemeExtension`:** colors Material has no slot for, switching and animating (`lerp`) with the theme.
- **`ColorScheme.fromSeed` as a palette generator:** each habit color becomes a tonal container pair that suits the brightness, instead of hand-picked shades.
- **`MediaQuery.withNoTextScaling`** for the tab labels, with the label still available through a long press and to screen readers.
- **Accessibility guidelines in tests:** `meetsGuideline(androidTapTargetGuideline / labeledTapTargetGuideline / textContrastGuideline)`.

---

## 🔁 Data Flow (this phase)

```
App start ─▶ configureDependencies() ─▶ MomentumApp ─▶ GoRouter(initialLocation: /today)
  redirect: firstLaunchRedirect(onboarded: PlaceholderOnboarding.onboarded, location)
    not onboarded ─▶ /welcome ── "Explore with demo data" / "Start empty" ─▶ onboarding.complete()
                                     └─ notifyListeners ─▶ refreshListenable ─▶ redirect ─▶ /today
    onboarded ─▶ the tab shell
      menu button ─▶ ShellDrawerScope.openDrawer ─▶ drawer
        tab item ─▶ goBranch(index)        screen item ─▶ push (root navigator)
      "New habit" ─▶ NewHabitRoute().push ─▶ full-screen dialog
```

---

## 📁 Important Files Added

| File | Purpose |
|------|---------|
| `.fvmrc`, `analysis_options.yaml`, `build.yaml`, `.github/workflows/flutter-ci.yml` | Toolchain, lints, codegen, CI. |
| `lib/core/design_system/**` | Theme, status colors, the habit palette, tokens, state views, the large-text rule. |
| `lib/core/navigation/app_routes.dart` (+ `.g.dart`) | Every typed route. |
| `lib/core/navigation/app_router.dart`, `first_launch_redirect.dart`, `placeholder_onboarding.dart`, `fallback_close_button.dart` | The router, its gate, and the Close fallback for links. |
| `lib/features/shell/{main_shell,app_navigation_drawer,shell_drawer_scope}.dart` | Tabs and the drawer. |
| `lib/features/*/…_page.dart` | Welcome and the placeholder screens. |
| `lib/app/momentum_app.dart`, `lib/di/injection.dart`, `lib/main.dart` | The app root and DI. |
| `test/app/accessibility_tour_test.dart`, `test/core/navigation/*`, `test/helpers/*` | The tour, navigation tests, the app harness. |

---

## 🧩 Important Types Added

| Type | Kind | Responsibility | Why it lives here |
|------|------|----------------|-------------------|
| `AppTheme` | final class (namespace) | Themes from a seed or any `ColorScheme` | `core/design_system/theme` |
| `AppColors` | `ThemeExtension` | Done, skipped, missed and streak colors | `core/design_system/theme` |
| `HabitPalette`, `HabitTone` | final class / value | A habit color's name → its container pair for a brightness | `core/design_system/theme`: views use it; the domain stores only the name |
| `firstLaunchRedirect` | pure function | Welcome until started | `core/navigation`: one-line unit tests |
| `PlaceholderOnboarding` | `ChangeNotifier` (temporary) | The onboarded flag, in memory | replaced in Phase 2 |
| `MainShell` | StatefulWidget | Tabs and the drawer | `features/shell` |
| `AppTab`, `DrawerDestination` (`TabDestination`, `ScreenDestination`) | enum / sealed class | What the drawer and bar offer | `features/shell` |
| `ShellDrawerScope`, `DrawerMenuButton` | InheritedWidget / widget | Open the drawer from any tab | `features/shell` |

---

## 🌱 Folder Structure Changes

- **New project.** `lib/app`, `lib/core/{design_system,navigation}`, `lib/features/*`, `lib/di`; `test/` mirroring it, plus `test/app` and `test/helpers`.

---

## 🤖🍏 Android / iOS Comparison

From the two native specs:

| Concept | Android (Kotlin) | iOS (Swift) | Flutter (Dart) |
|---|---|---|---|
| Project | Compose, Hilt, Navigation Compose | SwiftUI, `AppEnvironment`, `Route` + `Router` | FVM-pinned Flutter, `get_it` + `injectable`, typed `go_router` |
| Tabs | bottom navigation (tabs not named) | `TabView`: Dashboard, Habits, Analytics, Achievements, Settings | `StatefulShellRoute` + `NavigationBar`: iOS's five, with Today for Dashboard |
| Secondary screens | a drawer | pushed from the tabs | a `Drawer` (as Android): Routines, Goals, Search, About; plus Search and "New habit" on Today and Habits |
| Theme | Material 3, dark mode, dynamic color | light/dark, Dynamic Type | Material 3 from a seed; `fromScheme` ready for dynamic color; a habit palette; large-text rule |
| Placeholders | placeholder screens | `TabView` with placeholders | placeholders with their final app bars and buttons, tested |
| CI | Phase 7 | Phase 7 | Phase 1 |
| Accessibility checks | — | — | a test tour of every screen from Phase 1 |

The Android spec has a drawer but doesn't name its tabs; the iOS spec names five tabs but has no drawer. The Flutter edition takes both: iOS's tabs in a Material bar, and Android's drawer for the screens that don't fit in it.

---

## 🎤 Interview Notes

**Q: Your navigation tests failed with "multiple heroes share the same tag", but only one FAB was on screen. Why?**
A: A `StatefulShellRoute.indexedStack` keeps every tab you've visited built, offstage, so after switching tabs both FABs were in the tree. A FAB is a `Hero` with a default tag, and a push collects every hero under the outgoing page, hidden ones included. Each FAB in a tab now has its own `heroTag`.

**Q: How do you handle a tab label that's too long?**
A: Shorten it only where it breaks. "Achievements" broke mid-word in a five-tab bar on an iPhone, so the bar says "Badges"; the screen title, the drawer and the long-press tooltip keep the full name. The labels don't scale with text size either (five tabs can't grow), so the long press is what makes them readable at large text.

**Q: Why store a habit's color as a name instead of a color value?**
A: A name ("teal") is stable data; the exact shades are presentation, and they differ between light and dark. The palette turns the name into a container pair for the current brightness, and can be retuned without touching stored habits. Unknown names fall back to the first color, so old data can't crash a screen.

**Q: How does the app decide between Welcome and Today?**
A: The router does, with a pure function of two inputs, re-run whenever the onboarding flag changes. Welcome only records the choice; it never navigates.

**Q: How do screens opened by a link get back?**
A: An app bar adds Back only when there's something to pop. A screen opened by a link is the only page, so it gets a Close button that `go`es to a sensible home (Habits for a habit, Routines for the routine editor).

---

## 📝 Learning Checklist

- ✅ Pin Flutter per project with FVM, and gate every commit with CI
- ✅ Build Material 3 themes from a seed, ready for any `ColorScheme`
- ✅ Add app-specific colors with a `ThemeExtension`, and a seed-derived palette, contrast-tested
- ✅ Declare typed routes, a tab shell, and screens and full-screen dialogs above it
- ✅ Combine a bottom bar with a navigation drawer over nested Scaffolds
- ✅ Keep hero tags unique across a shell's tabs
- ✅ Gate the app with a pure redirect and a `refreshListenable`
- ✅ Check accessibility guidelines in widget tests
- ⬜ The models, the database, the demo and Welcome for real (Phase 2)

---

## 🚀 Future Improvements

- **Phase 2:** the domain models (habits and their schedules, logs, routines, goals, unlocks), drift shared across isolates, the fake service and the demo, a real Welcome (fetch, error, Try again, or start empty), and the saved first-launch flag.
- **Phase 3:** the schedule engine, Today, Habits, the habit form and Habit detail.
- **Later:** a `NavigationRail` instead of the drawer on tablets and in landscape.
