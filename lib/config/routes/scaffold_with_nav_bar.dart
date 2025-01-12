import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NavBarAdmin extends StatelessWidget {

  const NavBarAdmin({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  final List<BottomNavigationBarItem> _bottomNavItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      activeIcon: Icon(Icons.calendar_month_sharp),
      label: 'Horarios',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.admin_panel_settings_outlined),
      activeIcon: Icon(Icons.admin_panel_settings_rounded),
      label: 'Admin Panel',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.library_add_outlined),
      activeIcon: Icon(Icons.library_add_sharp),
      label: 'Reportes',
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

class NavBarTeacher extends StatelessWidget {

  const NavBarTeacher({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  final List<BottomNavigationBarItem> _bottomNavItems = const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.calendar_month_outlined),
      activeIcon: Icon(Icons.calendar_month_sharp),
      label: 'Horarios',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.book_outlined),
      activeIcon: Icon(Icons.book_rounded),
      label: 'Courses',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.library_add_outlined),
      activeIcon: Icon(Icons.library_add_sharp),
      label: 'Reportes',
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