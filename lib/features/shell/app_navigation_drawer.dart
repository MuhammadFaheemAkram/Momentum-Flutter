import 'package:material_ui/material_ui.dart';
import 'package:momentum/core/design_system/design_system.dart';

/// The five tabs, in the order of the shell's branches (`app_routes.dart`).
enum AppTab {
  today('Today', Icons.today_outlined, Icons.today),
  habits('Habits', Icons.checklist_outlined, Icons.checklist),
  analytics('Analytics', Icons.insights_outlined, Icons.insights),
  achievements(
    'Achievements',
    Icons.emoji_events_outlined,
    Icons.emoji_events,
    shortLabel: 'Badges',
  ),
  settings('Settings', Icons.settings_outlined, Icons.settings);

  const AppTab(this.label, this.icon, this.selectedIcon, {this.shortLabel});

  /// The screen's name: its app bar and the drawer.
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  /// The tab bar's label, when [label] is too long for it. Five share a
  /// phone's width: "Achievements" broke mid-word even at the default text
  /// size.
  final String? shortLabel;

  String get barLabel => shortLabel ?? label;
}

/// Where a drawer item leads: a tab, or a screen above the tabs.
sealed class DrawerDestination {
  const DrawerDestination();
}

final class TabDestination extends DrawerDestination {
  const TabDestination(this.index);

  final int index;
}

enum ScreenDestination implements DrawerDestination {
  routines('Routines', Icons.wb_twilight_outlined),
  goals('Goals', Icons.flag_outlined),
  search('Search', Icons.search),
  about('About', Icons.info_outline);

  const ScreenDestination(this.label, this.icon);

  final String label;
  final IconData icon;
}

/// The Android edition's navigation drawer: the five tabs, then the screens
/// that don't fit in a bottom bar (Routines, Goals, Search), then About.
///
/// Built from `ListTile`s rather than Material's `NavigationDrawer`: its
/// destinations lay the label out in a fixed row, which overflows at large
/// text sizes, while a `ListTile` wraps and grows (conventions §11.52). The
/// tiles keep the Material 3 look (a pill-shaped indicator on the current
/// tab) and report "selected" to screen readers.
///
/// Only a tab can be selected: the other destinations push a screen above
/// the shell, and the drawer is gone by the time it shows.
class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({
    super.key,
    required this.currentTab,
    required this.onSelected,
  });

  final int currentTab;
  final ValueChanged<DrawerDestination> onSelected;

  static const screens = [
    ScreenDestination.routines,
    ScreenDestination.goals,
    ScreenDestination.search,
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Drawer(
      // At large text, nearly the screen's width: at the standard 304
      // points, "Achievements" broke mid-word (seen at AX3 on an iPhone).
      width: context.prefersStackedLayout
          ? MediaQuery.sizeOf(context).width * 0.9
          : null,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.xSmall),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.large,
                AppSpacing.small,
                AppSpacing.medium,
                AppSpacing.small,
              ),
              child: Semantics(
                // Its own node: a heading flag on a merged node would make
                // everything around it a heading too.
                container: true,
                header: true,
                child: Text('Momentum', style: theme.textTheme.titleLarge),
              ),
            ),
            for (final tab in AppTab.values)
              _DrawerTile(
                icon: tab.index == currentTab ? tab.selectedIcon : tab.icon,
                label: tab.label,
                selected: tab.index == currentTab,
                onTap: () => onSelected(TabDestination(tab.index)),
              ),
            const _DrawerDivider(),
            for (final screen in screens)
              _DrawerTile(
                icon: screen.icon,
                label: screen.label,
                onTap: () => onSelected(screen),
              ),
            const _DrawerDivider(),
            _DrawerTile(
              icon: ScreenDestination.about.icon,
              label: ScreenDestination.about.label,
              onTap: () => onSelected(ScreenDestination.about),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.selected = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.small),
      child: ListTile(
        shape: const StadiumBorder(),
        selected: selected,
        selectedTileColor: scheme.secondaryContainer,
        selectedColor: scheme.onSecondaryContainer,
        iconColor: scheme.onSurfaceVariant,
        textColor: scheme.onSurfaceVariant,
        leading: Icon(icon),
        title: Text(label),
        onTap: onTap,
      ),
    );
  }
}

class _DrawerDivider extends StatelessWidget {
  const _DrawerDivider();

  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.symmetric(
      horizontal: AppSpacing.large,
      vertical: AppSpacing.xSmall,
    ),
    child: Divider(),
  );
}
