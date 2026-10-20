import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/domain/usecase/analytics_search_use_cases.dart';
import 'package:momentum/features/analytics/cubit/analytics_state.dart';

/// The Analytics tab, live.
@injectable
class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit(this._watchAnalytics) : super(const AnalyticsState());

  final WatchAnalyticsUseCase _watchAnalytics;
  StreamSubscription<Object?>? _subscription;

  void start() {
    unawaited(_subscription?.cancel());
    emit(state.copyWith(status: AnalyticsStatus.loading));
    _subscription = _watchAnalytics().listen(
      (overview) => emit(
        state.copyWith(status: AnalyticsStatus.ready, overview: overview),
      ),
      onError: (Object error, StackTrace stackTrace) {
        log('Analytics failed', error: error, stackTrace: stackTrace);
        emit(state.copyWith(status: AnalyticsStatus.failed));
      },
    );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
