import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:zoomies/features/auth/presentation/pages/onboarding_page.dart';
import 'package:zoomies/features/create/presentation/pages/create_page.dart';
import 'package:zoomies/features/den/presentation/pages/den_page.dart';
import 'package:zoomies/features/home/presentation/pages/home_page.dart';
import 'package:zoomies/shared/widgets/scaffold_with_nav_bar.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ScaffoldWithNavBar(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/home', builder: (context, state) => const HomePage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/create', builder: (context, state) => const CreatePage()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/den', builder: (context, state) => const DenPage()),
            ],
          ),
        ],
      ),
    ],
  );
});
