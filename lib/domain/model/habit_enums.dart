// The fixed sets a habit chooses from. They are stored by `name` (drift's
// `textEnum`), so the order here can change freely, but renaming a value is
// a schema change.

enum HabitCategory {
  health('Health'),
  fitness('Fitness'),
  learning('Learning'),
  productivity('Productivity'),
  reading('Reading'),
  finance('Finance'),
  personal('Personal');

  const HabitCategory(this.label);

  final String label;
}

/// A habit's color, by name. The shades themselves are presentation: the
/// design system's `HabitPalette` turns a name into colors that suit the
/// current theme, so they can be retuned without touching stored habits.
enum HabitColor { green, teal, blue, indigo, purple, pink, orange, amber }

/// A habit's icon, by name; the design system maps each to an `IconData`.
enum HabitIcon {
  water,
  run,
  book,
  language,
  savings,
  checklist,
  meditation,
  sleep,
  fitness,
  heart,
  music,
  code,
}

/// When in the day a routine belongs.
enum RoutineTime {
  morning('Morning'),
  afternoon('Afternoon'),
  evening('Evening'),
  anytime('Any time');

  const RoutineTime(this.label);

  final String label;
}

/// The window a goal counts in: today, this ISO week, or this month.
enum GoalPeriod {
  daily('Daily'),
  weekly('Weekly'),
  monthly('Monthly');

  const GoalPeriod(this.label);

  final String label;
}
