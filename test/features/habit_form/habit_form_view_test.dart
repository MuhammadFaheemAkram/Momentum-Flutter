import 'package:bloc_test/bloc_test.dart';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_cubit.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_state.dart';
import 'package:momentum/features/habit_form/habit_form_view.dart';

import '../../helpers/habit_builders.dart';
import '../../helpers/pump_app.dart';

class _MockHabitFormCubit extends MockCubit<HabitFormState>
    implements HabitFormCubit {}

void main() {
  late _MockHabitFormCubit cubit;

  setUpAll(() {
    registerFallbackValue(ScheduleKind.daily);
    registerFallbackValue(HabitColor.green);
  });
  setUp(() {
    cubit = _MockHabitFormCubit();
    when(() => cubit.isNew).thenReturn(true);
    when(() => cubit.save()).thenAnswer((_) async {});
    when(() => cubit.discard()).thenReturn(null);
    when(() => cubit.kindChanged(any())).thenReturn(null);
    when(() => cubit.colorChanged(any())).thenReturn(null);
    when(() => cubit.weekdayToggled(any())).thenReturn(null);
  });

  final values = HabitFormValues(startDate: today);
  HabitFormState editing({HabitFormValues? now, bool showErrors = false}) =>
      HabitFormState(
        status: HabitFormStatus.editing,
        original: values,
        values: now ?? values,
        showErrors: showErrors,
      );

  Future<void> pump(
    WidgetTester tester,
    HabitFormState state, {
    TargetPlatform platform = TargetPlatform.android,
  }) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      BlocProvider<HabitFormCubit>.value(
        value: cubit,
        child: const HabitFormView(),
      ),
      theme: AppTheme.light().copyWith(platform: platform),
    );
  }

  testWidgets('a new habit: Save, the fields, no Delete', (tester) async {
    await pump(tester, editing());

    expect(find.text('New habit'), findsOneWidget);
    expect(find.text('Name'), findsOneWidget);
    expect(find.text('Every day.'), findsOneWidget);
    expect(find.text('1 time a day'), findsOneWidget);
    expect(find.text('Delete habit'), findsNothing);

    await tester.tap(find.text('Save'));
    verify(() => cubit.save()).called(1);
  });

  testWidgets('errors show under the fields after a first Save', (
    tester,
  ) async {
    await pump(
      tester,
      editing(
        now: values.copyWith(kind: ScheduleKind.onWeekdays, weekdays: {}),
        showErrors: true,
      ),
    );

    expect(find.text('Give the habit a name'), findsOneWidget);
    expect(find.text('Pick at least one day'), findsOneWidget);
  });

  testWidgets('each schedule shows its own choice', (tester) async {
    await pump(
      tester,
      editing(now: values.copyWith(kind: ScheduleKind.timesPerWeek)),
    );

    expect(find.text('3 times a week, any days'), findsOneWidget);
    expect(find.byTooltip('More times a week'), findsOneWidget);
  });

  testWidgets('on chosen days, the weekdays read in full', (tester) async {
    final handle = tester.ensureSemantics();
    await pump(
      tester,
      editing(now: values.copyWith(kind: ScheduleKind.onWeekdays)),
    );

    await tester.tap(find.text('Sat'));
    verify(() => cubit.weekdayToggled(6)).called(1);
    expect(find.bySemanticsLabel('Saturday'), findsOneWidget);
    handle.dispose();
  });

  testWidgets('a color is a button a screen reader can press', (tester) async {
    final handle = tester.ensureSemantics();
    await pump(tester, editing());

    final teal = find.bySemanticsLabel('Teal');
    expect(
      tester.getSemantics(teal),
      isSemantics(isButton: true, hasTapAction: true, isSelected: false),
    );
    expect(
      tester.getSemantics(find.bySemanticsLabel('Green')),
      isSemantics(isSelected: true),
    );
    await tester.tap(teal);
    verify(() => cubit.colorChanged(HabitColor.teal)).called(1);
    handle.dispose();
  });

  testWidgets('a reminder shows its time', (tester) async {
    await pump(
      tester,
      editing(now: values.copyWith(reminder: TimeOfDayValue(7, 30))),
    );

    // In the device's format: tests run with a 12-hour clock (and intl puts
    // a narrow no-break space before "AM").
    expect(find.textContaining(RegExp(r'^7:30\sAM$')), findsOneWidget);
  });

  testWidgets('an existing habit offers Delete', (tester) async {
    when(() => cubit.isNew).thenReturn(false);
    await pump(tester, editing());

    expect(find.text('Edit habit'), findsOneWidget);
    expect(find.text('Delete habit'), findsOneWidget);
  });

  testWidgets('Close with changes asks first; Discard leaves', (tester) async {
    await pump(tester, editing(now: values.copyWith(title: 'Read')));

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.text('Discard changes?'), findsOneWidget);

    await tester.tap(find.text('Discard'));
    await tester.pumpAndSettle();
    verify(() => cubit.discard()).called(1);
  });

  // material_ui's adaptive switch paints its iOS look itself (there's no
  // CupertinoSwitch to find); it's checked on the simulator instead.
  testWidgets('on iOS, the discard dialog is an iOS alert', (tester) async {
    await pump(
      tester,
      editing(now: values.copyWith(title: 'Read')),
      platform: TargetPlatform.iOS,
    );

    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(find.byType(CupertinoDialogAction), findsNWidgets(2));
  });
}
