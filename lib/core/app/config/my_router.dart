import 'package:asistencia_jaguar/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:asistencia_jaguar/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:asistencia_jaguar/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

final myRouter = GoRouter(
  initialLocation: '/signIn',
  routes: <RouteBase>[
    GoRoute(
      path: '/signIn',
      name: 'signIn',
      builder: (context, state) => SignInScreen() ,
    ),
    GoRoute(
      path: '/signUp',
      name: 'signUp',
      builder: (context, state) => SignUpScreen() ,
    ),
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomeScreen() ,
    ),
  ]
);