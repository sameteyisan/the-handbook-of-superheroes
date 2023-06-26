import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';

class SuperheroDetailsController extends GetxController {
  final superhero = Rxn<SuperheroModel>();

  final isLoading = false.obs;

  String id;
  SuperheroDetailsController(this.id);
  @override
  void onInit() async {
    isLoading.value = true;
    superhero.value = await Api.getSuperheroDetails(id);
    isLoading.value = false;
    super.onInit();
  }
}
