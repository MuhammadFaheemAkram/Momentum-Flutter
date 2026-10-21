# Security Policy

## Supported Versions

Momentum is a learning/reference project. Security fixes are applied to the latest `main` only.

| Version | Supported |
|---------|:---------:|
| `main`  | ✅ |

## Reporting a Vulnerability

Please **do not** open a public issue for security problems.

Instead, email **muhammadfaheem004@gmail.com** with:

- a description of the issue and its impact;
- steps to reproduce (a proof of concept if possible);
- any suggested remediation.

You can expect an acknowledgement within a few business days.

## What the App Holds

Momentum has **no backend, no account and no API key**. The "API" is a fake service inside the app: it reads the demo from a JSON file bundled with the app and keeps the latest backup in memory. The app makes no network requests.

- **The user's data** (habits, logs, routines, goals, badge unlocks) lives in a SQLite database (drift) in the app's documents directory. It is not encrypted at rest; it is protected by the operating system's app sandbox like any app's private files. Settings → Reset progress clears the history; everything goes when the app is removed.
- **Preferences** hold only the onboarding flag, the appearance, dynamic color, the notification settings and times, the default reminder time, automatic backup and the last backup's time, and recent searches.
- **Backups** are simulated: the JSON is kept in the app's memory and never leaves the device. Only the receipt's time is saved.
- **Search is injection-safe:** user text reaches SQLite only as a bound parameter of a `LIKE`, with `%`, `_` and `\` escaped; it is never concatenated into SQL.
- **Notifications** are local, scheduled on the device; their payloads hold only a habit id and a time. A tap or "Mark done" with an unknown payload is ignored.
- **Background work** runs on the device only (WorkManager, BGTaskScheduler) and touches only the app's own database and preferences.

The practical attack surface is small. Reports about data handling, notification handling, dependency issues or unsafe patterns are still very welcome.
