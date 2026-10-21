import 'dart:async';
import 'dart:developer';

import 'package:material_ui/material_ui.dart';
import 'package:momentum/app/momentum_app.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/service/background_work.dart';
import 'package:momentum/domain/service/notification_scheduler.dart';

Future<void> main() async {
  // Bindings must exist before any async setup touches plugins or assets.
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  unawaited(_registerBackgroundWork());
  // A reminder's tap that launched the app opens straight on its habit.
  final launch = await getIt<NotificationInteractions>().launchTarget();
  runApp(MomentumApp(initialLocation: MomentumApp.locationFor(launch)));
}

Future<void> _registerBackgroundWork() async {
  try {
    await getIt<BackgroundWork>().registerMaintenance();
  } on Object catch (error, stackTrace) {
    // Best effort: the app works without it, and the next launch retries.
    log(
      'Registering background work failed',
      error: error,
      stackTrace: stackTrace,
    );
  }
}
