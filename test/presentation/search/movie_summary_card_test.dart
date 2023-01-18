import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:imdb/presentation/search/movie_summary_card.dart';
import 'package:network_image_mock/network_image_mock.dart';

void main() {
  testWidgets('test movie search card', (widgetTester) async {
    await mockNetworkImagesFor(() async {
      await widgetTester.pumpWidget(
        const MaterialApp(
            home: MovieSummaryCard(
                id: 'tt123456',
                resultType: 'Movie',
                image: 'http://img.jpg',
                title: 'Star Wars',
                description: 'Luke Skywalker blows up the Death Star')),
      );
    });
    expect(find.text('Star Wars'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });
}
