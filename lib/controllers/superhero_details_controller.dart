import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_handbook_of_superheroes/controllers/favorites_controller.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';
import 'package:the_handbook_of_superheroes/utils/helper.dart';

class SuperheroDetailsController extends GetxController {
  final superhero = Rxn<SuperheroModel>();

  final isLoading = false.obs;
  final isFavorite = false.obs;

  String id;
  SuperheroDetailsController(this.id);
  @override
  void onInit() {
    final keys = Hive.box("favorites").keys.toList();
    final res = keys.firstWhereOrNull((e) => e == id);
    isFavorite.value = res != null;

    fetch();
    super.onInit();
  }

  void fetch() async {
    isLoading.value = true;
    superhero.value = await Api.getSuperheroDetails(id);
    isLoading.value = false;
  }

  void compare(BasicHeroModel hero) {
    final controller = HomeController.to;

    if (controller.versusHeroes.length >= 2) {
      Helper.showError("You can compare a maximum of two superheroes.");
      return;
    }

    final res = controller.versusHeroes.firstWhereOrNull((e) => e.id == hero.id);
    if (res == null) {
      controller.versusHeroes.add(hero);
    }
  }

  void favoriteToggle(BasicHeroModel hero) async {
    final box = Hive.box("favorites");
    if (isFavorite.value) {
      await box.delete(hero.id);
      isFavorite.value = false;
      try {
        FavoritesController.to.heroes.removeWhere((e) => e.id == hero.id);
      } catch (_) {}
    } else {
      box.put(
        hero.id,
        hero.copyWith(date: DateTime.now(), isFavorite: true).toJson(),
      );
      isFavorite.value = true;
      try {
        FavoritesController.to.heroes.removeWhere((e) => e.id == hero.id);
        FavoritesController.to.heroes
            .insert(0, hero.copyWith(date: DateTime.now(), isFavorite: true));
      } catch (_) {}
    }
  }
}
