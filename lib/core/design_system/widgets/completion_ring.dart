import 'package:material_ui/material_ui.dart';

/// Today's progress: a ring with "3 / 5" inside. Screen readers hear "3 of
/// 5 habits done today".
class CompletionRing extends StatelessWidget {
  const CompletionRing({
    super.key,
    required this.done,
    required this.due,
    this.size = 88,
  });

  final int done;
  final int due;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Semantics(
      label: due == 0 ? 'Nothing due today' : '$done of $due habits done today',
      excludeSemantics: true,
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CircularProgressIndicator(
              value: due == 0 ? 0 : done / due,
              strokeWidth: size / 10,
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
              strokeCap: StrokeCap.round,
            ),
            Center(
              child: FittedBox(
                child: Padding(
                  padding: EdgeInsets.all(size / 5),
                  child: Text(
                    '$done / $due',
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
