import 'dart:developer';

import 'package:asistencia_jaguar/config/routes/scaffold_with_nav_bar.dart';
import 'package:asistencia_jaguar/data/models/career_model.dart';
import 'package:asistencia_jaguar/data/sources/user_prefreferences.dart';
import 'package:asistencia_jaguar/presentation/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'my_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _sectionNavigatorKey = GlobalKey<NavigatorState>();

enum Routes {
  login,
  adminHome,
  adminPanel,
  adminCareerList,
  adminCareer,
  adminSchoolRoomList,
  adminReports,
  teacherHome,
  teacherCourseList,
  teacherReports,
  studentHome,;

  // Retornar el path de cada enum
  String getPath() => '/$name';
}

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  
  final prefs = UserPreferences();
  log(prefs.defaultRoute);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: prefs.defaultRoute,
    routes: <RouteBase>[
      GoRoute(
        path: Routes.login.getPath(),
        name: Routes.login.name,
        builder: (context, state) => const LogInScreen(),
      ),

      // NavBar del admin
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavBarAdmin( navigationShell: navigationShell, );
        },
        branches: [
          // Rama Principal
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: Routes.adminHome.getPath(),
                name: Routes.adminHome.name,
                builder: (context, state) => const AdminHomeScreen(),
              ),
            ]
          ),

          // 2da Rama de Grupos
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.adminPanel.getPath(),
                name: Routes.adminPanel.name,
                builder: (context, state) => const AdminPanelScreen(),
                routes: [
                  GoRoute(
                    path: Routes.adminCareerList.name,
                    name: Routes.adminCareerList.name,
                    builder: (context, state) => const AdminCareerListScreen(),
                    routes: [
                      GoRoute(
                        path: Routes.adminCareer.name,
                        name: Routes.adminCareer.name,
                        builder: (context, state) { 
                          // Acceder al extra
                          final career = state.extra as CareerModel?;  
                          return AdminCareerFormScreen(career: career,);
                        }
                      ),
                    ]
                  ),
                  GoRoute(
                    path: Routes.adminSchoolRoomList.name,
                    name: Routes.adminSchoolRoomList.name,
                    builder: (context, state) => const AdminSchoolRoomListScreen(),
                  ),
                ]
              ),
            ],
          ),

          // 3ra Rama de Reportes
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.adminReports.getPath(),
                name: Routes.adminReports.name,
                builder: (context, state) => const AdminReportsScreen(),
              ),
            ],
          ),
        ],
      ),  

      // NavBar Teacher
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavBarTeacher( navigationShell: navigationShell, );
        },
        branches: [
          // Rama Principal
          StatefulShellBranch(
            navigatorKey: _sectionNavigatorKey,
            routes: <RouteBase>[
              GoRoute(
                path: Routes.teacherHome.getPath(),
                name: Routes.teacherHome.name,
                builder: (context, state) => const TeacherHomeScreen(),
              ),
            ]
          ),

          // 2da Rama de Grupos
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.teacherCourseList.getPath(),
                name: Routes.teacherCourseList.name,
                builder: (context, state) => const TeacherCourseListScreen(),
              ),
            ],
          ),

          // 3ra Rama de Reportes
          StatefulShellBranch(
            routes: <RouteBase>[
              GoRoute(
                path: Routes.teacherReports.getPath(),
                name: Routes.teacherReports.name,
                builder: (context, state) => const TeacherReportsScreen(),
              ),
            ],
          ),
        ],
      ),

      // Home Student
      GoRoute(
        path: Routes.studentHome.getPath(),
        name: Routes.studentHome.name,
        builder: (context, state) => const StudentHomeScreen(),
      ),
    ]
  );
}