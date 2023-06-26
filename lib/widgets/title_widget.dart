import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget(this.title, {Key? key}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: Styles.title,
        textAlign: TextAlign.left,
      ),
    );
  }
}
