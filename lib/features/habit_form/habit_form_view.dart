import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_cubit.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_state.dart';

/// A habit's name, description, category, schedule, daily target, start
/// date, reminder, color and icon.
///
/// - **Save** in the app bar; an untouched habit just closes.
/// - Errors show under their fields after a first Save.
/// - **Discard guard:** Close, Back or the Android back gesture asks before
///   throwing edits away (`PopScope`).
/// - **Delete** (an existing habit) asks first: it takes the history too.
class HabitFormView extends StatelessWidget {
  const HabitFormView({super.key});

  /// Pops with how the form closed, or goes to Habits when it was opened by
  /// a link and is the only page (conventions §11.47).
  static void _leave(BuildContext context, HabitFormExit exit) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop(exit);
    } else {
      const HabitsRoute().go(context);
    }
  }

  static Future<void> _close(BuildContext context) async {
    final cubit = context.read<HabitFormCubit>();
    if (!cubit.state.isDirty) {
      _leave(context, const HabitDiscarded());
      return;
    }
    final discard = await showConfirmDialog(
      context,
      title: 'Discard changes?',
      message: 'Your changes to this habit will be lost.',
      confirmLabel: 'Discard',
      destructive: true,
    );
    if (discard && context.mounted) cubit.discard();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitFormCubit>();
    final state = context.watch<HabitFormCubit>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<HabitFormCubit, HabitFormState>(
          listenWhen: (previous, current) =>
              previous.exit == null && current.exit != null,
          // `Navigator.pop` isn't blocked by `PopScope` (only `maybePop` and
          // the system back are), so leaving works before the guard
          // rebuilds.
          listener: (context, state) => _leave(context, state.exit!),
        ),
        BlocListener<HabitFormCubit, HabitFormState>(
          listenWhen: (previous, current) =>
              previous.errorSerial != current.errorSerial,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage ?? ''))),
        ),
      ],
      child: PopScope<Object?>(
        canPop: !state.isDirty || state.exit != null,
        onPopInvokedWithResult: (didPop, _) {
          if (!didPop) _close(context);
        },
        child: Scaffold(
          appBar: AppBar(
            leading: CloseButton(onPressed: () => _close(context)),
            title: Text(cubit.isNew ? 'New habit' : 'Edit habit'),
            actions: [
              if (state.status == HabitFormStatus.editing)
                TextButton(
                  onPressed: state.saving ? null : cubit.save,
                  child: const Text('Save'),
                ),
              const SizedBox(width: AppSpacing.xSmall),
            ],
          ),
          body: switch (state.status) {
            HabitFormStatus.loading => const LoadingView(
              message: 'Opening the habit…',
            ),
            HabitFormStatus.notFound => EmptyStateView(
              icon: Icons.search_off,
              title: "This habit doesn't exist any more",
              action: FilledButton.tonal(
                onPressed: () => const HabitsRoute().go(context),
                child: const Text('Go to Habits'),
              ),
            ),
            HabitFormStatus.editing => _Fields(state: state),
          },
        ),
      ),
    );
  }
}

class _Fields extends StatefulWidget {
  const _Fields({required this.state});

  final HabitFormState state;

  @override
  State<_Fields> createState() => _FieldsState();
}

class _FieldsState extends State<_Fields> {
  late final _title = TextEditingController(text: widget.state.values!.title);
  late final _description = TextEditingController(
    text: widget.state.values!.description,
  );

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickStart(CalendarDate current) async {
    final cubit = context.read<HabitFormCubit>();
    final picked = await showDatePicker(
      context: context,
      initialDate: current.toDateTime(),
      firstDate: current.addDays(-365 * 5).toDateTime(),
      lastDate: current.addDays(365).toDateTime(),
      helpText: 'Starts on',
    );
    if (picked != null) {
      cubit.startDateChanged(CalendarDate.fromDateTime(picked));
    }
  }

  Future<void> _pickReminder(TimeOfDayValue current) async {
    final cubit = context.read<HabitFormCubit>();
    final picked = await pickTime(context, current, title: 'Remind me at');
    if (picked != null) cubit.reminderChanged(picked);
  }

  Future<void> _delete() async {
    final cubit = context.read<HabitFormCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete this habit?',
      message:
          'Its whole history and any goals on it go too. To keep the '
          'history, archive it instead.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (confirmed) await cubit.delete();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HabitFormCubit>();
    final state = widget.state;
    final values = state.values!;
    final theme = Theme.of(context);
    final use24Hour = MediaQuery.alwaysUse24HourFormatOf(context);
    const gap = SizedBox(height: AppSpacing.medium);
    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xSmall),
      child: Semantics(
        // Its own node: a heading flag on a merged node would make
        // everything around it a heading too.
        container: true,
        header: true,
        child: Text(text, style: theme.textTheme.titleSmall),
      ),
    );

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.medium),
      children: [
        TextField(
          controller: _title,
          onChanged: cubit.titleChanged,
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            labelText: 'Name',
            hintText: 'Drink water',
            errorText: state.titleError,
          ),
        ),
        gap,
        TextField(
          controller: _description,
          onChanged: cubit.descriptionChanged,
          textCapitalization: TextCapitalization.sentences,
          minLines: 1,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Description (optional)',
            errorText: state.descriptionError,
          ),
        ),
        gap,
        label('Category'),
        Wrap(
          spacing: AppSpacing.xSmall,
          runSpacing: AppSpacing.xSmall,
          children: [
            for (final category in HabitCategory.values)
              ChoiceChip(
                label: Text(category.label),
                selected: category == values.category,
                onSelected: (_) => cubit.categoryChanged(category),
              ),
          ],
        ),
        gap,
        label('How often'),
        SegmentedChoice<ScheduleKind>(
          values: ScheduleKind.values,
          labelOf: (kind) => switch (kind) {
            ScheduleKind.daily => 'Daily',
            ScheduleKind.onWeekdays => 'Some days',
            ScheduleKind.timesPerWeek => 'Times a week',
          },
          selected: values.kind,
          onSelected: cubit.kindChanged,
        ),
        const SizedBox(height: AppSpacing.small),
        switch (values.kind) {
          ScheduleKind.daily => Text(
            'Every day.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          ScheduleKind.onWeekdays => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WeekdayPicker(
                selected: values.weekdays,
                onToggled: cubit.weekdayToggled,
              ),
              if (state.chosenDaysError case final error?)
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.xxSmall),
                  child: Text(
                    error,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                ),
            ],
          ),
          ScheduleKind.timesPerWeek => CountStepper(
            value: values.timesPerWeek,
            min: HabitLimits.minTimesPerWeek,
            max: HabitLimits.maxTimesPerWeek,
            labelOf: (times) => '${countLabel(times, 'time')} a week, any days',
            decreaseTooltip: 'Fewer times a week',
            increaseTooltip: 'More times a week',
            onChanged: cubit.timesPerWeekChanged,
          ),
        },
        gap,
        label('Daily target'),
        CountStepper(
          value: values.dailyTarget,
          min: HabitLimits.minDailyTarget,
          max: HabitLimits.maxDailyTarget,
          labelOf: (target) => '${countLabel(target, 'time')} a day',
          decreaseTooltip: 'Fewer times a day',
          increaseTooltip: 'More times a day',
          onChanged: cubit.dailyTargetChanged,
        ),
        gap,
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const Icon(Icons.event_outlined),
          title: const Text('Starts'),
          subtitle: Text(DateLabels.short(values.startDate)),
          trailing: const Icon(Icons.edit_outlined),
          onTap: () => _pickStart(values.startDate),
        ),
        SwitchListTile.adaptive(
          contentPadding: EdgeInsets.zero,
          secondary: const Icon(Icons.notifications_outlined),
          title: const Text('Remind me'),
          subtitle: const Text('On the days it is due, until it is done'),
          value: values.reminder != null,
          onChanged: (on) =>
              cubit.reminderChanged(on ? TimeOfDayValue(9, 0) : null),
        ),
        if (values.reminder case final reminder?)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.schedule),
            title: const Text('At'),
            subtitle: Text(
              DateLabels.time(reminder, use24HourFormat: use24Hour),
            ),
            trailing: const Icon(Icons.edit_outlined),
            onTap: () => _pickReminder(reminder),
          ),
        gap,
        label('Color'),
        HabitColorPicker(
          selected: values.color,
          onSelected: cubit.colorChanged,
        ),
        gap,
        label('Icon'),
        HabitIconPicker(
          selected: values.icon,
          color: values.color,
          onSelected: cubit.iconChanged,
        ),
        if (!cubit.isNew) ...[
          const SizedBox(height: AppSpacing.large),
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: theme.colorScheme.error,
            ),
            onPressed: state.saving ? null : _delete,
            icon: const Icon(Icons.delete_outline),
            label: const Text('Delete habit'),
          ),
        ],
        const SizedBox(height: AppSpacing.large),
      ],
    );
  }
}
