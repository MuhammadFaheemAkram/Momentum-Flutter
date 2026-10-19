import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/common/calendar_clock.dart';
import 'package:momentum/core/database/daos/habit_logs_dao.dart';
import 'package:momentum/core/database/daos/habits_dao.dart';
import 'package:momentum/core/database/daos/user_data_dao.dart';
import 'package:momentum/core/network/momentum_service.dart';
import 'package:momentum/di/injection.dart';
import 'package:momentum/domain/repository/demo_repository.dart';
import 'package:momentum/domain/repository/habit_log_repository.dart';
import 'package:momentum/domain/repository/habit_repository.dart';
import 'package:momentum/domain/repository/settings_repository.dart';
import 'package:momentum/features/habit_detail/cubit/habit_detail_cubit.dart';
import 'package:momentum/features/habit_form/cubit/habit_form_cubit.dart';
import 'package:momentum/features/habits/cubit/habits_cubit.dart';
import 'package:momentum/features/today/cubit/today_cubit.dart';
import 'package:momentum/features/welcome/cubit/welcome_cubit.dart';

import '../helpers/test_dependencies.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  tearDown(getIt.reset);

  // A smoke test of the real composition root (with the database in memory).
  // A dependency injectable can't resolve only fails when its type is first
  // resolved, at runtime; resolving the top of each graph here catches it in
  // CI. Every new Cubit, repository and service belongs here.
  test('the real container resolves every Cubit, repository and DAO', () async {
    await configureTestDependencies();

    expect(getIt<SettingsRepository>(), same(getIt<SettingsRepository>()));
    expect(getIt<MomentumService>(), isNotNull);
    expect(getIt<UserDataDao>(), isNotNull);
    expect(getIt<HabitLogsDao>(), isNotNull);
    expect(getIt<DemoRepository>(), isNotNull);
    expect(getIt<HabitsDao>(), isNotNull);
    expect(getIt<HabitRepository>(), isNotNull);
    expect(getIt<HabitLogRepository>(), isNotNull);
    expect(getIt<CalendarClock>(), same(getIt<CalendarClock>()));
    await getIt<WelcomeCubit>().close();
    await getIt<TodayCubit>().close();
    await getIt<HabitsCubit>().close();
    await getIt<HabitFormCubit>().close();
    await getIt<HabitDetailCubit>(param1: 'h').close();
  });
}
