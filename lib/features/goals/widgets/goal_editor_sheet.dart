import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/domain/calculation/validation.dart';
import 'package:momentum/domain/model/goal.dart';
import 'package:momentum/domain/model/habit.dart';
import 'package:momentum/domain/model/habit_enums.dart';

/// What the goal sheet decided.
sealed class GoalEditorResult {
  const GoalEditorResult();
}

final class SaveGoalResult extends GoalEditorResult {
  const SaveGoalResult(this.draft);

  final GoalDraft draft;
}

final class DeleteGoalResult extends GoalEditorResult {
  const DeleteGoalResult();
}

/// A goal's name, what it counts (all habits, or one), its period and its
/// target (1–200); Delete for an [existing] one. Errors show after a first
/// Save.
class GoalEditorSheet extends StatefulWidget {
  const GoalEditorSheet({
    super.key,
    required this.habits,
    this.existing,
    this.period = GoalPeriod.weekly,
  });

  /// Every habit: the active ones are offered, and an existing goal's own
  /// even if it has been archived since.
  final List<Habit> habits;
  final Goal? existing;

  /// For a new goal: the period it was added from.
  final GoalPeriod period;

  @override
  State<GoalEditorSheet> createState() => _GoalEditorSheetState();
}

class _GoalEditorSheetState extends State<GoalEditorSheet> {
  late final _title = TextEditingController(text: widget.existing?.title);
  late final _target = TextEditingController(
    text: '${widget.existing?.target ?? 10}',
  );
  late GoalPeriod _period = widget.existing?.period ?? widget.period;
  late bool _oneHabit = widget.existing?.scope is OneHabit;
  late String? _habitId = switch (widget.existing?.scope) {
    OneHabit(:final habitId) => habitId,
    _ => null,
  };
  bool _showErrors = false;

  @override
  void dispose() {
    _title.dispose();
    _target.dispose();
    super.dispose();
  }

  int? get _targetValue => int.tryParse(_target.text.trim());

  String? get _habitError =>
      _oneHabit && _habitId == null ? 'Pick the habit it counts' : null;

  void _save() {
    final target = _targetValue;
    if (goalTitleError(_title.text) != null ||
        goalTargetError(target) != null ||
        _habitError != null) {
      setState(() => _showErrors = true);
      return;
    }
    Navigator.of(context).pop(
      SaveGoalResult(
        GoalDraft(
          title: _title.text,
          scope: _oneHabit
              ? GoalScope.habit(_habitId!)
              : const GoalScope.allHabits(),
          period: _period,
          target: target!,
        ),
      ),
    );
  }

  Future<void> _delete(Goal goal) async {
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete “${goal.title}”?',
      message: 'Your habits and their history stay; only the goal goes.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (confirmed && mounted) {
      Navigator.of(context).pop(const DeleteGoalResult());
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final existing = widget.existing;
    // The active habits, and the goal's own even if it's archived since.
    final choices = [
      for (final habit in widget.habits)
        if (habit.archivedAt == null || habit.id == _habitId) habit,
    ];
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        0,
        AppSpacing.medium,
        AppSpacing.medium,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            existing == null ? 'New goal' : 'Edit goal',
            style: theme.textTheme.titleLarge,
          ),
          const SizedBox(height: AppSpacing.medium),
          TextField(
            controller: _title,
            autofocus: existing == null,
            textCapitalization: TextCapitalization.sentences,
            onChanged: (_) => setState(() {}),
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Complete 25 habits this week',
              errorText: _showErrors ? goalTitleError(_title.text) : null,
            ),
          ),
          _Section(
            title: 'What counts',
            child: Wrap(
              spacing: AppSpacing.xSmall,
              runSpacing: AppSpacing.xSmall,
              children: [
                ChoiceChip(
                  label: const Text('All habits'),
                  selected: !_oneHabit,
                  onSelected: (_) => setState(() => _oneHabit = false),
                ),
                ChoiceChip(
                  label: const Text('One habit'),
                  selected: _oneHabit,
                  onSelected: choices.isEmpty
                      ? null
                      : (_) => setState(() => _oneHabit = true),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.xxSmall),
            child: Text(
              choices.isEmpty
                  ? 'Each day a habit is done counts once. Add a habit to '
                        'aim at just one.'
                  : 'Each day a habit is done counts once.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          if (_oneHabit) ...[
            const SizedBox(height: AppSpacing.small),
            Wrap(
              spacing: AppSpacing.xSmall,
              runSpacing: AppSpacing.xSmall,
              children: [
                for (final habit in choices)
                  ChoiceChip(
                    label: Text(habit.title),
                    selected: habit.id == _habitId,
                    onSelected: (_) => setState(() => _habitId = habit.id),
                  ),
              ],
            ),
            if (_showErrors && _habitError != null)
              Padding(
                padding: const EdgeInsets.only(top: AppSpacing.xxSmall),
                child: Text(
                  _habitError!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
          ],
          _Section(
            title: 'How often',
            child: SegmentedChoice<GoalPeriod>(
              values: GoalPeriod.values,
              labelOf: (period) => period.label,
              selected: _period,
              onSelected: (period) => setState(() => _period = period),
            ),
          ),
          _Section(
            title: 'Target',
            child: TextField(
              controller: _target,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              onChanged: (_) => setState(() {}),
              decoration: InputDecoration(
                labelText: 'Completions ${_period.current}',
                helperText:
                    '${GoalLimits.minTarget} to ${GoalLimits.maxTarget}',
                errorText: _showErrors ? goalTargetError(_targetValue) : null,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.large),
          Row(
            children: [
              if (existing != null)
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: theme.colorScheme.error,
                  ),
                  onPressed: () => _delete(existing),
                  child: const Text('Delete'),
                ),
              const Spacer(),
              FilledButton(onPressed: _save, child: const Text('Save')),
            ],
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Semantics(
            // Its own node, so the flag doesn't spread (see SectionHeader).
            container: true,
            header: true,
            child: Text(title, style: Theme.of(context).textTheme.titleSmall),
          ),
          const SizedBox(height: AppSpacing.xSmall),
          child,
        ],
      ),
    );
  }
}
