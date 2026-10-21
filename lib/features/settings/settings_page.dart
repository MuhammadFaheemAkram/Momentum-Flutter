import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/model/device_info.dart';
import 'package:momentum/features/settings/cubit/settings_tools_cubit.dart';
import 'package:momentum/features/settings/settings_view.dart';

/// Settings (the last tab). The settings themselves come from the app-wide
/// `SettingsCubit`; this screen adds its own tools.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsToolsCubit>(),
      child: SettingsView(version: getIt<AppInfo>().versionLabel),
    );
  }
}
