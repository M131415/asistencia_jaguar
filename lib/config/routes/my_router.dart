import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_router.g.dart';

final _navKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    navigatorKey: _navKey,
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/signIn',
        name: 'signIn',
        builder: (context, state) => SignInScreen(),
        routes: [
          GoRoute(
            path: 'signUp',
            name: 'signUp',
            builder: (context, state) => SignUpScreen(),
          ),
        ]
      ),
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
        routes: [
          GoRoute(
            path: 'groups',
            name: 'groups',
            builder: (context, state) => const GroupsScreen(),
            routes: [
              GoRoute(
                path: 'addGroups',
                name: 'addGroups',
                builder: (context, state) => const AddGroupScreen(),
              ),
            ]
          ),
        ]
      ),
    ]
  );
}