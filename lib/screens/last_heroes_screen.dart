import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/last_heroes_controller.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/ads_widget.dart';
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
            () =>
                controller.heroes.isNotEmpty
                    ? IconButton(
                      onPressed: controller.deleteAll,
                      icon: const Icon(Ionicons.trash, color: CColors.textColor),
                    ).animate().flip(delay: 100.ms)
                    : const SizedBox(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () =>
              controller.heroes.isEmpty
                  ? const EmptyWidget()
                  : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.heroes.length,
                        itemBuilder: (context, index) {
                          final hero = controller.heroes[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: SuperheroTile(
                              superhero: hero,
                              onDeleted: () => controller.removeHero(hero.id),
                              icon: Icon(
                                Ionicons.close,
                                color: CColors.subtitleColor,
                                shadows: Const.shadows,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          if (index != 0 && index % 6 == 0) {
                            return Obx(
                              () => AnimatedSize(
                                duration: 300.microseconds,
                                child:
                                    controller.bannerAds[index] != null
                                        ? Padding(
                                          padding: const EdgeInsets.only(top: 16, bottom: 32),
                                          child: AdsWidget(bannerAd: controller.bannerAds[index]!),
                                        )
                                        : const SizedBox(),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                      Obx(
                        () => AnimatedContainer(
                          duration: 300.ms,
                          height: HomeController.to.versusHeroes.isNotEmpty ? 300 : 32,
                        ),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
