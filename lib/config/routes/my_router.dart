import 'package:asistencia_jaguar/config/routes/scaffold_with_nav_bar.dart';
import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/signIn',
        name: 'signIn',
        builder: (context, state) => SignInScreen(),
      ),

      // My Scaffold with Bottom Navavigation Bar
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar( navigationShell: navigationShell, );
        },
        branches: [
          // Rama Principal
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: '/',
                name: 'home',
                builder: (context, state) => const HomeScreen(),
              ),
            ]
          ),

          // 2da Rama de Grupos
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/groups',
                name: 'groups',
                builder: (context, state) => const GroupsScreen(),
              ),
            ],
          ),

          // 3ra Rama de Reportes
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: '/reports',
                name: 'reports',
                builder: (context, state) => const ReportScreen(),
              ),
            ],
          ),
        ],
      ),   
    ]
  );
}