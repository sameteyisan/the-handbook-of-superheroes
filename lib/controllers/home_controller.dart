import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/screens/compare_screeen.dart';
import 'package:the_handbook_of_superheroes/services/api.dart';
import 'package:the_handbook_of_superheroes/utils/helper.dart';
import 'package:the_handbook_of_superheroes/widgets/modals/warning_modal.dart';

class HomeController extends GetxController {
  static HomeController get to => Get.find();

  final lastHeroes = <BasicHeroModel>[].obs;
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

  final bannerAd = Rxn<BannerAd>();

  @override
  void onInit() async {
    final box = Hive.box("last-heroes");
    for (final key in box.keys) {
      final value = box.get(key);
      final hero = BasicHeroModel.fromJson(value);
      lastHeroes.add(hero);
    }

    lastHeroes.sort((a, b) => b.date!.millisecondsSinceEpoch - a.date!.millisecondsSinceEpoch);

    final deviceID = await getDeviceID();

    if (deviceID.isNotEmpty) {
      isAdmin.value = await Api.getAdminData(deviceID);
    }

    featuredHeroes.value = await Api.getFeaturedHeroes();

    searchController.addListener(listener);

    ever(isDescending, (_) => search());

    ever(searchText, (name) async {
      if (name.isEmpty) {
        superheroes.clear();
        isLoading.value = false;
        isSearching.value = false;
        return;
      }
    });

    bannerAd.value = Helper.getAd;

    super.onInit();
  }

  @override
  void onClose() {
    searchController.removeListener(listener);

    searchController.dispose();
    bannerAd.value?.dispose();
    bannerAd.value = null;
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

  void removeHero(String id) async {
    final res = await WarningModal.open("Are you sure you want to remove this superhero?");
    if (res != null) {
      final box = Hive.box("last-heroes");
      box.delete(id);
      lastHeroes.removeWhere((e) => e.id == id);
      Helper.showToast("Successfully removed.");
    }
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

  void compare() {
    final heros = versusHeroes.map((e) => e.copyWith()).toList();
    versusHeroes.clear();

    Get.to(ComprateScreen(heros: heros));
  }
}
