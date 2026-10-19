import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:momentum/core/common/result.dart';
import 'package:momentum/domain/usecase/load_demo_use_case.dart';
import 'package:momentum/domain/usecase/start_empty_use_case.dart';
import 'package:momentum/features/welcome/cubit/welcome_state.dart';

/// First launch: explore with demo data, or start empty.
///
/// It never navigates: a successful start saves the onboarded setting, and
/// the router's gate reacts to it.
@injectable
class WelcomeCubit extends Cubit<WelcomeState> {
  WelcomeCubit(this._loadDemo, this._startEmpty) : super(const WelcomeState());

  final LoadDemoUseCase _loadDemo;
  final StartEmptyUseCase _startEmpty;

  /// Loads the demo (again, after a failure). A second tap while a start is
  /// running does nothing.
  Future<void> exploreDemo() async {
    if (state.isStarting) return;
    emit(const WelcomeState(starting: StartChoice.demo));
    final result = await _loadDemo();
    if (isClosed) return;
    emit(switch (result) {
      Ok() => const WelcomeState(),
      Err(:final exception) => WelcomeState(errorMessage: exception.message),
    });
  }

  Future<void> startEmpty() async {
    if (state.isStarting) return;
    emit(state.copyWith(starting: StartChoice.empty));
    await _startEmpty();
    if (isClosed) return;
    emit(const WelcomeState());
  }
}
