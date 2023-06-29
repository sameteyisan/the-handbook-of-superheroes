import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/last_heroes_controller.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
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
        title: const Text("Last Heroes you viewed").animate().flip(delay: 100.ms),
        actions: [
          Obx(
            () => controller.heroes.isNotEmpty
                ? IconButton(
                    onPressed: controller.deleteAll,
                    icon: const Icon(
                      Ionicons.trash,
                      color: CColors.textColor,
                    ),
                  ).animate().flip(delay: 100.ms)
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
                                icon: Icon(
                                  Ionicons.close,
                                  color: CColors.subtitleColor,
                                  shadows: Const.shadows,
                                ),
                              ),
                            ).animate().flip(delay: 200.ms);
                          },
                        ),
                        Obx(
                          () => AnimatedContainer(
                            duration: 300.ms,
                            height: HomeController.to.versusHeroes.isNotEmpty ? 300.h : 32,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
          const CompareWidget(),
        ],
      ),
    );
  }
}
