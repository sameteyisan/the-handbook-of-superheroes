import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/featured_controller.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/placeholder_superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_tile.dart';
import 'package:the_handbook_of_superheroes/widgets/text_field.dart';

class FeaturedScreenn extends StatelessWidget {
  const FeaturedScreenn({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeaturedController());

    return Scaffold(
        appBar: AppBar(
          leading: const CustomBackButton(),
          title: const Text("Featured"),
          actions: [
            Obx(
              () => controller.featured.length > 2
                  ? IconButton(
                      onPressed: controller.save,
                      icon: const Icon(
                        Ionicons.save_outline,
                        color: CColors.textColor,
                      ),
                    )
                  : const SizedBox(),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(height: 16),
            Obx(
              () => !controller.isLoading.value && controller.featured.isEmpty
                  ? const EmptyWidget(text: "There is no superhero that featured.")
                  : Obx(
                      () => AnimatedCrossFade(
                        firstChild: CarouselSlider(
                          key: const PageStorageKey("featured-carousel"),
                          items: List.generate(5, (index) => const PlaceholderSuperheroCard()),
                          options: CarouselOptions(
                            viewportFraction: 0.52,
                            height: 260.h,
                            scrollPhysics: const BouncingScrollPhysics(),
                          ),
                        ),
                        secondChild: CarouselSlider(
                          key: const PageStorageKey("featured"),
                          options: CarouselOptions(
                            viewportFraction: 0.52,
                            enableInfiniteScroll: false,
                            height: 260.h,
                            scrollPhysics: const BouncingScrollPhysics(),
                            autoPlay: true,
                            autoPlayInterval: 5.seconds,
                            autoPlayAnimationDuration: 1500.milliseconds,
                          ),
                          items: controller.featured
                              .map((hero) => SuperheroCard(
                                    superhero: hero,
                                    isDeleted: true,
                                    onDeleted: () {
                                      controller.featured.removeWhere((e) => e.id == hero.id);
                                    },
                                  ))
                              .toList(),
                        ),
                        crossFadeState: controller.featured.isEmpty
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: 1.seconds,
                      ),
                    ),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.all(16),
              child: CustomTextField(
                controller: controller.searchController,
                hintText: "Search Superhero",
                prefixIcon: const Icon(
                  Ionicons.search,
                  color: CColors.textColor,
                ),
                suffixIcon: Obx(
                  () => AnimatedOpacity(
                    opacity: controller.searchText.value.isNotEmpty ? 1 : 0,
                    duration: 300.milliseconds,
                    child: IconButton(
                      onPressed: controller.searchController.clear,
                      icon: const Icon(
                        Ionicons.close,
                        color: CColors.subtitleColor,
                      ),
                      splashRadius: 20.sp,
                    ),
                  ),
                ),
                onFieldSubmitted: (_) => controller.fetch(),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(
                  () => controller.superheroes.isEmpty
                      ? const EmptyWidget(text: "Pick a superhero now.")
                      : ListView(
                          shrinkWrap: true,
                          children: controller.superheroes.map(
                            (e) {
                              final isHave = controller.featured
                                  .where((p0) => p0.id == e.id)
                                  .toList()
                                  .isNotEmpty;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: SuperheroTile(
                                  superhero: e,
                                  icon: Ionicons.checkmark,
                                  iconColor: isHave ? CColors.mainColor : null,
                                  onDeleted: () => controller.addOrRemove(e, isHave),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                ),
              ),
            )
          ],
        ));
  }
}
