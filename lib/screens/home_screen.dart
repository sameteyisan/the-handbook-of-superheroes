import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/screens/favorites_page.dart';
import 'package:the_handbook_of_superheroes/screens/featured_screen.dart';
import 'package:the_handbook_of_superheroes/utils/const.dart';
import 'package:the_handbook_of_superheroes/utils/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/compare_size.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_icon_button.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/home_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) async {
        if (didPop) return;

        final shouldPop = await controller.onWillPop();
        if (shouldPop && context.mounted) {
          Navigator.of(context).pop();
        }
      },
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            leading: Obx(
              () =>
                  controller.isAdmin.value
                      ? IconButton(
                        onPressed: () => Get.to(const FeaturedScreenn()),
                        icon: Icon(
                          Ionicons.shield_half_outline,
                          shadows: Const.shadows,
                          color: CColors.subtitleColor,
                        ),
                      ).animate().flip(delay: 100.ms)
                      : const SizedBox(),
            ),
            title: const Text("The Handbook of Superheroes").animate().flip(delay: 100.ms),
            actions: [
              IconButton(
                onPressed: () => Get.to(const FavoritesPage()),
                icon: Icon(Ionicons.heart, shadows: Const.shadows, color: CColors.textColor),
              ).animate().flip(delay: 100.ms),
            ],
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Flexible(
                      child: CustomTextField(
                        controller: controller.searchController,
                        hintText: "Search Superhero",
                        prefixIcon: Icon(
                          Ionicons.search,
                          shadows: Const.shadows,
                          color: CColors.textColor,
                        ),
                        suffixIcon: Obx(
                          () => AnimatedOpacity(
                            opacity: controller.searchText.value.isNotEmpty ? 1 : 0,
                            duration: 300.ms,
                            child: IconButton(
                              onPressed: controller.searchController.clear,
                              icon: Icon(
                                Ionicons.close,
                                shadows: Const.shadows,
                                color: CColors.subtitleColor,
                              ),
                              splashRadius: 20,
                            ),
                          ),
                        ),
                        onFieldSubmitted: (_) => controller.search(),
                      ).animate().flip(delay: 100.ms),
                    ),
                    Obx(
                      () => AnimatedSize(
                        duration: 300.ms,
                        child:
                            controller.superheroes.isNotEmpty
                                ? Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: CustomIconButton(
                                    backgroundColor: CColors.foregroundBlack,
                                    icon: AnimatedCrossFade(
                                      firstChild: Text(
                                        "A-Z",
                                        style: Styles.subtitle.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      secondChild: Text(
                                        "Z-A",
                                        style: Styles.subtitle.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      crossFadeState:
                                          controller.isDescending.value
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                      duration: 500.ms,
                                    ),
                                    onTap: controller.isDescending.toggle,
                                  ),
                                )
                                : const SizedBox(height: 46),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Obx(() {
                  if (controller.isLoading.value) {
                    return const EmptyWidget(text: "Loading heroes matching the search result...");
                  } else if (controller.superheroes.isEmpty && controller.isSearching.value) {
                    return const EmptyWidget(url: "superhero", text: "No hero found.");
                  } else if (controller.superheroes.isEmpty) {
                    return const HomeWidget();
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: GridView.count(
                          shrinkWrap: true,
                          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                          crossAxisCount: 2,
                          mainAxisSpacing: 32,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.7,
                          children:
                              controller.superheroes
                                  .map(
                                    (superhero) => SuperheroCard(
                                      superhero: superhero,
                                      extraOnTap: FocusScope.of(context).unfocus,
                                    ),
                                  )
                                  .toList(),
                        ),
                      ),
                      const CompareSize(),
                    ],
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
