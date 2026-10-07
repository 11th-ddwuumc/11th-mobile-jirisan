import 'package:go_router/go_router.dart';

import '../detail/movie_detail_screen.dart';
import '../home/home_screen.dart';
import '../main_screen.dart';
import '../movies/movie_list_screen.dart';
import '../profile/my_page_screen.dart';
import '../sign_up/sign_up_screen.dart';
import '../start_screen.dart';

class AppRouter {
  AppRouter._();

  static const start = '/start';
  static const register = '/register';
  static const home = '/home';
  static const movieList = '/movies';
  static const myPage = '/my';

  static String movieDetail(int movieId) => '$movieList/$movieId';

  static final router = GoRouter(
    initialLocation: start,
    routes: [
      GoRoute(path: start, builder: (context, state) => const StartScreen()),
      GoRoute(
        path: register,
        builder: (context, state) => const SignUpScreen(),
      ),
      // 탭마다 독립된 Navigator를 두어 탭을 바꿔도 각 탭의 화면 Stack을 보존합니다.
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: movieList,
                builder: (context, state) => const MovieListScreen(),
                routes: [
                  GoRoute(
                    path: ':movieId',
                    builder: (context, state) => MovieDetailScreen(
                      movieId: int.tryParse(
                        state.pathParameters['movieId'] ?? '',
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: myPage,
                builder: (context, state) => const MyPageScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
