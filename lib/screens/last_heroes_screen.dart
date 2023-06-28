import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/last_heroes_controller.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => controller.heroes.isEmpty
                  ? const EmptyWidget()
                  : ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const BouncingScrollPhysics(),
                      children: [
                          ...controller.heroes.map(
                            (hero) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: SuperheroTile(
                                  superhero: hero,
                                  onDeleted: () => controller.deleteHero(hero.id),
                                  icon: Ionicons.close,
                                ),
                              );
                            },
                          ),
                          Obx(
                            () => AnimatedContainer(
                              duration: 300.milliseconds,
                              height: HomeController.to.versusHeroes.isNotEmpty ? 250.h : 32,
                            ),
                          ),
                        ]),
            ),
          ),
          const CompareWidget(),
        ],
      ),
    );
  }
}
