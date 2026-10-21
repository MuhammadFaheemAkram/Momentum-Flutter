import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';
import 'package:momentum/core/navigation/app_routes.dart';
import 'package:momentum/domain/model/app_settings.dart';
import 'package:momentum/domain/model/calendar_date.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';
import 'package:momentum/features/settings/cubit/settings_cubit.dart';
import 'package:momentum/features/settings/cubit/settings_tools_cubit.dart';
import 'package:momentum/features/settings/cubit/settings_tools_state.dart';
import 'package:momentum/features/settings/widgets/planned_notifications_sheet.dart';
import 'package:momentum/features/shell/shell_drawer_scope.dart';

/// Appearance, notifications, backup, data, developer tools and About.
/// Switches are adaptive (an iOS switch on iOS), as is the time picker.
class SettingsView extends StatelessWidget {
  const SettingsView({super.key, required this.version});

  /// "1.0.0 (1)".
  final String version;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsToolsCubit, SettingsToolsState>(
          listenWhen: (previous, current) =>
              previous.messageSerial != current.messageSerial,
          listener: (context, state) => ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.message ?? ''))),
        ),
        BlocListener<SettingsToolsCubit, SettingsToolsState>(
          listenWhen: (previous, current) =>
              previous.planSerial != current.planSerial,
          listener: (context, state) => showAppSheet<void>(
            context,
            (_) => PlannedNotificationsSheet(
              preview: state.plan!,
              today: state.today,
            ),
          ),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: const DrawerMenuButton(),
          title: const Text('Settings'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.large),
          children: [
            const SectionHeader('Appearance'),
            const _Appearance(),
            const SectionHeader('Notifications'),
            const _Notifications(),
            const SectionHeader('Backup'),
            const _Backup(),
            const SectionHeader('Data'),
            const _Data(),
            const SectionHeader('Developer'),
            const _Developer(),
            const SectionHeader('About'),
            ListTile(
              leading: const Icon(Icons.info_outline),
              title: const Text('About Momentum'),
              subtitle: Text('Version $version'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => const AboutRoute().push<void>(context),
            ),
          ],
        ),
      ),
    );
  }
}

/// A progress indicator the size of a tile's trailing icon.
const _busy = SizedBox.square(
  dimension: 24,
  child: CircularProgressIndicator.adaptive(strokeWidth: 2),
);

/// A switch tile's leading icon, left out at large text: with the switch at
/// the other end, a title like "Notifications" would break mid-word.
Widget? _switchIcon(BuildContext context, IconData icon) =>
    context.prefersStackedLayout ? null : Icon(icon);

/// "20:00", or "8:00 PM" where the device uses a 12-hour clock.
String _time(BuildContext context, TimeOfDayValue time) => DateLabels.time(
  time,
  use24HourFormat: MediaQuery.alwaysUse24HourFormatOf(context),
);

class _Appearance extends StatelessWidget {
  const _Appearance();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SettingsCubit>();
    final state = context.watch<SettingsCubit>().state;
    final mode = state.settings.themeMode;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Three segments fit a phone at normal sizes; at large text a radio
        // list keeps every label whole.
        if (context.prefersStackedLayout)
          RadioGroup<AppThemeMode>(
            groupValue: mode,
            onChanged: (mode) {
              if (mode != null) cubit.setThemeMode(mode);
            },
            child: Column(
              children: [
                for (final option in AppThemeMode.values)
                  RadioListTile<AppThemeMode>(
                    value: option,
                    title: Text(option.label),
                  ),
              ],
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.medium,
              vertical: AppSpacing.xSmall,
            ),
            child: SegmentedChoice<AppThemeMode>(
              values: AppThemeMode.values,
              labelOf: (mode) => mode.label,
              selected: mode,
              onSelected: cubit.setThemeMode,
            ),
          ),
        if (state.deviceColors.supportsDynamicColor)
          SwitchListTile.adaptive(
            title: const Text('Dynamic color'),
            subtitle: const Text('Use the colors of your wallpaper'),
            value: state.settings.dynamicColor,
            onChanged: (enabled) => cubit.setDynamicColor(enabled: enabled),
          ),
      ],
    );
  }
}

class _Notifications extends StatelessWidget {
  const _Notifications();

  @override
  Widget build(BuildContext context) {
    final tools = context.read<SettingsToolsCubit>();
    final toolsState = context.watch<SettingsToolsCubit>().state;
    final settings = context.watch<SettingsCubit>().state.settings;
    final on = settings.notificationsEnabled;

    Future<void> pick(
      TimeOfDayValue current,
      String title,
      Future<void> Function(TimeOfDayValue time) save,
    ) async {
      final picked = await pickTime(context, current, title: title);
      if (picked != null) await save(picked);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SwitchListTile.adaptive(
          secondary: _switchIcon(context, Icons.notifications_outlined),
          title: const Text('Notifications'),
          subtitle: const Text(
            "Habit reminders, the evening nudge and the day's summary",
          ),
          value: on,
          onChanged: toolsState.running == SettingsTask.notifications
              ? null
              : (enabled) => tools.setNotificationsEnabled(enabled: enabled),
        ),
        if (toolsState.notificationsDenied && !on)
          _DeniedCard(onOpenSettings: tools.openNotificationSettings),
        if (on) ...[
          SwitchListTile.adaptive(
            secondary: _switchIcon(context, Icons.pending_actions),
            title: const Text('Missed-habit nudge'),
            subtitle: Text(
              'At ${_time(context, settings.nudgeTime)}, if habits are '
              'still open',
            ),
            value: settings.nudgeEnabled,
            onChanged: (enabled) => tools.setNudge(enabled: enabled),
          ),
          if (settings.nudgeEnabled)
            _TimeTile(
              title: 'Nudge time',
              time: _time(context, settings.nudgeTime),
              onTap: () => pick(
                settings.nudgeTime,
                'Nudge time',
                (time) => tools.setNudge(time: time),
              ),
            ),
          SwitchListTile.adaptive(
            secondary: _switchIcon(context, Icons.insights_outlined),
            title: const Text('Daily summary'),
            subtitle: Text(
              'At ${_time(context, settings.summaryTime)}: how the day went',
            ),
            value: settings.summaryEnabled,
            onChanged: (enabled) => tools.setSummary(enabled: enabled),
          ),
          if (settings.summaryEnabled)
            _TimeTile(
              title: 'Summary time',
              time: _time(context, settings.summaryTime),
              onTap: () => pick(
                settings.summaryTime,
                'Summary time',
                (time) => tools.setSummary(time: time),
              ),
            ),
        ],
        ListTile(
          leading: const Icon(Icons.alarm),
          title: const Text('Default reminder time'),
          subtitle: Text(
            'For new habits: ${_time(context, settings.defaultReminder)}',
          ),
          trailing: const Icon(Icons.edit_outlined),
          onTap: () => pick(
            settings.defaultReminder,
            'Default reminder time',
            tools.setDefaultReminder,
          ),
        ),
      ],
    );
  }
}

class _TimeTile extends StatelessWidget {
  const _TimeTile({
    required this.title,
    required this.time,
    required this.onTap,
  });

  final String title;
  final String time;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.schedule),
      title: Text(title),
      subtitle: Text(time),
      trailing: const Icon(Icons.edit_outlined),
      onTap: onTap,
    );
  }
}

/// Permission was denied: only the system settings can change that now.
class _DeniedCard extends StatelessWidget {
  const _DeniedCard({required this.onOpenSettings});

  final VoidCallback onOpenSettings;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.onSecondaryContainer;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        0,
        AppSpacing.medium,
        AppSpacing.xSmall,
      ),
      child: Card(
        margin: EdgeInsets.zero,
        color: theme.colorScheme.secondaryContainer,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.small),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.notifications_off_outlined, color: color),
                  const SizedBox(width: AppSpacing.xSmall),
                  Expanded(
                    child: Text(
                      'Notifications are off for Momentum. Allow them in '
                      'the system settings to get reminders.',
                      style: theme.textTheme.bodyMedium?.copyWith(color: color),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: TextButton(
                  onPressed: onOpenSettings,
                  child: const Text('Open settings'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Backup extends StatelessWidget {
  const _Backup();

  @override
  Widget build(BuildContext context) {
    final tools = context.read<SettingsToolsCubit>();
    final toolsState = context.watch<SettingsToolsCubit>().state;
    final settings = context.watch<SettingsCubit>().state.settings;
    final last = settings.lastBackupAt;
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.cloud_upload_outlined),
          title: const Text('Back up now'),
          subtitle: Text(
            last == null
                ? 'Never backed up'
                : 'Last backup: '
                      '${DateLabels.day(CalendarDate.fromDateTime(last), today: toolsState.today)}, '
                      '${_time(context, TimeOfDayValue(last.hour, last.minute))}',
          ),
          trailing: toolsState.running == SettingsTask.backup ? _busy : null,
          enabled: toolsState.running == null,
          onTap: tools.backUpNow,
        ),
        SwitchListTile.adaptive(
          secondary: _switchIcon(context, Icons.cloud_sync_outlined),
          title: const Text('Automatic backup'),
          subtitle: const Text('Once a day, in the background'),
          value: settings.autoBackup,
          onChanged: (enabled) => tools.setAutoBackup(enabled: enabled),
        ),
      ],
    );
  }
}

class _Data extends StatelessWidget {
  const _Data();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tools = context.read<SettingsToolsCubit>();
    final running = context.watch<SettingsToolsCubit>().state.running;
    return ListTile(
      leading: Icon(Icons.restart_alt, color: theme.colorScheme.error),
      title: Text(
        'Reset progress',
        style: TextStyle(color: theme.colorScheme.error),
      ),
      subtitle: const Text(
        'Check-ins, routine check-offs and badges. Habits, routines, goals '
        'and settings stay.',
      ),
      trailing: running == SettingsTask.reset ? _busy : null,
      enabled: running == null,
      onTap: () async {
        final confirmed = await showConfirmDialog(
          context,
          title: 'Reset your progress?',
          message:
              'Every check-in, routine check-off and badge goes, and your '
              'streaks with them. Your habits, routines and goals stay. This '
              'can’t be undone.',
          confirmLabel: 'Reset',
          destructive: true,
        );
        if (confirmed) await tools.resetProgress();
      },
    );
  }
}

class _Developer extends StatelessWidget {
  const _Developer();

  @override
  Widget build(BuildContext context) {
    final tools = context.read<SettingsToolsCubit>();
    final state = context.watch<SettingsToolsCubit>().state;
    return Column(
      children: [
        SwitchListTile.adaptive(
          secondary: _switchIcon(context, Icons.wifi_off),
          title: const Text('Simulate network failure'),
          subtitle: const Text('The demo and backups fail, as offline'),
          value: state.failRequests,
          onChanged: (enabled) => tools.setFailRequests(enabled: enabled),
        ),
        ListTile(
          leading: const Icon(Icons.play_circle_outline),
          title: const Text('Run background tasks now'),
          subtitle: const Text(
            'What the system runs in the background: badges, the automatic '
            'backup, notifications',
          ),
          trailing: state.running == SettingsTask.backgroundTasks
              ? _busy
              : null,
          enabled: state.running == null,
          onTap: tools.runBackgroundTasks,
        ),
        ListTile(
          leading: const Icon(Icons.event_note_outlined),
          title: const Text('Show planned notifications'),
          subtitle: const Text('The next 7 days, as planned now'),
          trailing: state.running == SettingsTask.plan ? _busy : null,
          enabled: state.running == null,
          onTap: tools.showPlan,
        ),
      ],
    );
  }
}
