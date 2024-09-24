import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _navKey = GlobalKey<NavigatorState>();

GoRouter myRouter() {
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
              path: 'addGroup',
              name: 'addGroup',
              builder: (context, state) => const AddGroup(),
            ),
          ]
        ),
      ]);
}
