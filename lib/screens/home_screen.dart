import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:lottie/lottie.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/screens/superhero_details_screen.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/text_field.dart';

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
              ),
              const SizedBox(height: 16),
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
                      : controller.superheroes.isEmpty
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Lottie.asset("assets/lotties/superhero.json",
                                    width: Get.width * 0.4),
                                const SizedBox(height: 16),
                                Text(
                                  controller.searchText.value.isEmpty
                                      ? "Start looking for a hero now."
                                      : "No hero found.",
                                  style: Styles.title.copyWith(fontSize: 17.sp),
                                ),
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
                                            SuperheroesDetailsScreen(superhero: superhero),
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
