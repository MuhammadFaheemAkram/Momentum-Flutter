import 'package:material_ui/material_ui.dart';

/// Shows an editor or a picker as a modal bottom sheet, and
/// returns what it pops with.
///
/// - On the root navigator, so it covers the tab bar (conventions §11.46).
/// - Scroll-controlled, and padded by the keyboard's height, so a field near
///   the bottom stays visible while typing.
Future<T?> showAppSheet<T>(BuildContext context, WidgetBuilder builder) {
  return showModalBottomSheet<T>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: builder(context),
    ),
  );
}
