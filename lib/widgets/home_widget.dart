import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/screens/last_heroes_screen.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/modals/delete_modal.dart';
import 'package:the_handbook_of_superheroes/widgets/page_indicator.dart';
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
          () => CarouselSlider(
            key: const PageStorageKey("featured-carousel"),
            options: CarouselOptions(
              viewportFraction: 0.52,
              height: 260.h,
              scrollPhysics: const BouncingScrollPhysics(),
              autoPlay: true,
              autoPlayInterval: 5.seconds,
              autoPlayAnimationDuration: 1500.milliseconds,
              onPageChanged: (index, reason) => controller.currentCenter.value = index,
            ),
            items: controller.featuredHeroes.map((e) => SuperheroCard(superhero: e)).toList(),
          ),
        ),
        const SizedBox(height: 16),
        Obx(
          () => AnimatedScale(
            duration: 300.milliseconds,
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
          child: ValueListenableBuilder(
            valueListenable: Hive.box("last-heroes").listenable(),
            child: const Padding(
              padding: EdgeInsets.only(top: 32),
              child: EmptyWidget(),
            ),
            builder: (context, box, child) {
              if (box.isEmpty) {
                return child!;
              }
              return ListView(
                padding: const EdgeInsets.symmetric(vertical: 16),
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                reverse: true,
                children: box.keys.toList().sublist(0, min(box.keys.length, 3)).map(
                  (key) {
                    final superhero = BasicHeroModel.fromJson(box.get(key));

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: SuperheroTile(
                        superhero: superhero,
                        onDeleted: () async {
                          final res = await DeleteModal.open();
                          if (res != null) {
                            final box = Hive.box("last-heroes");
                            box.delete(superhero.id);
                          }
                        },
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
