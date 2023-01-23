import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/application/exceptions.dart';
import 'package:imdb/data/models/movie_detail_response.dart';
import 'package:imdb/data/models/movie_search_response.dart';
import 'package:http/http.dart' as http;

class ImdbApi {

  ImdbApi({required this.ref});

  final AutoDisposeProviderRef ref;

  Future<MovieSearchResponse> getMoviesByTitle(String title, String apiKey) async {
    String uri = Uri.encodeFull('https://imdb-api.com/en/API/SearchMovie/$apiKey/$title');
    final response = await ref.watch(imdbApiClientProvider).get(
      Uri.parse(uri)
    );
    final resp = MovieSearchResponse.fromJson(jsonDecode(response.body));
    if (resp.errorMessage.isNotEmpty) {
      throw ImdbApiException(resp.errorMessage);
    }
    return resp;
  }

  Future<MovieDetailResponse> getMovieDetail(String id, String apiKey) async {
    String uri = Uri.encodeFull('https://imdb-api.com/en/API/Title/$apiKey/$id/');
    final response = await ref.watch(imdbApiClientProvider).get(
        Uri.parse(uri)
    );
    final resp = MovieDetailResponse.fromJson(jsonDecode(response.body));
    if (resp.errorMessage.isNotEmpty) {
      throw ImdbApiException(resp.errorMessage);
    }
    return resp;
  }

  void dispose() => {};

}

final imdbApiProvider = Provider.autoDispose<ImdbApi>((ref) {
  ImdbApi imdbApi = ImdbApi(ref: ref);
  ref.onDispose(() => imdbApi.dispose());
  return imdbApi;
});

final imdbApiClientProvider = Provider.autoDispose<http.Client>((ref) {
  return http.Client();
});