/// A time on the clock, with no day and no time zone: 07:30 is `450`, the
/// minutes since midnight.
///
/// A habit's reminder, the nudge and the daily summary happen at a time *of
/// the user's day*, wherever the phone is. Stored as `HH:mm` text, which
/// reads well in the database and sorts like the times it stands for.
///
/// An extension type over `int`, like `CalendarDate`: free at runtime, and
/// every value goes through a factory that checks it.
extension type const TimeOfDayValue._(int minutesSinceMidnight) {
  /// [hour]:[minute]. Throws an [ArgumentError] outside 00:00–23:59.
  factory TimeOfDayValue(int hour, int minute) {
    if (hour < 0 || hour > 23 || minute < 0 || minute > 59) {
      throw ArgumentError('Not a time: $hour:$minute');
    }
    return TimeOfDayValue._(hour * 60 + minute);
  }

  /// The time in `HH:mm` text (`07:30`). Throws a [FormatException] for
  /// anything else, including `7:30` and `24:00`.
  factory TimeOfDayValue.parse(String hhMm) {
    final match = _pattern.firstMatch(hhMm);
    final hour = int.tryParse(match?.group(1) ?? '');
    final minute = int.tryParse(match?.group(2) ?? '');
    if (hour == null || minute == null || hour > 23 || minute > 59) {
      throw FormatException('Not an HH:mm time', hhMm);
    }
    return TimeOfDayValue(hour, minute);
  }

  /// Settings' defaults, as constants so models can use them in `@Default`.
  static const nineAm = TimeOfDayValue._(9 * 60);
  static const eightPm = TimeOfDayValue._(20 * 60);
  static const nineThirtyPm = TimeOfDayValue._(21 * 60 + 30);

  int get hour => minutesSinceMidnight ~/ 60;

  int get minute => minutesSinceMidnight % 60;

  bool operator <(TimeOfDayValue other) =>
      minutesSinceMidnight < other.minutesSinceMidnight;

  /// `07:30`.
  String toHhMm() =>
      '${hour.toString().padLeft(2, '0')}:'
      '${minute.toString().padLeft(2, '0')}';

  static final _pattern = RegExp(r'^(\d{2}):(\d{2})$');
}
