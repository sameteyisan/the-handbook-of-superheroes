import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/theme.dart';
import 'package:the_handbook_of_superheroes/widgets/empty_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/home_widget.dart';
import 'package:the_handbook_of_superheroes/widgets/superhero_card.dart';
import 'package:the_handbook_of_superheroes/widgets/text_field.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return WillPopScope(
      onWillPop: controller.onWillPop,
      child: GestureDetector(
        onTap: FocusScope.of(context).unfocus,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("The Handbook of Superheroes"),
          ),
          body: Column(
            children: [
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
                  onFieldSubmitted: (_) => controller.search(),
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
                  return GridView.count(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
                    crossAxisCount: 2,
                    mainAxisSpacing: 32,
                    crossAxisSpacing: 16,
                    childAspectRatio: 0.7,
                    children: controller.superheroes
                        .map(
                          (superhero) => SuperheroCard(
                            superhero: superhero,
                            extraOnTap: FocusScope.of(context).unfocus,
                          ),
                        )
                        .toList(),
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
