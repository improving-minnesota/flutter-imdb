import 'package:imdb/data/models/movie_summary.dart';

class MovieSearchResponse {

  const MovieSearchResponse({
    required this.searchType,
    required this.expression,
    required this.results,
    required this.errorMessage,
  });

  final String searchType;
  final String expression;
  final List<MovieSummary> results;
  final String errorMessage;

  factory MovieSearchResponse.fromJson(Map<String, dynamic> json) {
    return MovieSearchResponse(
        searchType: json['searchType'],
        expression: json['expression'],
        results: (json['results'] as List).map((e) => MovieSummary.fromJson(e)).toList(),
        errorMessage: json['errorMessage'],
    );
  }

  factory MovieSearchResponse.empty() {
    return const MovieSearchResponse(
        searchType: '',
        expression: '',
        results: [],
        errorMessage: '');
  }
}