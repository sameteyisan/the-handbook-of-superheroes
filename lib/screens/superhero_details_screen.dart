import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/controllers/superhero_details_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_back_button.dart';
import 'package:the_handbook_of_superheroes/widgets/custom_network_image.dart';
import 'package:the_handbook_of_superheroes/widgets/detail_panel.dart';
import 'package:the_handbook_of_superheroes/widgets/title_widget.dart';

class SuperheroesDetailsScreen extends StatelessWidget {
  const SuperheroesDetailsScreen({super.key, required this.hero});
  final BasicHeroModel hero;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SuperheroDetailsController(hero.id));

    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackButton(),
        title: Text(hero.name),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Center(child: Hero(tag: "hero-${hero.id}", child: CustomNetworkImage(url: hero.url))),
          Obx(() => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.superhero.value == null
                  ? const Text("Something went wrong")
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
                            .map((kv) => DetailPanel(kv: kv)),
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
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
