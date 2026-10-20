import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/domain/usecase/achievement_use_cases.dart';
import 'package:momentum/features/achievements/cubit/achievements_state.dart';

/// The badges, live: progress moves as habits are done.
@injectable
class AchievementsCubit extends Cubit<AchievementsState> {
  AchievementsCubit(this._watchAchievements) : super(const AchievementsState());

  final WatchAchievementsUseCase _watchAchievements;
  StreamSubscription<Object?>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    emit(state.copyWith(status: AchievementsStatus.loading));
    _subscription = _watchAchievements().listen(
      (data) => emit(
        state.copyWith(
          status: AchievementsStatus.ready,
          today: data.today,
          statuses: data.statuses,
        ),
      ),
      onError: (Object error, StackTrace stackTrace) {
        log('Achievements failed', error: error, stackTrace: stackTrace);
        emit(state.copyWith(status: AchievementsStatus.failed));
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
