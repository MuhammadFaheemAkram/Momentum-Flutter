import 'package:flutter_test/flutter_test.dart';
import 'package:momentum/core/navigation/first_launch_redirect.dart';

void main() {
  String? redirect({required bool onboarded, required String to}) =>
      firstLaunchRedirect(onboarded: onboarded, location: Uri.parse(to));

  group('before the first start', () {
    test('every location goes to Welcome', () {
      expect(redirect(onboarded: false, to: '/today'), welcomePath);
      expect(redirect(onboarded: false, to: '/habits/h1'), welcomePath);
      expect(redirect(onboarded: false, to: '/habits/new'), welcomePath);
    });

    test('Welcome itself stays', () {
      expect(redirect(onboarded: false, to: '/welcome'), isNull);
    });
  });

  group('after', () {
    test('Welcome goes to Today', () {
      expect(redirect(onboarded: true, to: '/welcome'), todayPath);
    });

    test('everything else stays where it is, query included', () {
      expect(redirect(onboarded: true, to: '/habits'), isNull);
      expect(redirect(onboarded: true, to: '/search?q=read'), isNull);
    });
  });
}
