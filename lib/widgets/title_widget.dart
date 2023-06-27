import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget(this.title, {Key? key, this.more, this.onTap, this.tPadding}) : super(key: key);

  final String title;
  final String? more;

  final double? tPadding;

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.only(left: tPadding ?? 0),
          child: Text(
            title,
            style: Styles.title,
            textAlign: TextAlign.left,
          ),
        ),
        if (more != null)
          TextButton(
            style: TextButton.styleFrom(padding: EdgeInsets.symmetric(horizontal: tPadding ?? 0)),
            onPressed: onTap,
            child: Text(
              more!,
              style: const TextStyle(color: CColors.subtitleColor),
            ),
          )
      ],
    );
  }
}
