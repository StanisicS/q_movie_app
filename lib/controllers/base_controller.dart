// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:q_movie_app/data/api_repository.dart';
import 'package:q_movie_app/data/models/ganres.dart';
import 'package:q_movie_app/data/models/movie_details.dart';
import 'package:q_movie_app/data/models/movies_list.dart';

class BaseController extends GetxController with StateMixin, ScrollMixin {
  final ApiRepository apiRepository = Get.find();
  RxList<Genre> genres = RxList<Genre>();
  RxList<Movie> movies = RxList<Movie>();
  Movie? movie;
  RxList<Movie> favorites = RxList<Movie>();
  RxBool isLoaded = false.obs;
  RxInt currentIndex = 0.obs;
  var page = 1;
  var isToLoadMore = true;
  RxBool isFavFirst = false.obs;
  late int itemLength;
  RxInt movieId = 0.obs;
  Future<MovieDetails>? movieDetailed;
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    GetStorage().erase();

    List? storedData = GetStorage().read<List>('pop');

    if (storedData != null) {
      movies = storedData.map((e) => Movie.fromJson(e)).toList().obs;
    }
    ever(movies, (_) {
      GetStorage().write('pop', movies.toList());
    });

    getGenresList();
    getPopularMovies();
    itemLength = movies.value.length;

    super.onInit();
  }

  getGenresList() async {
    try {
      List? storedGenres = GetStorage().read<List>('gen');

      if (storedGenres != null) {
        genres = storedGenres.map((e) => Genre.fromJson(e)).toList().obs;
      }
      ever(genres, (_) {
        GetStorage().write('gen', genres.toList());
      });
      if (genres.isEmpty) {
        var result = await apiRepository.getGenresList();
        genres.addAll(result.genres!);
        debugPrint("Entered get Genres()");
      }
    } on Exception catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: "$e",
        duration: const Duration(milliseconds: 3000),
      ));
    }
  }

  getPopularMovies() async {
    try {
      final res = await apiRepository.getPopularMovies(page: page);
      if (movies.value != res.results) {
        movies.addAll(res.results!);

        itemLength = movies.value.length;
        debugPrint('itemLength: $itemLength');
        isToLoadMore = true;
      } else {
        isToLoadMore = false;
      }
    } on Exception catch (e) {
      Get.showSnackbar(GetSnackBar(
        message: "$e",
        duration: const Duration(milliseconds: 3000),
      ));
    }
  }

  getMovie(int movieId) async {
    try {
      await apiRepository.getMovie(movieId);
    } on Exception catch (e) {
      !isToLoadMore
          ? debugPrint(e.toString())
          : Get.showSnackbar(GetSnackBar(
              message: "$e",
              duration: const Duration(milliseconds: 3000),
            ));
    }
  }

  handleOnTapFav(Movie item) {}

  @override
  Future<void> onEndScroll() async {
    if (isToLoadMore) {
      page++;
      await getPopularMovies();
    }
    debugPrint("onEngScroll: Called");
  }

  @override
  Future<void> onTopScroll() async {
    debugPrint("onTopScroll: Called");
  }
}
