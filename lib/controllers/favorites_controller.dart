import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';

class FavoritesController extends GetxController {
  final heroes = <BasicHeroModel>[].obs;

  @override
  void onInit() {
    final box = Hive.box("favorites");
    for (final key in box.keys) {
      final value = box.get(key);
      final hero = BasicHeroModel.fromJson(value);
      heroes.add(hero);
    }

    heroes.sort((a, b) => b.date!.millisecondsSinceEpoch - a.date!.millisecondsSinceEpoch);
    super.onInit();
  }

  void favoriteToggle(int index) async {
    final box = Hive.box("favorites");

    if (heroes[index].isFavorite != null) {
      await box.delete(heroes[index].id);
      heroes[index] = heroes[index].copyWith(isFavorite: null);
    } else {
      box.put(heroes[index].id,
          heroes[index].copyWith(date: DateTime.now(), isFavorite: true).toJson());
      heroes[index] = heroes[index].copyWith(isFavorite: true);
    }
    heroes.refresh();
  }
}
