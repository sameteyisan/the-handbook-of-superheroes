import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:the_handbook_of_superheroes/theme.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(
        Icons.chevron_left_outlined,
        color: CColors.cardColor,
        size: 32,
      ),
      onPressed: Get.back,
    );
  }
}
