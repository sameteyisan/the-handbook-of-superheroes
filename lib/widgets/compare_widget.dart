import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_button.dart';
import 'package:the_handbook_of_superheroes/widgets/placeholder_superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';

class CompareWidget extends GetView<HomeController> {
  const CompareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () =>
          controller.versusHeroes.isNotEmpty
              ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        CColors.foregroundBlack,
                        CColors.foregroundBlack.withValues(alpha: 0.6),
                        CColors.foregroundBlack.withValues(alpha: 0.4),
                        CColors.foregroundBlack.withValues(alpha: 0.6),
                        CColors.foregroundBlack,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.6),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: const Offset(0.0, 0.0),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Compare Heroes",
                          style: Styles.title.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SuperheroCard(
                              superhero: controller.versusHeroes[0],
                              urlSize: 150,
                              iconSize: 40,
                              onDeleted: () => controller.versusHeroes.removeAt(0),
                              heroAnimation: false,
                            ),
                            Stack(
                              children: [
                                Lottie.asset("assets/lotties/batman.json", width: 100),
                                const Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      "VS",
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (controller.versusHeroes.length > 1)
                              SuperheroCard(
                                superhero: controller.versusHeroes[1],
                                urlSize: 150,
                                iconSize: 40,
                                onDeleted: () => controller.versusHeroes.removeAt(1),
                                heroAnimation: false,
                              )
                            else
                              const PlaceholderSuperheroCard(width: 112, height: 150),
                          ],
                        ),
                        AnimatedSize(
                          duration: 300.ms,
                          child:
                              controller.versusHeroes.length >= 2
                                  ? Padding(
                                    padding: const EdgeInsets.only(
                                      left: 16,
                                      right: 16,
                                      top: 16,
                                      bottom: 8,
                                    ),
                                    child: CustomButton(
                                      text: "Compare",
                                      onPressed:
                                          controller.versusHeroes.length >= 2
                                              ? controller.compare
                                              : null,
                                    ),
                                  ).animate().flipH(delay: 200.ms)
                                  : const SizedBox(width: double.infinity),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().flipH()
              : const SizedBox(width: double.infinity),
    );
  }
}
