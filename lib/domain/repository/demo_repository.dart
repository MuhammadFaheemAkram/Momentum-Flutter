import 'package:momentum/core/common/result.dart';

/// The demo, from the fake service into the database.
abstract interface class DemoRepository {
  /// Fetches the demo and replaces the user's data with it, in one
  /// transaction: on any failure, nothing has changed.
  Future<Result<void>> loadDemo();
}
