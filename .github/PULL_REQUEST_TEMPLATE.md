<!-- Thanks for contributing to Momentum! -->

## Summary

<!-- What does this PR change, and why? -->

## Changes

-

## Checklist

- [ ] `fvm flutter analyze` reports no issues.
- [ ] `fvm dart format --output=none --set-exit-if-changed .` passes.
- [ ] `fvm flutter test` passes; new logic is covered by tests where practical (engine rules at their edges).
- [ ] Generated code is regenerated and committed (`fvm dart run build_runner build`).
- [ ] Architecture boundaries are respected (View → Cubit/Bloc → UseCase → Repository), and nothing derived is stored.
- [ ] A schema change bumps `schemaVersion` and ships with `make-migrations` output and a migration test.
- [ ] Platform features go through a `domain/service` interface, with a fake for tests; notifications change only through the plan.
- [ ] Anything the background tasks need is wired into `BackgroundGraph` too.
- [ ] UI changes work in dark mode and at large text sizes, and new screens or states are added to the accessibility tour.
- [ ] Docs are updated if behaviour or structure changed.
- [ ] Commit messages follow Conventional Commits.

## Screenshots (if UI changed)

| Before | After |
|--------|-------|
|        |       |
