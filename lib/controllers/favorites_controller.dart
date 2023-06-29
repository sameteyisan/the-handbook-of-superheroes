import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive/hive.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/utils/helper.dart';

class FavoritesController extends GetxController {
  static FavoritesController get to => Get.find();

  final heroes = <BasicHeroModel>[].obs;

  final bannerAds = <BannerAd?>[].obs;

  @override
  void onInit() async {
    final box = Hive.box("favorites");
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
