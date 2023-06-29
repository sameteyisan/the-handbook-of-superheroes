import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/superhero_details_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/ads_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/center_loading.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_size.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_icon_button.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_ink_well.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';
import 'package:the_handbook_of_superheroes/widgets/detail_panel.dart';
import 'package:the_handbook_of_superheroes/widgets/powerstats.dart';
import 'package:the_handbook_of_superheroes/widgets/title_widget.dart';

class SuperheroesDetailsScreen extends StatelessWidget {
  const SuperheroesDetailsScreen(
      {super.key, required this.hero, this.isCard = true, this.showCompare = true});
  final BasicHeroModel hero;
  final bool isCard;
  final bool showCompare;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuperheroDetailsController(hero.id));
    final homeController = HomeController.to;

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(hero.name).animate().flip(delay: 100.ms),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: CustomNetworkImage(url: hero.url).animate().flipH(delay: 200.ms),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (showCompare)
                    Obx(
                      () {
                        final isHave =
                            homeController.versusHeroes.firstWhereOrNull((e) => e.id == hero.id) !=
                                null;
                        return AnimatedOpacity(
                          opacity: isHave ? 0.2 : 1,
                          duration: 300.ms,
                          child: Center(
                            child: CustomInkWell(
                              radius: 24,
                              onTap: isHave ? null : () => controller.compare(hero),
                              child: AnimatedContainer(
                                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                                duration: 300.ms,
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.6),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                  color: CColors.foregroundBlack,
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  "Add to Compare",
                                  style: TextStyle(
                                    color: CColors.textColor,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  const SizedBox(width: 16),
                  CustomIconButton(
                    backgroundColor: CColors.subtitleColor,
                    size: 36,
                    radius: 12,
                    icon: Obx(
                      () => AnimatedCrossFade(
                        firstChild: Icon(
                          Ionicons.heart,
                          color: CColors.red,
                        ),
                        secondChild: const Icon(
                          Ionicons.heart_outline,
                          color: CColors.backgroundcolor,
                        ),
                        crossFadeState: controller.isFavorite.value
                            ? CrossFadeState.showFirst
                            : CrossFadeState.showSecond,
                        duration: 300.ms,
                      ),
                    ),
                    onTap: () => controller.favoriteToggle(hero),
                  )
                ],
              ).animate().flip(delay: 300.ms),
              Obx(() => AnimatedSize(
                    duration: 300.microseconds,
                    child: controller.bannerAd.value != null
                        ? Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: AdsWidget(bannerAd: controller.bannerAd.value!),
                          )
                        : const SizedBox(),
                  )),
              Obx(() => controller.isLoading.value
                  ? const Padding(
                      padding: EdgeInsets.only(top: 32),
                      child: CenterLoading(),
                    )
                  : controller.superhero.value == null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 32),
                            child: Column(
                              children: [
                                Text(
                                  "The information is currently inaccessible. Why don't we try again?",
                                  style: Styles.title.copyWith(fontSize: 17.sp),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 8),
                                ElevatedButton(
                                  onPressed: controller.fetch,
                                  child: const Text("Try Again"),
                                )
                              ],
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: TitleWidget("Biography"),
                            ),
                            ...controller.superhero.value!.biography
                                .toMap()
                                .entries
                                .map((kv) => DetailPanel(kv: kv)),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: TitleWidget("Powerstats"),
                            ),
                            ...controller.superhero.value!.powerstats
                                .toMap()
                                .entries
                                .map((kv) => PowerStats(kv: kv)),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: TitleWidget("Appearance"),
                            ),
                            ...controller.superhero.value!.appearance
                                .toMap()
                                .entries
                                .map((kv) => DetailPanel(kv: kv)),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 16),
                              child: TitleWidget("Connections"),
                            ),
                            ...controller.superhero.value!.connections
                                .toMap()
                                .entries
                                .map((kv) => DetailPanel(kv: kv)),
                          ],
                        )),
              const CompareSize(),
            ],
          ),
          if (showCompare) const CompareWidget(),
        ],
      ),
    );
  }
}
