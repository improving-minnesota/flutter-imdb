import 'package:flutter/material.dart';
import 'package:imdb/data/models/name.dart';

class DetailNameSection extends StatelessWidget {
  const DetailNameSection({
    Key? key,
    required this.title,
    required this.names,
  }) : super(key: key);

  final String title;
  final List<Name> names;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Text(
            names.length > 1 ? '${title}s' : title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Text(names.map((e) => e.name).join(', ')),
      ],
    );
  }
}
