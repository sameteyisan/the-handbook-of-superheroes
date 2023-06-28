import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/favorites_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_widget.dart';
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
        title: const Text("Favorites"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => controller.heroes.isEmpty
                  ? const EmptyWidget(
                      text:
                          "The superheroes you have added to your favorites will be displayed here.")
                  : ListView(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      physics: const BouncingScrollPhysics(),
                      children: [
                          ...controller.heroes.asMap().entries.map(
                            (kv) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: SuperheroTile(
                                  superhero: kv.value,
                                  onDeleted: () => controller.favoriteToggle(kv.key),
                                  icon: AnimatedCrossFade(
                                    firstChild: Icon(
                                      Ionicons.heart,
                                      color: CColors.red,
                                    ),
                                    secondChild: const Icon(
                                      Ionicons.heart_outline,
                                      color: CColors.backgroundcolor,
                                    ),
                                    crossFadeState: kv.value.isFavorite != null
                                        ? CrossFadeState.showFirst
                                        : CrossFadeState.showSecond,
                                    duration: 300.milliseconds,
                                  ),
                                ),
                              );
                            },
                          ),
                          Obx(
                            () => AnimatedContainer(
                              duration: 300.milliseconds,
                              height: HomeController.to.versusHeroes.isNotEmpty ? 300.h : 32,
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
