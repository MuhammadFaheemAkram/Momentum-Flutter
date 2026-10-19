import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/domain/model/habit_enums.dart';
import 'package:momentum/domain/model/routine.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_cubit.dart';
import 'package:momentum/features/routine_editor/cubit/routine_editor_state.dart';

/// A routine's name, time of day and steps.
///
/// - Steps are dragged by their handle to reorder. Screen readers get
///   `ReorderableListView`'s own actions instead: Move up, Move down, Move to
///   the start, Move to the end.
/// - **Save** writes the routine and every step's position at once; an
///   untouched routine just closes.
/// - **Discard guard** on Close, Back and the Android back gesture.
class RoutineEditorView extends StatelessWidget {
  const RoutineEditorView({super.key});

  static void _leave(BuildContext context, RoutineEditorExit exit) {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop(exit);
    } else {
      const RoutinesRoute().go(context);
    }
  }

  static Future<void> _close(BuildContext context) async {
    final cubit = context.read<RoutineEditorCubit>();
    if (!cubit.state.isDirty) {
      _leave(context, const RoutineDiscarded());
      return;
    }
    final discard = await showConfirmDialog(
      context,
      title: 'Discard changes?',
      message: 'Your changes to this routine will be lost.',
      confirmLabel: 'Discard',
      destructive: true,
    );
    if (discard && context.mounted) cubit.discard();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RoutineEditorCubit>();
    final state = context.watch<RoutineEditorCubit>().state;
    return MultiBlocListener(
      listeners: [
        BlocListener<RoutineEditorCubit, RoutineEditorState>(
          listenWhen: (previous, current) =>
              previous.exit == null && current.exit != null,
          listener: (context, state) => _leave(context, state.exit!),
        ),
        BlocListener<RoutineEditorCubit, RoutineEditorState>(
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
            title: Text(cubit.isNew ? 'New routine' : 'Edit routine'),
            actions: [
              if (state.status == RoutineEditorStatus.editing)
                TextButton(
                  onPressed: state.saving ? null : cubit.save,
                  child: const Text('Save'),
                ),
              const SizedBox(width: AppSpacing.xSmall),
            ],
          ),
          body: switch (state.status) {
            RoutineEditorStatus.loading => const LoadingView(
              message: 'Opening the routine…',
            ),
            RoutineEditorStatus.notFound => EmptyStateView(
              icon: Icons.search_off,
              title: "This routine doesn't exist any more",
              action: FilledButton.tonal(
                onPressed: () => const RoutinesRoute().go(context),
                child: const Text('Go to Routines'),
              ),
            ),
            RoutineEditorStatus.editing => _Editor(state: state),
          },
        ),
      ),
    );
  }
}

class _Editor extends StatefulWidget {
  const _Editor({required this.state});

  final RoutineEditorState state;

  @override
  State<_Editor> createState() => _EditorState();
}

class _EditorState extends State<_Editor> {
  late final _title = TextEditingController(text: widget.state.draft!.title);

  /// One controller per step, by the step's id: a step keeps its text (and
  /// its cursor) wherever it's moved.
  final _steps = <String, TextEditingController>{};

  /// The step just added, to focus.
  String? _focusId;

  TextEditingController _controllerFor(RoutineItem item) => _steps.putIfAbsent(
    item.id,
    () => TextEditingController(text: item.title),
  );

  @override
  void didUpdateWidget(_Editor oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Forget the controllers of removed steps.
    final ids = {for (final item in widget.state.draft!.items) item.id};
    for (final id in [..._steps.keys]) {
      if (!ids.contains(id)) _steps.remove(id)!.dispose();
    }
  }

  @override
  void dispose() {
    _title.dispose();
    for (final controller in _steps.values) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _delete() async {
    final cubit = context.read<RoutineEditorCubit>();
    final confirmed = await showConfirmDialog(
      context,
      title: 'Delete this routine?',
      message: 'Its steps and their check-offs go too.',
      confirmLabel: 'Delete',
      destructive: true,
    );
    if (confirmed) await cubit.delete();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RoutineEditorCubit>();
    final state = widget.state;
    final draft = state.draft!;
    final theme = Theme.of(context);
    final items = draft.items;
    Widget label(String text) => Padding(
      padding: const EdgeInsets.only(
        top: AppSpacing.medium,
        bottom: AppSpacing.xSmall,
      ),
      child: Semantics(
        // Its own node, so the flag doesn't spread (see SectionHeader).
        container: true,
        header: true,
        child: Text(text, style: theme.textTheme.titleSmall),
      ),
    );

    return ReorderableListView(
      buildDefaultDragHandles: false,
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.medium),
      onReorderItem: cubit.moveItem,
      header: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: AppSpacing.medium),
          TextField(
            controller: _title,
            onChanged: cubit.titleChanged,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Name',
              hintText: 'Morning',
              errorText: state.titleError,
            ),
          ),
          label('Time of day'),
          Wrap(
            spacing: AppSpacing.xSmall,
            runSpacing: AppSpacing.xSmall,
            children: [
              for (final time in RoutineTime.values)
                // No icon: a selected chip draws its check over it.
                ChoiceChip(
                  label: Text(time.label),
                  selected: time == draft.time,
                  onSelected: (_) => cubit.timeChanged(time),
                ),
            ],
          ),
          label('Steps'),
          Text(
            'Drag a step by its handle to reorder.',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          if (state.itemsError case final error?)
            Text(
              error,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
          const SizedBox(height: AppSpacing.xSmall),
        ],
      ),
      footer: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton.icon(
              onPressed: state.canAddItem
                  ? () => setState(() => _focusId = cubit.addItem())
                  : null,
              icon: const Icon(Icons.add),
              label: const Text('Add a step'),
            ),
          ),
          if (!cubit.isNew) ...[
            const SizedBox(height: AppSpacing.large),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
              ),
              onPressed: state.saving ? null : _delete,
              icon: const Icon(Icons.delete_outline),
              label: const Text('Delete routine'),
            ),
          ],
          const SizedBox(height: AppSpacing.large),
        ],
      ),
      children: [
        for (final (index, item) in items.indexed)
          Padding(
            key: ValueKey(item.id),
            padding: const EdgeInsets.only(bottom: AppSpacing.xSmall),
            child: Row(
              children: [
                ReorderableDragStartListener(
                  index: index,
                  // Screen readers move steps with the list's own actions.
                  child: const ExcludeSemantics(
                    child: SizedBox.square(
                      dimension: 48,
                      child: Icon(Icons.drag_handle),
                    ),
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _controllerFor(item),
                    autofocus: item.id == _focusId,
                    // Wraps, rather than scrolling out of sight at large
                    // text.
                    minLines: 1,
                    maxLines: 3,
                    onChanged: (title) => cubit.itemChanged(item.id, title),
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      labelText: 'Step ${index + 1}',
                      errorText: state.itemError(item),
                    ),
                  ),
                ),
                IconButton(
                  tooltip: 'Remove step ${index + 1}',
                  onPressed: () => cubit.removeItem(item.id),
                  icon: const Icon(Icons.remove_circle_outline),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
