import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/controllers/home_controller.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';
import 'package:the_handbook_of_superheroes/utils/helper.dart';

class SuperheroDetailsController extends GetxController {
  final superhero = Rxn<SuperheroModel>();

  final isLoading = false.obs;

  String id;
  SuperheroDetailsController(this.id);
  @override
  void onInit() {
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
}
