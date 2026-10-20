import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:momentum/domain/model/analytics.dart';

part 'analytics_state.freezed.dart';

enum AnalyticsStatus { loading, ready, failed }

@freezed
abstract class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState({
    @Default(AnalyticsStatus.loading) AnalyticsStatus status,
    AnalyticsOverview? overview,
  }) = _AnalyticsState;
}
