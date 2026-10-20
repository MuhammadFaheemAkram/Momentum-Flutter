import 'package:intl/intl.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

/// How dates and times read on screen. Formatting lives here, never in the
/// domain.
abstract final class DateLabels {
  /// "Today", "Yesterday", "Tomorrow", "Mon, 12 Oct", and the year too when
  /// it isn't this year's.
  static String day(CalendarDate date, {required CalendarDate today}) {
    if (date == today) return 'Today';
    if (date == today.addDays(-1)) return 'Yesterday';
    if (date == today.addDays(1)) return 'Tomorrow';
    final pattern = date.year == today.year ? 'EEE, d MMM' : 'EEE, d MMM y';
    return DateFormat(pattern).format(date.toDateTime());
  }

  /// [day], for the middle of a sentence: "today", "yesterday", "Mon, 12
  /// Oct" ("Unlocked today").
  static String inSentence(CalendarDate date, {required CalendarDate today}) {
    if (date == today) return 'today';
    if (date == today.addDays(-1)) return 'yesterday';
    return day(date, today: today);
  }

  /// "Wednesday, 21 October": Today's heading.
  static String long(CalendarDate date) =>
      DateFormat('EEEE, d MMMM').format(date.toDateTime());

  /// "12 Oct": a chart's week, a heatmap's first day of a month.
  static String dayMonth(CalendarDate date) =>
      DateFormat('d MMM').format(date.toDateTime());

  /// "Oct": a chart's month.
  static String month(CalendarDate date) =>
      DateFormat('MMM').format(date.toDateTime());

  /// "October 2026".
  static String monthYear(CalendarDate date) =>
      DateFormat('MMMM y').format(date.toDateTime());

  /// "Monday".
  static String weekday(CalendarDate date) =>
      DateFormat('EEEE').format(date.toDateTime());

  /// When a goal starts over: "Resets tomorrow", "Resets Monday" (within a
  /// week), "Resets 1 Nov".
  static String resets(CalendarDate day, {required CalendarDate today}) {
    if (day == today.addDays(1)) return 'Resets tomorrow';
    if (day <= today.addDays(7)) return 'Resets ${weekday(day)}';
    return 'Resets ${dayMonth(day)}';
  }

  /// "21 Oct 2026".
  static String short(CalendarDate date) =>
      DateFormat('d MMM y').format(date.toDateTime());

  /// "07:30", or "7:30 AM" where the device uses a 12-hour clock.
  static String time(TimeOfDayValue time, {bool use24HourFormat = true}) {
    final at = DateTime(2026, 1, 1, time.hour, time.minute);
    return (use24HourFormat ? DateFormat.Hm() : DateFormat.jm()).format(at);
  }
}
