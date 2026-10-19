/// The app's error vocabulary.
///
/// Every failure that can reach the UI is one of these types, and each carries
/// a user-facing [message], so screens render a small, stable set of error
/// states instead of raw exceptions.
///
/// `sealed` lets the compiler check that a `switch` over an [AppException]
/// handles every subtype.
sealed class AppException implements Exception {
  const AppException(this.message);

  /// Copy that is safe to show to the user.
  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// The (fake) network call failed.
final class NetworkException extends AppException {
  const NetworkException()
    : super("Couldn't reach the server. Check your connection and try again.");
}

/// The data could not be decoded (malformed JSON, unexpected types, or a
/// record that breaks the app's rules, such as a log before its habit
/// started).
final class DataFormatException extends AppException {
  const DataFormatException()
    : super('The demo data looks damaged. Please try again.');
}

/// Anything unexpected that isn't one of the cases above.
final class UnknownException extends AppException {
  const UnknownException() : super('Something went wrong. Please try again.');
}
