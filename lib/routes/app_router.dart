import 'package:go_router/go_router.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_first_app/routes/app_routes.dart';
import 'package:my_first_app/screens/create_candidate_screen.dart';
import 'package:my_first_app/screens/home_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (BuildContext context, GoRouterState state) =>
            const HomeScreen(),
      ),

      GoRoute(
        path: AppRoutes.createCandidate,
        builder: (BuildContext context, GoRouterState state) =>
            const CreateCandidateScreen(),
      ),
    ],
  );
}
