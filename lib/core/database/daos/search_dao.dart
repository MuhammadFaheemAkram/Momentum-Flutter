import 'package:drift/drift.dart';
import 'package:momentum/core/database/app_database.dart';
import 'package:momentum/core/database/tables/tables.dart';

part 'search_dao.g.dart';

/// Search over the user's own things. The data is a person's habits,
/// routines and goals (dozens of rows), so a `LIKE` is quick, and simpler
/// than DevJourney's FTS5 index.
@DriftAccessor(tables: [Habits, Routines, RoutineItems, Goals])
class SearchDao extends DatabaseAccessor<AppDatabase> with _$SearchDaoMixin {
  SearchDao(super.attachedDatabase);

  /// Habits whose name or description contains [text], archived ones too.
  Stream<List<HabitRow>> watchHabits(String text) {
    final pattern = likePattern(text);
    return (select(habits)
          ..where(
            (t) =>
                t.title.like(pattern, escapeChar: r'\') |
                t.description.like(pattern, escapeChar: r'\'),
          )
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .watch();
  }

  /// Routines whose name, or one of whose steps, contains [text].
  Stream<List<RoutineRow>> watchRoutines(String text) {
    final pattern = likePattern(text);
    final byStep = selectOnly(routineItems)
      ..addColumns([routineItems.routineId])
      ..where(routineItems.title.like(pattern, escapeChar: r'\'));
    return (select(routines)
          ..where(
            (t) =>
                t.title.like(pattern, escapeChar: r'\') |
                t.id.isInQuery(byStep),
          )
          ..orderBy([(t) => OrderingTerm(expression: t.sortOrder)]))
        .watch();
  }

  Stream<List<GoalRow>> watchGoals(String text) =>
      (select(goals)
            ..where((t) => t.title.like(likePattern(text), escapeChar: r'\'))
            ..orderBy([(t) => OrderingTerm(expression: t.createdAt)]))
          .watch();

  /// `%text%`, with `%`, `_` and the escape character itself escaped, so
  /// "100%" finds "100%" and not everything. The text is a bound parameter,
  /// never part of the SQL.
  static String likePattern(String text) =>
      '%${text.replaceAllMapped(RegExp(r'[%_\\]'), (m) => '\\${m[0]}')}%';
}
