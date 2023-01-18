import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:imdb/application/constants.dart';
import 'package:imdb/presentation/detail/movie_detail_page.dart';
import 'package:imdb/presentation/search/search_page_controller.dart';

class MovieSummaryCard extends ConsumerWidget {
  const MovieSummaryCard({
    Key? key,
    required this.id,
    required this.resultType,
    required this.image,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String id;
  final String resultType;
  final String image;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          ref.watch(searchPageControllerProvider)
              .getMovieDetail(id)
              .then((value) {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MovieDetailPage(detail: value))
                );
          });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Image.network(
                  image,
                errorBuilder: (context, error, stackTrace) => Image.network(Constants.noImageUrl),
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.fade,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    overflow: TextOverflow.visible,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
