import 'package:freezed_annotation/freezed_annotation.dart';

part 'welcome_state.freezed.dart';

/// How the user chose to start.
enum StartChoice { demo, empty }

@freezed
abstract class WelcomeState with _$WelcomeState {
  const factory WelcomeState({
    /// The start in progress, if any: both buttons wait for it.
    StartChoice? starting,

    /// Why the demo couldn't be loaded; the demo button then reads "Try
    /// again".
    String? errorMessage,
  }) = _WelcomeState;

  const WelcomeState._();

  bool get isStarting => starting != null;
}
