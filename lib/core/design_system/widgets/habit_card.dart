import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/formatting/date_labels.dart';
import 'package:momentum/core/design_system/formatting/labels.dart';
import 'package:momentum/core/design_system/large_text.dart';
import 'package:momentum/core/design_system/theme/app_colors.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';
import 'package:momentum/core/design_system/theme/habit_visuals.dart';
import 'package:momentum/core/design_system/widgets/habit_avatar.dart';
import 'package:momentum/domain/calculation/habit_history.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/habit_overviews.dart';

/// An entry in a habit card's menu.
class HabitAction {
  const HabitAction(this.label, this.icon, this.onSelected);

  final String label;
  final IconData icon;
  final VoidCallback onSelected;
}

/// A habit as it stands today: its name, schedule and streak, today's
/// state as an icon and a word (never color alone), and its actions.
///
/// - Tapping the card opens the habit.
/// - A once-a-day habit has a check button: tap to complete, tap again to
///   undo. A counted habit ("8 glasses") has a +1 button instead.
/// - Everything else (skip, undo, archive) is in the menu.
///
/// The tap target merges the text, so a screen reader hears one button;
/// the action buttons stay separate (as DevJourney's cards do).
class HabitCard extends StatelessWidget {
  const HabitCard({
    super.key,
    required this.item,
    required this.today,
    required this.onOpen,
    this.onCheckIn,
    this.onUndo,
    this.actions = const [],
  });

  final HabitToday item;
  final CalendarDate today;
  final VoidCallback onOpen;

  /// Completes the habit, or adds one check-in to a counted habit.
  final VoidCallback? onCheckIn;

  /// Clears today, on a done once-a-day habit's check button.
  final VoidCallback? onUndo;
  final List<HabitAction> actions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final habit = item.habit;
    final counted = habit.dailyTarget > 1;
    final streak = streakLabel(item.streak);
    final (status, stateForLook) = _status();
    final statusColor = stateForLook.color(context);
    final details = Row(
      children: [
        HabitAvatar(icon: habit.icon, color: habit.color),
        const SizedBox(width: AppSpacing.small),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(habit.title, style: theme.textTheme.titleMedium),
              Text(
                scheduleLabel(habit.schedule, dailyTarget: habit.dailyTarget),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.xxSmall),
              Wrap(
                spacing: AppSpacing.small,
                runSpacing: AppSpacing.xxSmall,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _Tag(
                    icon: stateForLook.icon,
                    text: status,
                    color: statusColor,
                  ),
                  if (streak != null)
                    _Tag(
                      icon: Icons.local_fire_department,
                      text: streak,
                      color: context.appColors.streak,
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    final body = MergeSemantics(
      child: Semantics(
        button: true,
        child: InkWell(
          onTap: onOpen,
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.small),
            child: details,
          ),
        ),
      ),
    );
    final done = item.state == DayState.done;
    final buttons = <Widget>[
      if (counted && onCheckIn != null)
        IconButton.filledTonal(
          tooltip: 'Add one to ${habit.title}',
          onPressed: onCheckIn,
          icon: const Icon(Icons.add),
        )
      else if (!counted && done && onUndo != null)
        IconButton(
          tooltip: 'Mark ${habit.title} not done',
          onPressed: onUndo,
          icon: Icon(Icons.check_circle, color: context.appColors.done),
        )
      else if (!counted && !done && onCheckIn != null)
        IconButton(
          tooltip: 'Mark ${habit.title} done',
          onPressed: onCheckIn,
          icon: const Icon(Icons.radio_button_unchecked),
        ),
      if (actions.isNotEmpty)
        PopupMenuButton<HabitAction>(
          tooltip: 'More for ${habit.title}',
          onSelected: (action) => action.onSelected(),
          itemBuilder: (_) => [
            for (final action in actions)
              PopupMenuItem(
                value: action,
                child: ListTile(
                  leading: Icon(action.icon),
                  title: Text(action.label),
                  contentPadding: EdgeInsets.zero,
                ),
              ),
          ],
        ),
    ];
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.medium,
        vertical: AppSpacing.xxSmall,
      ),
      clipBehavior: Clip.antiAlias,
      // At large text the buttons go under the text, which then has the
      // card's whole width.
      child: context.prefersStackedLayout
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                body,
                if (buttons.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(
                      right: AppSpacing.xxSmall,
                      bottom: AppSpacing.xxSmall,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: buttons,
                    ),
                  ),
              ],
            )
          : Row(
              children: [
                Expanded(child: body),
                ...buttons,
                const SizedBox(width: AppSpacing.xxSmall),
              ],
            ),
    );
  }

  /// Today's status in words, and the state whose look it takes.
  (String, DayState) _status() {
    final habit = item.habit;
    final target = habit.dailyTarget;
    if (habit.archivedAt != null) return ('Archived', DayState.none);
    if (habit.startDate > today) {
      return (
        'Starts ${DateLabels.day(habit.startDate, today: today)}',
        DayState.none,
      );
    }
    return switch (item.state) {
      DayState.done when target > 1 => (
        'Done · ${item.count} / $target',
        DayState.done,
      ),
      DayState.done => ('Done', DayState.done),
      DayState.partial => ('${item.count} / $target today', DayState.partial),
      DayState.skipped => ('Skipped today', DayState.skipped),
      DayState.open when target > 1 => ('0 / $target today', DayState.open),
      DayState.open => ('To do today', DayState.open),
      _ => ('Not due today', DayState.none),
    };
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.text, required this.color});

  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: AppSpacing.xxSmall),
        Flexible(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge
                ?.copyWith(color: color),
          ),
        ),
      ],
    );
  }
}
