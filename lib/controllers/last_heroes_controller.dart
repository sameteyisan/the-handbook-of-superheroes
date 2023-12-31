import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/utils/helper.dart';
import 'package:the_handbook_of_superheroes/widgets/modals/warning_modal.dart';

class LastHeroesController extends GetxController {
  final heroes = <BasicHeroModel>[].obs;

  final bannerAds = <BannerAd?>[].obs;

  @override
  void onInit() {
    final box = Hive.box("last-heroes");
    for (final key in box.keys) {
      final value = box.get(key);
      final hero = BasicHeroModel.fromJson(value);
      heroes.add(hero);
    }

    heroes.sort((a, b) => b.date!.millisecondsSinceEpoch - a.date!.millisecondsSinceEpoch);

    for (int i = 0; i < heroes.length; i++) {
      if (i != 0 && i % 6 == 0) {
        bannerAds.add(Helper.getAd);
      } else {
        bannerAds.add(null);
      }
    }
    super.onInit();
  }

  @override
  void onClose() {
    for (final ad in bannerAds) {
      ad?.dispose();
    }
    super.onClose();
  }

  void deleteAll() async {
    final res = await WarningModal.open("Are you sure you want to remove all the heroes?");
    if (res != null) {
      final box = Hive.box("last-heroes");
      box.deleteAll(box.keys);
      heroes.clear();
      HomeController.to.lastHeroes.clear();
      Helper.showToast("All heroes have been removed.");
    }
  }

  void removeHero(String id) async {
    final res = await WarningModal.open("Are you sure you want to remove this superhero?");

    if (res != null) {
      final box = Hive.box("last-heroes");
      box.delete(id);
      heroes.removeWhere((e) => e.id == id);
      HomeController.to.lastHeroes.removeWhere((e) => e.id == id);
      Helper.showToast("Successfully removed.");
    }
  }
}
