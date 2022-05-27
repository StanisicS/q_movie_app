import 'package:get/get.dart';
import 'package:q_movie_app/controllers/base_controller.dart';
import 'package:q_movie_app/controllers/favorites_controller.dart';
import 'package:q_movie_app/views/base_view.dart';
import 'package:q_movie_app/views/favorites/favorites_screen.dart';
import 'package:q_movie_app/views/details/details_screen.dart';
import 'package:q_movie_app/views/movies/movies_screen.dart';
import 'package:q_movie_app/views/splash/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  static const initial = AppRoutes.splash;

  static final routes = [
    GetPage(
      name: initial,
      page: () => const SplashScreen(),
      binding: BindingsBuilder.put(
        () => BaseController(),
      ),
    ),
    GetPage(
      name: AppRoutes.movies,
      page: () => const MoviesScreen(),
    ),
    GetPage(
      name: AppRoutes.favorites,
      page: () => const FavoritesScreen(),
      binding: BindingsBuilder.put(
        () => FavoritesController(),
      ),
    ),
    GetPage(
      name: AppRoutes.details,
      page: () => const MovieDetailsScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 350),
    ),
  ];
}
