import 'package:material_ui/material_ui.dart';
import 'package:momentum/app/momentum_app.dart';
import 'package:momentum/di/injection.dart';

void main() {
  // Bindings must exist before any setup touches plugins or assets.
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(const MomentumApp());
}
