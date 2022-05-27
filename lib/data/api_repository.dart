import 'package:q_movie_app/data/models/ganres.dart';
import 'package:q_movie_app/data/models/movies_list.dart';
import 'package:q_movie_app/data/models/movie_details.dart';

abstract class ApiRepository {
  Future<Genres> getGenresList();
  Future<MoviesList> getPopularMovies({
    String language = 'en_US',
    required int page,
  });
  Future<MovieDetails> getMovie(
    int movieId, {
    String language = 'en_US',
    int page = 1,
  });
}
