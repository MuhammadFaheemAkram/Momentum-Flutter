import 'package:material_ui/material_ui.dart';
import 'package:momentum/app/momentum_app.dart';
import 'package:momentum/di/injection.dart';

Future<void> main() async {
  // Bindings must exist before any async setup touches plugins or assets.
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const MomentumApp());
}
