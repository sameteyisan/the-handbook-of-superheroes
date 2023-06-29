import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/screens/last_heroes_screen.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_size.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/page_indicator.dart';
import 'package:the_handbook_of_superheroes/widgets/placeholder_superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_tile.dart';
import 'package:the_handbook_of_superheroes/widgets/title_widget.dart';

class HomeWidget extends GetView<HomeController> {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const TitleWidget("Featured Superheroes", tPadding: 16),
        const SizedBox(height: 16),
        Obx(
          () => AnimatedCrossFade(
            firstChild: CarouselSlider(
              key: const PageStorageKey("featured-carousel"),
              items: List.generate(
                5,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: PlaceholderSuperheroCard(),
                ),
              ),
              options: CarouselOptions(
                viewportFraction: 0.52,
                height: 260.h,
                scrollPhysics: const BouncingScrollPhysics(),
              ),
            ),
            secondChild: CarouselSlider(
              key: const PageStorageKey("featured-carousel"),
              items: controller.featuredHeroes.map((e) => SuperheroCard(superhero: e)).toList(),
              options: CarouselOptions(
                viewportFraction: 0.52,
                height: 260.h,
                scrollPhysics: const BouncingScrollPhysics(),
                autoPlay: true,
                autoPlayInterval: 5000.ms,
                autoPlayAnimationDuration: 1500.ms,
                onPageChanged: (index, reason) => controller.currentCenter.value = index,
              ),
            ),
            crossFadeState: controller.featuredHeroes.isEmpty
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: 1000.ms,
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => AnimatedScale(
            duration: 300.ms,
            scale: controller.featuredHeroes.isEmpty ? 0 : 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.featuredHeroes
                  .asMap()
                  .entries
                  .map((kv) => PageIndicator(isActive: kv.key == controller.currentCenter.value))
                  .toList(),
            ),
          ),
        ),
        const SizedBox(height: 32),
        TitleWidget(
          "Last Heroes you viewed",
          tPadding: 16,
          more: "See All",
          onTap: () => Get.to(const LastHeroesScreen()),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Obx(
            () => controller.lastHeroes.isEmpty
                ? const Padding(
                    padding: EdgeInsets.only(top: 32),
                    child: EmptyWidget(),
                  )
                : ListView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    children:
                        controller.lastHeroes.sublist(0, min(controller.lastHeroes.length, 3)).map(
                      (superhero) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: SuperheroTile(
                            superhero: superhero,
                            icon: Icon(
                              Ionicons.close,
                              color: CColors.subtitleColor,
                              shadows: Const.shadows,
                            ),
                            onDeleted: () => controller.deleteHero(superhero.id),
                          ),
                        );
                      },
                    ).toList(),
                  ),
          ),
        ),
        const CompareSize(),
      ],
    );
  }
}
