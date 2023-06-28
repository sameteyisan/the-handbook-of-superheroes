import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/placeholder_superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';

class CompareWidget extends GetView<HomeController> {
  const CompareWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AnimatedSize(
        duration: 300.milliseconds,
        child: controller.versusHeroes.isNotEmpty
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        CColors.foregroundBlack,
                        CColors.foregroundBlack.withOpacity(0.6),
                        CColors.foregroundBlack.withOpacity(0.4),
                        CColors.foregroundBlack.withOpacity(0.6),
                        CColors.foregroundBlack,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
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
                          "Versus Heroes",
                          style: Styles.title
                              .copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SuperheroCard(
                              superhero: controller.versusHeroes[0],
                              urlSize: 150.h,
                              iconSize: 40,
                              onDeleted: () => controller.versusHeroes.removeAt(0),
                              heroAnimation: false,
                            ),
                            Lottie.asset(
                              "assets/lotties/batman.json",
                              width: 100.w,
                            ),
                            if (controller.versusHeroes.length > 1)
                              SuperheroCard(
                                superhero: controller.versusHeroes[1],
                                urlSize: 150.h,
                                iconSize: 40,
                                onDeleted: () => controller.versusHeroes.removeAt(1),
                                heroAnimation: false,
                              )
                            else
                              PlaceholderSuperheroCard(
                                height: 155.h,
                                width: 118.w,
                              ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(
                width: double.infinity,
              ),
      ),
    );
  }
}
