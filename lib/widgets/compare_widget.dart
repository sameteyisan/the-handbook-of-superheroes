import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/screens/compare_screeen.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_button.dart';
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
                          "Compare Heroes",
                          style: Styles.title
                              .copyWith(fontWeight: FontWeight.bold, letterSpacing: 1.5),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SuperheroCard(
                              superhero: controller.versusHeroes[0],
                              urlSize: 150.h,
                              iconSize: 40,
                              onDeleted: () => controller.versusHeroes.removeAt(0),
                              heroAnimation: false,
                            ),
                            Stack(
                              children: [
                                Lottie.asset("assets/lotties/batman.json", width: 100.w),
                                Positioned.fill(
                                  child: Center(
                                    child: Text(
                                      "VS",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ),
                                )
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
                              PlaceholderSuperheroCard(
                                width: 112.w,
                                height: 150,
                              ),
                          ],
                        ),
                        AnimatedSize(
                          duration: 300.milliseconds,
                          child: controller.versusHeroes.length >= 2
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, right: 16, top: 16, bottom: 8),
                                  child: CustomButton(
                                    text: "Compare",
                                    onPressed: controller.versusHeroes.length >= 2
                                        ? () => Get.to(
                                              ComprateScreen(heros: controller.versusHeroes),
                                            )
                                        : null,
                                  ),
                                )
                              : const SizedBox(width: double.infinity),
                        )
                      ],
                    ),
                  ),
                ),
              )
            : const SizedBox(width: double.infinity),
      ),
    );
  }
}
