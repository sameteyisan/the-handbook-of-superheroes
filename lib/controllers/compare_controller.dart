import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/models/powerstat.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';
import 'package:the_handbook_of_superheroes/utils/helper.dart';

class CompareController extends GetxController {
  final isLoading = true.obs;

  final powerstats = <PowerstatModel>[].obs;

  List<BasicHeroModel> heros;
  CompareController(this.heros);

  @override
  void onInit() async {
    for (final hero in heros) {
      final res = await Api.getPowerstats(hero.id);
      if (res == null) {
        Get.back();
        Helper.showError("The comparison could not be completed.");
        return;
      }
      powerstats.add(res);
    }

    isLoading.value = false;
    super.onInit();
  }

  (String, String, String) getData(int first, int second) {
    if (first == second) {
      return ("No Winner", "", "");
    } else if (first > second) {
      return (heros[0].name, heros[0].url, " +${first - second}");
    } else {
      return (heros[1].name, heros[1].url, " +${second - first}");
    }
  }
}
