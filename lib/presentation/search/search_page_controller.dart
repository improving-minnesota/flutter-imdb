import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/application/exceptions.dart';
import 'package:imdb/data/datasources/imdb_api.dart';
import 'package:imdb/data/datasources/storage_service.dart';
import 'package:imdb/data/models/movie_detail_response.dart';
import 'package:imdb/data/models/movie_search_response.dart';

class SearchPageController {

  SearchPageController({required this.imdbApi, required this.ref});

  final ImdbApi imdbApi;
  final AutoDisposeProviderRef ref;

  Future<MovieSearchResponse> searchMovieTitle(String title) async {
    String apiKey = await _getApiKey();
    return imdbApi.getMoviesByTitle(title, apiKey);
  }

  Future<MovieDetailResponse> getMovieDetail(String id) async {
    String apiKey = await _getApiKey();
    return imdbApi.getMovieDetail(id, apiKey);
  }

  Future<String> _getApiKey() async {
    String? apiKey = await ref.watch(storageServiceProvider).getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      throw const ApiKeyMissingException('API Key is missing');
    }
    return apiKey;
  }

  void dispose() => {};
}

final searchPageControllerProvider = Provider.autoDispose((ref) {
  final searchPageController = SearchPageController(imdbApi: ref.watch(imdbApiProvider), ref: ref);
  ref.onDispose(() => searchPageController.dispose());
  return searchPageController;
});
