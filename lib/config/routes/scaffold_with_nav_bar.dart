import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {

  const ScaffoldWithNavBar({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  final List<BottomNavigationBarItem> _bottomNavItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      activeIcon: Icon(Icons.calendar_month_sharp),
      label: 'Incio',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.people_alt_outlined),
      activeIcon: Icon(Icons.people_alt_sharp),
      label: 'Grupos',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.library_add_outlined),
      activeIcon: Icon(Icons.library_add_sharp),
      label: 'Reposte',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        items: _bottomNavItems,
        currentIndex: navigationShell.currentIndex,
        onTap: _onTap,
      ),
    );
  }
  void _onTap(index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}