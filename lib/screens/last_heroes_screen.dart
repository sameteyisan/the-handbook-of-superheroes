import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/last_heroes_controller.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_last_heroes.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_tile.dart';

class LastHeroesScreen extends StatelessWidget {
  const LastHeroesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LastHeroesController());

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Last Heroes you viewed"),
        actions: [
          Obx(
            () => controller.heroes.isNotEmpty
                ? IconButton(
                    onPressed: controller.deleteAll,
                    icon: const Icon(
                      Ionicons.trash,
                      color: CColors.textColor,
                    ),
                  )
                : const SizedBox(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => controller.heroes.isEmpty
              ? const EmptyLastHeroes()
              : ListView(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  reverse: true,
                  children: controller.heroes.map(
                    (hero) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: SuperheroTile(superhero: hero),
                      );
                    },
                  ).toList(),
                ),
        ),
      ),
    );
  }
}
