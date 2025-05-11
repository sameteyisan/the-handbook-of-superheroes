import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/favorites_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/ads_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_tile.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavoritesController());

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: const Text("Favorites").animate().flip(delay: 100.ms),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () =>
              controller.heroes.isEmpty
                  ? const EmptyWidget(
                    text:
                        "The superheroes you have added to your favorites will be displayed here.",
                  )
                  : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    physics: const BouncingScrollPhysics(),
                    children: [
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.heroes.length,
                        itemBuilder: (context, index) {
                          final superhero = controller.heroes[index];

                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: SuperheroTile(
                              superhero: superhero,
                              onDeleted: () => controller.favoriteToggle(index),
                              icon: AnimatedCrossFade(
                                firstChild: Icon(Ionicons.heart, color: CColors.red),
                                secondChild: const Icon(
                                  Ionicons.heart_outline,
                                  color: CColors.backgroundcolor,
                                ),
                                crossFadeState:
                                    superhero.isFavorite != null
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                duration: 300.ms,
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
