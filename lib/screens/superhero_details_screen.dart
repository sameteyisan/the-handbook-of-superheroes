import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/superhero_details_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/center_loading.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_ink_well.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';
import 'package:the_handbook_of_superheroes/widgets/detail_panel.dart';
import 'package:the_handbook_of_superheroes/widgets/powerstats.dart';
import 'package:the_handbook_of_superheroes/widgets/title_widget.dart';

class SuperheroesDetailsScreen extends StatelessWidget {
  const SuperheroesDetailsScreen({super.key, required this.hero, this.isCard = true});
  final BasicHeroModel hero;
  final bool isCard;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuperheroDetailsController(hero.id));
    final homeController = HomeController.to;

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(hero.name),
      ),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Center(
                child: Hero(
                  tag: "hero${isCard ? "card" : "tile"}-${hero.id}",
                  child: CustomNetworkImage(url: hero.url),
                ),
              ),
              const SizedBox(height: 16),
              Obx(
                () => AnimatedOpacity(
                  opacity:
                      homeController.versusHeroes.firstWhereOrNull((e) => e.id == hero.id) == null
                          ? 1
                          : 0.2,
                  duration: 300.milliseconds,
                  child: Center(
                    child: CustomInkWell(
                      radius: 24,
                      onTap: () => controller.compare(hero),
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                        duration: 300.milliseconds,
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
                          "Compare",
                          style: TextStyle(
                            color: CColors.textColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
              Obx(
                () => AnimatedContainer(
                  duration: 300.milliseconds,
                  height: homeController.versusHeroes.isNotEmpty ? 250.h : 32,
                ),
              ),
            ],
          ),
          const CompareWidget(),
        ],
      ),
    );
  }
}
