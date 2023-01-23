import 'package:flutter/material.dart';

class DetailDivider extends StatelessWidget {
  const DetailDivider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      height: 20,
      thickness: 2,
      indent: 20,
      endIndent: 20,
    );
  }
}
