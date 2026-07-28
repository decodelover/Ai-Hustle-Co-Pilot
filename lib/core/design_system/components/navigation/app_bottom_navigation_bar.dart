/// Reusable Bottom Navigation Bar component for AI Hustle Co-Pilot.
library;

import 'package:flutter/material.dart';

/// Navigation item model for bottom navigation bar.
class AppNavItem {
  const AppNavItem({
    required this.icon,
    required this.label,
    this.selectedIcon,
    this.badgeCount,
  });

  final IconData icon;
  final IconData? selectedIcon;
  final String label;
  final int? badgeCount;
}

/// Reusable M3 NavigationBar wrapper.
class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    required this.currentIndex,
    required this.onTap,
    required this.items,
    super.key,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppNavItem> items;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: items.map((item) {
        Widget iconWidget = Icon(item.icon);
        Widget selectedIconWidget = Icon(item.selectedIcon ?? item.icon);

        if (item.badgeCount != null && item.badgeCount! > 0) {
          iconWidget = Badge(
            label: Text('${item.badgeCount}'),
            child: iconWidget,
          );
          selectedIconWidget = Badge(
            label: Text('${item.badgeCount}'),
            child: selectedIconWidget,
          );
        }

        return NavigationDestination(
          icon: iconWidget,
          selectedIcon: selectedIconWidget,
          label: item.label,
        );
      }).toList(),
    );
  }
}
