# Phase 7 — Documentation & CI

> A beginner-to-intermediate friendly write-up covering:
> - what shipped in Phase 7, and why;
> - the practices it demonstrates;
> - how the Android and iOS editions planned the same phase.

---

## 🎯 Phase Goal

Phase 7 turns a working app into a project someone else can learn from and contribute to:
- **documentation** that explains the design (architecture, data model, the habit engine, notifications, background work, the fake API, testing), not just the setup;
- **evidence:** screenshots from a fresh install, test counts per area, and mutation checks that prove the tests catch what they claim to;
- **the open-source file set**, and a CI that fails on anything stale;
- a final **cleanup** pass.

No feature changes: the app at the end of Phase 6 is the app.

---

## 🧱 What Was Implemented

- **Docs (`docs/`):**
  - `ARCHITECTURE.md`: layers and their import rules (checked against the code), who owns what, state management and the app-wide watchers, errors, writes, navigation, DI (and the background graph), platform services, accessibility, key decisions;
  - `DATA_MODEL.md`: every table, key, constraint, cascade and index, how a schedule becomes three columns, multi-row writes in transactions, preferences, the backup's shape, migrations;
  - `HABIT_ENGINE.md`: due days, streaks, perfect days, the completion rate, the consistency score, goals, routines, the ten badges and analytics, each **worked through on the demo** as of Wednesday 21 October, 15:00 (the figures the tests assert and the screenshots show);
  - `NOTIFICATIONS.md`: the rolling window, the planner's rules, ids and payloads, time zones, the sync and when it runs, channels, "Mark done", taps and permission per platform;
  - `BACKGROUND_WORK.md`: the entry points, the hand-built graph, the shared database and preferences, WorkManager and BGTaskScheduler setup, and how to run each by hand;
  - `API_SIMULATION.md`: the fake service, the demo's relative weeks and its checks, backups going out, errors, the developer switch;
  - `TESTING.md`: **667 tests by area** (counted with `--reporter json`), how the tests are built, all **53 mutation checks**, and gotchas;
  - `LEARNING_NOTES.md`, `INTERVIEW_NOTES.md`, `ROADMAP.md`;
  - `SCREENSHOTS.md` with **20 screenshots:** light, dark and AX3 large text on the iOS simulator, and dynamic color on an Android 16 emulator, each with alt text.
- **Open-source files:** CONTRIBUTING (the architecture rules, the engine's rules, schema and demo changes, test helpers), CODE_OF_CONDUCT, SECURITY (what the app holds, injection-safe search, local-only notifications and backups), CHANGELOG (one entry per phase), and the bug report, feature request and PR templates.
- **README:** final status, screenshots, the demo and persistence explained, a short test table linking to TESTING, every doc linked.
- **CI:** already current since Phase 1 (generated code up to date with nothing untracked, format, analyze, test on the pinned Flutter); confirmed unchanged.
- **Cleanup:**
  - the Android build file's template TODOs became notes that say what the settings are;
  - a stale "Phase 5" comment in the routines DAO;
  - the Phase 6 summary's backup example now uses the demo's real count (209 logs, not the spec's illustrative 412);
  - a scan found no other TODOs, stale phase references or unused library files.
- **Mutation checks** of seven more behaviours, all caught (below).

### Differences from the plan

- **No new tests:** every screen got its tests in its phase. This phase proves the existing tests with mutation checks instead.
- **Screenshots on iOS and Android:** dynamic color needs Android 12+, so two shots come from the emulator beside the iOS set.
- **The demo's figures were computed, not read off screens:** a throwaway test printed them from the real engine (then was deleted), and the docs were checked against that output.

### Mutation checks

Each was broken on purpose, the whole suite run, then restored:

| Broken on purpose | Tests that failed |
|---|---:|
| "Done" needs more than the daily target (`>` for `≥`) | 103 |
| `PRAGMA foreign_keys` not turned on (no cascades) | 14 |
| A habit due before its start date | 13 |
| The first-launch gate lets everyone through | 9 |
| An archived habit stays due | 3 |
| Reset progress keeps the badges | 2 |
| A backup drops `archivedAt` | 1 |

With the 46 from Phases 2–6, **53 behaviours are proven guarded**. See [TESTING.md](TESTING.md).

---

## 💙 Practices Demonstrated

- **Docs that teach the design:** the why (derived figures, neutral days, weeks judged as weeks, a rolling notification window, a second isolate's own graph), with worked examples a reader can check by hand.
- **Numbers that agree everywhere:** the demo's figures in HABIT_ENGINE are the engine's own output, the screenshots show them (90 %, 89, 19 days, 41 planned notifications), and "Backed up 6 habits, 209 logs" is what the app says.
- **Test counts from the runner, not by hand:** `--reporter json`, grouped by folder, hidden setup entries left out.
- **Mutation checks with counts:** how many tests a break fails shows how widely a rule is guarded ("done" at the target: 103).
- **Claims checked against the code:** the layer rules were grepped; DAO behaviour (how unlocks are recorded) and validation rules were read from the source before going into the docs, which corrected two drafts.
- **Accessible docs:** every screenshot has alt text describing what's on screen.
- **Reproducible screenshots:** a fresh install, the demo, a fixed status bar, and the commands to retake them.

---

## 🔁 Data Flow (this phase)

```
Code ──▶ docs (claims checked against the source)
Engine ──throwaway test──▶ the demo's figures ──▶ HABIT_ENGINE.md ──▶ matched by the screenshots
Tests ──▶ --reporter json ──▶ counts per area ──▶ TESTING.md, README
Code ──break on purpose──▶ failing tests counted ──▶ restore ──▶ mutation tables
Fresh install + demo ──▶ simulator / emulator ──▶ docs/screenshots/ ──▶ SCREENSHOTS.md, README
Push ──▶ CI: pub get → build_runner → no diff, no untracked → format → analyze → test
```

---

## 📁 Important Files Added

| File | Purpose |
|------|---------|
| `docs/ARCHITECTURE.md`, `DATA_MODEL.md`, `HABIT_ENGINE.md` | How the app is built, what it stores, and how every figure is derived. |
| `docs/NOTIFICATIONS.md`, `BACKGROUND_WORK.md`, `API_SIMULATION.md` | The platform and fake-API sides, per platform. |
| `docs/TESTING.md` | What's covered, how, and the 53 mutation checks. |
| `docs/LEARNING_NOTES.md`, `INTERVIEW_NOTES.md`, `ROADMAP.md` | Every concept used; questions and answers; what's next. |
| `docs/SCREENSHOTS.md`, `docs/screenshots/*.png` | 20 screenshots with alt text, and how to retake them. |
| `CONTRIBUTING.md`, `CODE_OF_CONDUCT.md`, `SECURITY.md`, `CHANGELOG.md` | The open-source file set. |
| `.github/ISSUE_TEMPLATE/*`, `.github/PULL_REQUEST_TEMPLATE.md` | Issue and PR templates. |

---

## 🧩 Important Types Changed

None. Only comments, the Android build file's notes and the docs changed.

---

## 🌱 Folder Structure Changes

- **New:** `docs/screenshots/`, `.github/ISSUE_TEMPLATE/`, and the root community files.

---

## 🤖🍏 Android / iOS Comparison

From the two native specs:

| Concept | Android (Kotlin) | iOS (Swift) | Flutter (Dart) |
|---|---|---|---|
| Final docs | documentation, README finalization | README + `docs/*`, with NOTIFICATIONS and BACKGROUND_TASKS (how reminders and BGTaskScheduler are wired, permissions, testing) | the same two (BACKGROUND_WORK covering both platforms), plus DATA_MODEL, HABIT_ENGINE worked through on the demo, API_SIMULATION, TESTING with counts and mutation checks, notes, screenshots with alt text, a CHANGELOG |
| Templates | templates | `.github/*` | issue and PR templates adapted to the project's rules (nothing derived stored, notifications only through the plan, the background graph) |
| Cleanup | code cleanup, test cleanup | cleanup | a scan for stale comments, TODOs and unused files; mutation checks instead of new tests |
| CI | a CI workflow, in Phase 7 | `ios-ci.yml`, in Phase 7 | since Phase 1, so every phase was checked by it |
| Screenshots | — | — | iOS light, dark, AX3; Android dynamic color |

Both native specs leave CI to the last phase; this edition had it from the first commit.

---

## 🎤 Interview Notes

**Q: How do you know your test suite is any good?**
A: Coverage says which lines ran, not whether a test would notice them being wrong. Mutation checks do: break a key behaviour on purpose and see a test fail. Here 53 were broken across the phases, from the skip-or-count `CHECK` to a revoked permission; each was caught. Counting the failures also shows how widely a rule is guarded: making "done" need more than the target breaks 103 tests.

**Q: How do you keep documentation honest?**
A: Generate the numbers instead of typing them: the demo's figures came from the engine itself, test counts from the runner's JSON, and the screenshots show the same figures. Claims about the code (layer rules, how a DAO records unlocks) were checked against the source, which caught two wrong drafts.

**Q: What belongs in a project's docs beyond "how to run it"?**
A: The decisions and their reasons, the data model, the rules with worked examples, how platform features are wired on each OS and how to trigger them by hand, how the tests are built, and how to contribute without breaking the architecture.

**Q: What does your CI check?**
A: On the pinned Flutter version: the generated code is current and nothing generated is missing, formatting, the analyzer, and all 667 tests.

---

## 📝 Learning Checklist

- ✅ Document architecture, data model and rules with worked examples
- ✅ Generate a doc's numbers from the code, not by hand
- ✅ Count tests per area from the runner's JSON output
- ✅ Prove tests with mutation checks, and count what each one breaks
- ✅ Take reproducible screenshots (fixed status bar, fresh install, light / dark / large text, dynamic color)
- ✅ Write alt text for every screenshot
- ✅ Ship the open-source file set and templates
- ✅ Keep CI failing on stale and untracked generated code

---

## 🚀 Future Improvements

See [ROADMAP.md](ROADMAP.md): restore from a backup, a real backend with sync, smarter notifications, widgets, health integration, tablets, localization, integration and golden tests, and an iOS build in CI.
