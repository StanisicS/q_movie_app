// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

MoviesList welcomeFromJson(String str) => MoviesList.fromJson(json.decode(str));

String welcomeToJson(MoviesList data) => json.encode(data.toJson());

class MoviesList {
  MoviesList({
    this.page,
    this.results,
    this.totalPages,
    this.totalResults,
  });

  int? page;
  List<Movie>? results;
  int? totalPages;
  int? totalResults;

  factory MoviesList.fromJson(Map<String, dynamic> json) => MoviesList(
        page: json["page"],
        results:
            List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
      };
}

class Movie {
  bool? adult;
  String backdropPath;
  List<int> genreIds;
  int? id;
  String? originalLanguage;
  String? originalTitle;
  String overview;
  double? popularity;
  String posterPath;
  String? releaseDate;
  String title;
  bool? video;
  double voteAverage;
  int? voteCount;
  bool isFav;
  Movie({
    this.adult,
    required this.backdropPath,
    required this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    required this.overview,
    this.popularity,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    this.video,
    required this.voteAverage,
    this.voteCount,
    this.isFav = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        adult: json["adult"],
        backdropPath: json["backdrop_path"],
        genreIds: List<int>.from(json["genre_ids"].map((x) => x)),
        id: json["id"],
        originalLanguage: json["original_language"],
        originalTitle: json["original_title"],
        overview: json["overview"],
        popularity: json["popularity"].toDouble(),
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        video: json["video"],
        voteAverage: json["vote_average"].toDouble(),
        voteCount: json["vote_count"],
        isFav: json["isFav"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "adult": adult,
        "backdrop_path": backdropPath,
        "genre_ids": List<dynamic>.from(genreIds.map((x) => x)),
        "id": id,
        "original_language": originalLanguage,
        "original_title": originalTitle,
        "overview": overview,
        "popularity": popularity,
        "poster_path": posterPath,
        "release_date": releaseDate,
        "title": title,
        "video": video,
        "vote_average": voteAverage,
        "vote_count": voteCount,
        "isFav": isFav,
      };
}
