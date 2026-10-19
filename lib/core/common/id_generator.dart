import 'dart:math';

import 'package:injectable/injectable.dart';

/// Makes ids for records the user creates, such as `habit_3fa94c1e0b7d22a8`.
///
/// Injected rather than called statically, so tests can pass a seeded
/// [Random] and get repeatable ids. Sixty-four random bits make a collision
/// on one device practically impossible.
@lazySingleton
class IdGenerator {
  IdGenerator({@ignoreParam Random? random})
    : _random = random ?? Random.secure();

  final Random _random;

  /// An id such as `habit_3fa94c1e0b7d22a8` for `next('habit')`.
  String next(String prefix) =>
      '${prefix}_${List.generate(16, (_) => _random.nextInt(16).toRadixString(16)).join()}';
}
