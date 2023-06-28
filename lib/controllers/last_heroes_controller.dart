import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/utils/helper.dart';
import 'package:the_handbook_of_superheroes/widgets/modals/delete_modal.dart';

class LastHeroesController extends GetxController {
  final heroes = <BasicHeroModel>[].obs;

  @override
  void onInit() {
    final box = Hive.box("last-heroes");
    for (final key in box.keys) {
      final value = box.get(key);
      final hero = BasicHeroModel.fromJson(value);
      heroes.add(hero);
    }

    heroes.sort((a, b) => b.date!.millisecondsSinceEpoch - a.date!.millisecondsSinceEpoch);
    super.onInit();
  }

  void deleteAll() async {
    final res = await DeleteModal.open(text: "Are you sure you want the whole thing deleted?");
    if (res != null) {
      final box = Hive.box("last-heroes");
      box.deleteAll(box.keys);
      heroes.clear();
      Helper.showToast("The cleaning process is successful.");
    }
  }

  void deleteHero(String id) async {
    final res = await DeleteModal.open();
    if (res != null) {
      final box = Hive.box("last-heroes");
      box.delete(id);
      heroes.removeWhere((e) => e.id == id);
      Helper.showToast("The deletion was successful.");
    }
  }
}
