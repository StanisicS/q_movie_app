import 'dart:convert';

// To parse this JSON data, do
//
//     final ganeres = genresFromJson(jsonString);

Genres genresFromJson(String str) => Genres.fromJson(json.decode(str));

String genresToJson(Genres data) => json.encode(data.toJson());

class Genres {
  Genres({
    this.genres,
  });

  List<Genre>? genres;

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        genres: json["genres"] == null
            ? null
            : List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "genres": genres == null
            ? null
            : List<dynamic>.from(genres!.map((x) => x.toJson())),
      };
}

class Genre {
  int id;
  String name;
  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
