import 'package:flutter/material.dart';

class BubbleText extends StatelessWidget {
  const BubbleText({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4.0),
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: const BorderRadius.all(Radius.circular(10.0))
      ),
      child: Text(text),
    );
  }
}
