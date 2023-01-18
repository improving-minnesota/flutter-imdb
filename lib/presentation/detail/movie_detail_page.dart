import 'package:flutter/material.dart';
import 'package:imdb/application/constants.dart';
import 'package:imdb/data/models/movie_detail_response.dart';
import 'package:imdb/presentation/widgets/bubble_text.dart';
import 'package:imdb/presentation/widgets/detail_divider.dart';
import 'package:imdb/presentation/widgets/detail_name_section.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({Key? key, required this.detail}) : super(key: key);

  final MovieDetailResponse detail;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
                detail.title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${detail.year} - ${detail.contentRating} - ${detail.runtimeStr}'),
            SizedBox(
              height: 300.0,
                child: Image.network(
                    detail.image,
                  errorBuilder: ((context, error, stackTrace) => Image.network(Constants.noImageUrl)),
                ),
            ),
            Row(
              children:
                detail.genres.map((e) {
                  return BubbleText(text: e.value);
                }).toList(),
            ),
            Text(detail.plot),
            const DetailDivider(),
            DetailNameSection(title: 'Director', names: detail.directors),
            const DetailDivider(),
            DetailNameSection(title: 'Writer', names: detail.writers),
            const DetailDivider(),
            DetailNameSection(title: 'Star', names: detail.stars),
            const DetailDivider(),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text(
                      'IMDb Rating',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text('${detail.imdbRating}/10')
              ],
            ),
          ],
        ),
      ),
    );
  }
}
