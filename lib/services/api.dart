import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:the_handbook_of_superheroes/const.dart';
import 'package:the_handbook_of_superheroes/models/basic_hero.dart';
import 'package:the_handbook_of_superheroes/models/superhero.dart';
import 'package:the_handbook_of_superheroes/utils/extentions.dart';

class Api {
  static final firestore = FirebaseFirestore.instance;

  static Future<Dio> dioAuth() async {
    return Dio(
      BaseOptions(
        baseUrl: Const.apiUrl,
        connectTimeout: 20.seconds,
        receiveTimeout: 20.seconds,
        headers: {
          "Accept": "application/json",
        },
        responseType: ResponseType.json,
      ),
    );
  }

  // static Future<void> addFirestore(String id) async {
  //   try {
  //     final hero = await getSuperhero(id);
  //     await firestore.collection("featured").doc(hero!.id).set(
  //           BasicHeroModel(
  //             id: hero.id,
  //             name: hero.name,
  //             url: hero.image.url,
  //           ).toMap(),
  //         );
  //     print("${hero.id} Başarılı");
  //   } catch (_) {
  //     print("BAŞARISIZ");
  //   }
  // }

  // static Future<SuperheroModel?> getSuperhero(String id) async {
  //   try {
  //     final dio = await Api.dioAuth();
  //     Response response = await dio.get("/$id");
  //     if (response.statusCode == 200) {
  //       return SuperheroModel.fromMap(response.data);
  //     }
  //     return null;
  //   } catch (e) {
  //     debugPrint('Get Superhero Error : $e');
  //     return null;
  //   }
  // }

  static Future<SuperheroModel?> getSuperheroDetails(String id) async {
    try {
      final res = await firestore.collection("superheroes").doc(id).get();
      return SuperheroModel.fromMap(res.data()!);
    } catch (e) {
      debugPrint('Get Superhero Details Error : $e');
      return null;
    }
  }

  static Future<List<BasicHeroModel>> getSuperheros(String name) async {
    try {
      final superheroes = await firestore
          .collection("heroes")
          .where('name', isGreaterThanOrEqualTo: name.titleCase)
          .where('name', isLessThanOrEqualTo: '${name.titleCase}\uf8ff')
          .limit(20)
          .get();

      return superheroes.docs.map((e) => BasicHeroModel.fromMap(e.data())).toList();

      // final dio = await Api.dioAuth();
      // Response response = await dio.get("/search/$name", cancelToken: canceler);
      // if (response.statusCode == 200) {
      //   List<dynamic> superheroes = response.data["results"] ?? [];
      //   return superheroes.map((e) => SuperheroModel.fromMap(e)).toList();
      // }
      // return [];
    } catch (e, stacktrace) {
      print(stacktrace);
      // if (canceler != null && canceler.isCancelled) {
      //   return null;
      // }
      debugPrint('Get Superheros Error : $e');
      return [];
    }
  }

  static Future<List<BasicHeroModel>> getFeaturedHeroes() async {
    try {
      final res = await firestore.collection("featured").get();
      return res.docs.map((e) => BasicHeroModel.fromMap(e.data())).toList();
    } catch (e) {
      debugPrint('Get Featured Heroes Error : $e');
      return [];
    }
  }
}
