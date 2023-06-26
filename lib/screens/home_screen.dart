import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/screens/superhero_details_screen.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/page_indicator.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/text_field.dart';
import 'package:the_handbook_of_superheroes/widgets/title_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("The Handbook of Superheroes"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomTextField(
                controller: controller.searchController,
                hintText: "Search Superhero",
                prefixIcon: const Icon(Ionicons.search),
                suffixIcon: Obx(
                  () => AnimatedOpacity(
                    opacity: controller.searchText.value.isNotEmpty ? 1 : 0,
                    duration: 300.milliseconds,
                    child: IconButton(
                      onPressed: controller.searchController.clear,
                      icon: const Icon(Ionicons.close),
                      splashRadius: 20.sp,
                    ),
                  ),
                ),
                onFieldSubmitted: (_) => controller.search(),
              ),
              Expanded(
                child: Obx(
                  () => controller.isLoading.value
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Lottie.asset("assets/lotties/batman.json", width: Get.width * 0.4),
                            const SizedBox(height: 16),
                            Text(
                              "Loading heroes matching the search result...",
                              style: Styles.title.copyWith(fontSize: 17.sp),
                            ),
                          ],
                        )
                      : controller.superheroes.isEmpty && controller.isSearching.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/lotties/superhero.json",
                                    width: Get.width * 0.4),
                                const SizedBox(height: 16),
                                Text(
                                  "No hero found.",
                                  style: Styles.title.copyWith(fontSize: 17.sp),
                                ),
                              ],
                            )
                          : controller.superheroes.isEmpty
                              ? Column(
                                  children: [
                                    const SizedBox(height: 32),
                                    const TitleWidget("Featured Superheroes"),
                                    const SizedBox(height: 16),
                                    Obx(
                                      () => CarouselSlider(
                                        key: const PageStorageKey("featured-carousel"),
                                        options: CarouselOptions(
                                          viewportFraction: 0.5,
                                          height: 200.h,
                                          scrollPhysics: const BouncingScrollPhysics(),
                                          autoPlay: true,
                                          autoPlayInterval: 5.seconds,
                                          autoPlayAnimationDuration: 1500.milliseconds,
                                          onPageChanged: (index, reason) =>
                                              controller.currentCenter.value = index,
                                        ),
                                        items: controller.featuredHeroes
                                            .map((e) => SuperheroCard(
                                                  superhero: e,
                                                  onTap: () =>
                                                      Get.to(SuperheroesDetailsScreen(hero: e)),
                                                ))
                                            .toList(),
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
                                              .map((kv) => PageIndicator(
                                                  isActive:
                                                      kv.key == controller.currentCenter.value))
                                              .toList(),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 32),
                                    const TitleWidget("Last Heroes you viewed")
                                  ],
                                )
                              : GridView.count(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 32,
                                  crossAxisSpacing: 16,
                                  childAspectRatio: 0.7,
                                  children: controller.superheroes
                                      .map(
                                        (superhero) => SuperheroCard(
                                            superhero: superhero,
                                            onTap: () {
                                              FocusScope.of(context).unfocus();
                                              Get.to(
                                                SuperheroesDetailsScreen(
                                                  hero: superhero,
                                                ),
                                              );
                                            }),
                                      )
                                      .toList(),
                                ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
