import 'package:imdb/data/models/key_value.dart';
import 'package:imdb/data/models/name.dart';

class MovieDetailResponse {
  const MovieDetailResponse({
    required this.id,
    required this.title,
    required this.year,
    required this.image,
    required this.releaseDate,
    required this.runtimeMins,
    required this.runtimeStr,
    required this.plot,
    required this.directors,
    required this.writers,
    required this.stars,
    required this.genres,
    required this.contentRating,
    required this.imdbRating,
    required this.errorMessage,
  });

  final String id;
  final String title;
  final String year;
  final String image;
  final String releaseDate;
  final String runtimeMins;
  final String runtimeStr;
  final String plot;
  final List<Name> directors;
  final List<Name> writers;
  final List<Name> stars;
  final List<KeyValue> genres;
  final String contentRating;
  final String imdbRating;
  final String errorMessage;

  factory MovieDetailResponse.fromJson(Map<String, dynamic> json) {
    return MovieDetailResponse(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      year: json['year'] ?? '',
      image: json['image'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      runtimeMins: json['runtimeMins'] ?? '',
      runtimeStr: json['runtimeStr'] ?? '',
      plot: json['plot'] ?? '',
      directors: json['directorList'] != null ? (json['directorList'] as List).map((e) => Name.fromJson(e)).toList() : [],
      writers: json['writerList'] != null ? (json['writerList'] as List).map((e) => Name.fromJson(e)).toList() : [],
      stars: json['starList'] != null ? (json['starList'] as List).map((e) => Name.fromJson(e)).toList() : [],
      genres: json['genreList'] != null ? (json['genreList'] as List).map((e) => KeyValue.fromJson(e)).toList() : [],
      contentRating: json['contentRating'] ?? '',
      imdbRating: json['imDbRating'] ?? '',
      errorMessage: json['errorMessage'],
    );
  }

    factory MovieDetailResponse.empty() {
      return const MovieDetailResponse(
        id: '',
        title: '',
        year: '',
        image: '',
        releaseDate: '',
        runtimeMins: '',
        runtimeStr: '',
        plot: '',
        directors: [],
        writers: [],
        stars: [],
        genres: [],
        contentRating: '',
        imdbRating: '',
        errorMessage: '');
  }
}
