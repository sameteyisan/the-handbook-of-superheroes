import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';
import 'package:the_handbook_of_superheroes/widgets/modals/yes_no_modal.dart';

class FeaturedController extends GetxController {
  final featured = <BasicHeroModel>[].obs;
  final tempFeatured = <BasicHeroModel>[].obs;
  final superheroes = <BasicHeroModel>[].obs;

  final searchController = TextEditingController();

  final searchText = "".obs;

  @override
  void onInit() async {
    ever(searchText, (name) async {
      if (name.isEmpty) {
        superheroes.clear();
      }
    });

    searchController.addListener(listener);

    featured.value = await Api.getFeaturedHeroes();

    tempFeatured.addAll(featured);
    super.onInit();
  }

  @override
  void onClose() {
    searchController.removeListener(listener);

    searchController.dispose();
    super.onClose();
  }

  void fetch() async {
    if (searchText.value.isEmpty) return;
    superheroes.value = await Api.getSuperheros(searchText.value);
  }

  void listener() {
    final search = searchController.text.trim();
    if (search == searchText.value) return;
    searchText.value = search;
  }

  void addOrRemove(BasicHeroModel hero, bool isHave) async {
    if (isHave) {
      final res = await YesNoModal.open(
          "This superhero is already in the spotlight. You want to take it out?");
      if (res != null) {
        featured.removeWhere((e) => e.id == hero.id);
      }
    } else {
      featured.add(hero);
    }
  }

  void save() async {
    EasyLoading.show(maskType: EasyLoadingMaskType.clear);

    for (final hero in tempFeatured) {
      await Api.deleteFeaturedHeroes(hero);
    }

    for (final hero in featured) {
      await Api.setFeaturedHeroes(hero);
    }

    EasyLoading.dismiss();
    Get.back();
  }
}
