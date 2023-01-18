import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb/data/models/movie_search_response.dart';
import 'package:imdb/data/models/movie_summary.dart';
import 'package:imdb/presentation/search/search_page.dart';
import 'package:imdb/presentation/search/search_page_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_page_test.mocks.dart';

@GenerateMocks([SearchPageController])
void main() {
  testWidgets('test search page', (widgetTester) async {
    final mockController = MockSearchPageController();
    when(mockController.searchMovieTitle('star wars')).thenAnswer((realInvocation) async => movieSearchResponse);
    await widgetTester.pumpWidget(
      ProviderScope(
        overrides: [
          searchPageControllerProvider.overrideWithValue(mockController),
        ],
        child: const MaterialApp(
          home: SearchPage(
            title: 'Search',
          ),
        ),
      ),
    );
    expect(find.byType(TextFormField), findsOneWidget);
    var searchField = find.byKey(const Key('text_field_title_search'));
    expect(searchField, findsOneWidget);
    final searchTextValue = (widgetTester.element(searchField).widget as TextFormField).controller?.text;
    // search field should be empty initially
    expect(searchTextValue, isEmpty);

    var submitButton = find.byKey(const Key('button_search'));
    expect(submitButton, findsOneWidget);

    // test validation of empty text field
    await widgetTester.tap(submitButton);
    await widgetTester.pump();
    expect(find.descendant(of: searchField, matching: find.text('Movie title is missing')), findsOneWidget);

    //enter text in search field
    await widgetTester.enterText(searchField, 'star wars');
    await widgetTester.tap(submitButton);
    await widgetTester.pump();
    expect(find.descendant(of: searchField, matching: find.text('Movie title is missing')), findsNothing);

    expect(find.text('Star Wars - Episode IV: A New Hope'), findsOneWidget);
    expect(find.text('Star Wars - Episode V: The Empire Strikes Back'), findsOneWidget);
    expect(find.text('Star Wars - Episode VI: The Return of the Jedi'), findsOneWidget);
    expect(find.text('Jurassic Park'), findsNothing);


  });
}

const movieSearchResponse = MovieSearchResponse(
  searchType: 'Movie',
  expression: 'star wars',
  results: [
    MovieSummary(
        id: 'tt1234',
        resultType: 'Movie',
        image: 'http://img.jpg',
        title: 'Star Wars - Episode IV: A New Hope',
        description: 'Luke Skywalker blows up the Death Star'),
    MovieSummary(
        id: 'tt1235',
        resultType: 'Movie',
        image: 'http://img.jpg',
        title: 'Star Wars - Episode V: The Empire Strikes Back',
        description: 'aka The Best Original Trilogy Movie'),
    MovieSummary(
        id: 'tt1236',
        resultType: 'Movie',
        image: 'http://img.jpg',
        title: 'Star Wars - Episode VI: The Return of the Jedi',
        description: 'Do the Ewoks eat the storm troopers at the end?'),
  ],
  errorMessage: '',
);