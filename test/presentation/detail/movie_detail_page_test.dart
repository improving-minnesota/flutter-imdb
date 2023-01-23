import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb/data/models/key_value.dart';
import 'package:imdb/data/models/movie_detail_response.dart';
import 'package:imdb/data/models/name.dart';
import 'package:imdb/presentation/detail/movie_detail_page.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('display movie details', (widgetTester) async {
    const detail = MovieDetailResponse(
        id: 'tt123456',
        title: 'Star Wars',
        year: '1977',
        image: 'http://img.jpg',
        releaseDate: '1977-05-25',
        runtimeMins: '121',
        runtimeStr: '2h 1min',
        plot: 'Luke Skywalker blows up the Death Star',
        directors: [Name(id: 'nm123', name: 'George Lucas')],
        writers: [Name(id: 'nm123', name: 'George Lucas')],
        stars: [
          Name(id: 'nm987', name: 'Mark Hamill'),
          Name(id: 'nm876', name: 'Harrison Ford'),
          Name(id: 'nm765', name: 'Carrie Fisher')
        ],
        genres: [KeyValue(key: 'Action', value: 'Action')],
        contentRating: 'PG',
        imdbRating: '8.6',
        errorMessage: '');

    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        const MaterialApp(home: MovieDetailPage(detail: detail)),
      );
    });

    expect(find.text('Star Wars'), findsOneWidget);
    expect(find.text('1977 - PG - 2h 1min'), findsOneWidget);

  });
}
