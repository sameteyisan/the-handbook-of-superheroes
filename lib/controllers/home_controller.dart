import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';

class HomeController extends GetxController {
  // final superhero = Rxn<SuperheroModel>();
  final superheroes = <SuperheroModel>[].obs;

  final isLoading = false.obs;

  final searchController = TextEditingController();

  final searchText = "".obs;

  CancelToken? canceler;

  @override
  void onInit() async {
    searchController.addListener(listener);

    ever(searchText, (name) async {
      isLoading.value = true;
      if (name.isEmpty) {
        superheroes.clear();
        isLoading.value = false;
        return;
      }
      canceler?.cancel();
      canceler = CancelToken();
      final res = await Api.getSuperheros(name, canceler!);
      if (res == null) {
        return;
      }
      superheroes.value = res;
      isLoading.value = false;
    });

    // superhero.value = await Api.getSuperhero("2"); // between 0 and 732

    // isLoading.value = false;

    super.onInit();
  }

  @override
  void onClose() {
    searchController.removeListener(listener);

    searchController.dispose();
    canceler?.cancel();
    super.onClose();
  }

  void listener() {
    final search = searchController.text.trim();
    if (search == searchText.value) return;
    searchText.value = search;
  }
}
