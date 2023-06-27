import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator({Key? key, required this.isActive}) : super(key: key);
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOutCubic,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        color: isActive ? CColors.indicatorColor : CColors.disabledColor,
      ),
      height: 8,
      width: isActive ? 30 : 8,
    );
  }
}
