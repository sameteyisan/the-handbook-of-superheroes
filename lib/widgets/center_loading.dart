import 'package:flutter/material.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';

class CenterLoading extends StatelessWidget {
  const CenterLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: EmptyWidget(
      text: "Loading...",
    ));
  }
}
