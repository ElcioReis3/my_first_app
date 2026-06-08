import 'package:go_router/go_router.dart';
import 'package:my_first_app/models/candidate.dart';
import 'package:my_first_app/routes/app_routes.dart';
import 'package:my_first_app/screens/create_candidate_screen.dart';
import 'package:my_first_app/screens/edit_candidate_screen.dart';
import 'package:my_first_app/screens/home_screen.dart';
import 'package:my_first_app/screens/login_screen.dart';

class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.login,
    debugLogDiagnostics: false,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.createCandidate,
        builder: (context, state) => const CreateCandidateScreen(),
      ),
      GoRoute(
        path: AppRoutes.editCandidate,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>;
          return EditCandidateScreen(
            candidateIndex: extra['index'] as int,
            candidate: extra['candidate'] as Candidate,
          );
        },
      ),
    ],
  );
}
