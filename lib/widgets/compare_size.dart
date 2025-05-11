import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';

class CompareSize extends GetView<HomeController> {
  const CompareSize({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedContainer(
        duration: 300.milliseconds,
        height:
            controller.versusHeroes.length >= 2
                ? 400
                : controller.versusHeroes.isNotEmpty
                ? 320
                : 32,
      ),
    );
  }
}
