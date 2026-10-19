import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/theme/app_spacing.dart';
import 'package:momentum/core/design_system/widgets/app_sheet.dart';
import 'package:momentum/domain/model/time_of_day_value.dart';

/// Picks a time the platform's way: Material's clock dialog on Android, a
/// wheel in a bottom sheet on iOS (as in DevJourney). `null` if dismissed.
Future<TimeOfDayValue?> pickTime(
  BuildContext context,
  TimeOfDayValue initial, {
  required String title,
}) async {
  if (Theme.of(context).platform == TargetPlatform.iOS) {
    return showAppSheet<TimeOfDayValue>(
      context,
      (_) => _CupertinoTimeSheet(initial: initial, title: title),
    );
  }
  final picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay(hour: initial.hour, minute: initial.minute),
    helpText: title,
  );
  return picked == null ? null : TimeOfDayValue(picked.hour, picked.minute);
}

class _CupertinoTimeSheet extends StatefulWidget {
  const _CupertinoTimeSheet({required this.initial, required this.title});

  final TimeOfDayValue initial;
  final String title;

  @override
  State<_CupertinoTimeSheet> createState() => _CupertinoTimeSheetState();
}

class _CupertinoTimeSheetState extends State<_CupertinoTimeSheet> {
  late TimeOfDayValue _time = widget.initial;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.medium,
        0,
        AppSpacing.medium,
        AppSpacing.medium,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(widget.title, style: theme.textTheme.titleLarge),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(_time),
                child: const Text('Done'),
              ),
            ],
          ),
          SizedBox(
            height: 216,
            child: CupertinoTheme(
              data: CupertinoThemeData(brightness: theme.brightness),
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.time,
                initialDateTime: DateTime(
                  2026,
                  1,
                  1,
                  widget.initial.hour,
                  widget.initial.minute,
                ),
                onDateTimeChanged: (value) =>
                    _time = TimeOfDayValue(value.hour, value.minute),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
