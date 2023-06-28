import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  // final superhero = Rxn<SuperheroModel>();
  final superheroes = <BasicHeroModel>[].obs;
  final featuredHeroes = <BasicHeroModel>[].obs;
  final versusHeroes = <BasicHeroModel>[].obs;

  final isAdmin = false.obs;
  final isLoading = false.obs;
  final isSearching = false.obs;
  final isDescending = false.obs;

  final searchController = TextEditingController();

  final searchText = "".obs;

  final currentCenter = 0.obs;

  // CancelToken? canceler;

  @override
  void onInit() async {
    final deviceID = await getDeviceID();
    print(deviceID);

    if (deviceID.isNotEmpty) {
      isAdmin.value = await Api.getAdminData(deviceID);
    }

    featuredHeroes.value = await Api.getFeaturedHeroes();

    searchController.addListener(listener);

    ever(isDescending, (_) => search());

    ever(searchText, (name) async {
      // isLoading.value = true;
      if (name.isEmpty) {
        superheroes.clear();
        isLoading.value = false;
        isSearching.value = false;
        return;
      }
      // canceler?.cancel();
      // canceler = CancelToken();
      // final res = await Api.getSuperheros(name, canceler!);
      // if (res == null) {
      //   return;
      // }
      // superheroes.value = res;
      // isLoading.value = false;
    });

    // superhero.value = await Api.getSuperhero("2"); // between 0 and 732

    // isLoading.value = false;

    super.onInit();
  }

  @override
  void onClose() {
    searchController.removeListener(listener);

    searchController.dispose();
    // canceler?.cancel();
    super.onClose();
  }

  void listener() {
    final search = searchController.text.trim();
    if (search == searchText.value) return;
    searchText.value = search;
  }

  void search() async {
    isSearching.value = true;
    if (searchText.value.isEmpty) return;
    isLoading.value = true;
    superheroes.value = await Api.getSuperheros(searchText.value, descending: isDescending.value);
    isLoading.value = false;
  }

  Future<bool> onWillPop() async {
    if (superheroes.isNotEmpty) {
      searchController.clear();
      superheroes.clear();
      isLoading.value = false;
      isSearching.value = false;
      return false;
    }
    return true;
  }

  Future<String> getDeviceID() async {
    final deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      final iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor ?? "";
    } else if (Platform.isAndroid) {
      final androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id;
    }
    return "";
  }
}
