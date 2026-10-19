import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mocktail/mocktail.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_cubit.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_state.dart';
import 'package:momentum/features/routine_editor/routine_editor_view.dart';

import '../../helpers/pump_app.dart';

class _MockRoutineEditorCubit extends MockCubit<RoutineEditorState>
    implements RoutineEditorCubit {}

void main() {
  late _MockRoutineEditorCubit cubit;

  setUp(() {
    cubit = _MockRoutineEditorCubit();
    when(() => cubit.isNew).thenReturn(false);
    when(() => cubit.save()).thenAnswer((_) async {});
    when(() => cubit.addItem()).thenReturn('new');
    when(() => cubit.moveItem(any(), any())).thenReturn(null);
    when(() => cubit.removeItem(any())).thenReturn(null);
  });

  const draft = RoutineDraft(
    title: 'Morning',
    items: [
      RoutineItem(id: 'bed', title: 'Make the bed'),
      RoutineItem(id: 'stretch', title: 'Stretch'),
      RoutineItem(id: 'plan', title: 'Plan the day'),
    ],
  );
  const editing = RoutineEditorState(
    status: RoutineEditorStatus.editing,
    original: draft,
    draft: draft,
  );

  Future<void> pump(WidgetTester tester, RoutineEditorState state) {
    when(() => cubit.state).thenReturn(state);
    tester.useTallPhoneSurface();
    return tester.pumpThemed(
      BlocProvider<RoutineEditorCubit>.value(
        value: cubit,
        child: const RoutineEditorView(),
      ),
    );
  }

  testWidgets('the steps in order, each with its field and Remove', (
    tester,
  ) async {
    await pump(tester, editing);

    expect(find.widgetWithText(TextField, 'Step 1'), findsOneWidget);
    expect(find.text('Make the bed'), findsOneWidget);
    expect(find.text('Delete routine'), findsOneWidget);

    await tester.tap(find.byTooltip('Remove step 2'));
    verify(() => cubit.removeItem('stretch')).called(1);
  });

  testWidgets("screen readers move a step with the list's own actions", (
    tester,
  ) async {
    final handle = tester.ensureSemantics();
    await pump(tester, editing);

    // One node per step carries the actions; the middle one can go
    // anywhere.
    final steps = find.semantics
        .byPredicate(
          (node) =>
              node.getSemanticsData().customSemanticsActionIds?.isNotEmpty ??
              false,
        )
        .evaluate()
        .toList();
    expect(steps, hasLength(3));
    final node = steps[1];
    final actions = [
      for (final id in node.getSemanticsData().customSemanticsActionIds!)
        CustomSemanticsAction.getAction(id)!.label,
    ];
    expect(
      actions,
      containsAll([
        'Move up',
        'Move down',
        'Move to the start',
        'Move to the end',
      ]),
    );

    node.owner!.performAction(
      node.id,
      SemanticsAction.customAction,
      CustomSemanticsAction.getIdentifier(
        const CustomSemanticsAction(label: 'Move up'),
      ),
    );
    await tester.pump();
    verify(() => cubit.moveItem(1, 0)).called(1);
    handle.dispose();
  });

  testWidgets('errors show under the fields after a first Save', (
    tester,
  ) async {
    await pump(
      tester,
      editing.copyWith(
        draft: const RoutineDraft(
          title: '',
          items: [RoutineItem(id: 'a', title: '')],
        ),
        showErrors: true,
      ),
    );

    expect(find.text('Give the routine a name'), findsOneWidget);
    expect(find.text('Name this step, or remove it'), findsOneWidget);
  });

  testWidgets('a new routine has no Delete; Add a step adds one', (
    tester,
  ) async {
    when(() => cubit.isNew).thenReturn(true);
    await pump(tester, editing);

    expect(find.text('New routine'), findsOneWidget);
    expect(find.text('Delete routine'), findsNothing);
    await tester.tap(find.text('Add a step'));
    verify(() => cubit.addItem()).called(1);
  });
}
