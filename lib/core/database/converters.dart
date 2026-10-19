import 'package:drift/drift.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

/// Stores a [CalendarDate] as its `yyyymmdd` integer: it sorts, compares and
/// ranges (`BETWEEN`) like the days it stands for.
class CalendarDateConverter extends TypeConverter<CalendarDate, int> {
  const CalendarDateConverter();

  @override
  CalendarDate fromSql(int fromDb) => CalendarDate.fromInt(fromDb);

  @override
  int toSql(CalendarDate value) => value.yyyymmdd;
}

/// Stores a [TimeOfDayValue] as `HH:mm` text, which sorts like the times.
class TimeOfDayConverter extends TypeConverter<TimeOfDayValue, String> {
  const TimeOfDayConverter();

  @override
  TimeOfDayValue fromSql(String fromDb) => TimeOfDayValue.parse(fromDb);

  @override
  String toSql(TimeOfDayValue value) => value.toHhMm();
}
